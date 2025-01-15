import 'dart:convert';

import 'package:book_store/feature/shop/controller/NetworkHelper.dart';
import 'package:book_store/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:iconsax/iconsax.dart';


class UpdateBookPage extends StatefulWidget {
  const UpdateBookPage({super.key, required this.book});

  final Map<String , dynamic> book;
  @override
  State<UpdateBookPage> createState() => _UpdateBookPageState();
}

class _UpdateBookPageState extends State<UpdateBookPage> {

  List categories = [];
  List authors = [];
  String _selectedCategory = "";
  String _selectedAuthor = "";
  String bookName = '';
  String price = '';
  String quantity = '';
  String description = "";
  String bookID = "";

  Future<http.Response> _getCategories() async {
    final http.Response response =
        await Network().postData({"O": "0", "S": "19"}, '/getCategories.php');

    // print('response ---- ${jsonDecode(response.body)}');

    setState(() {
      var res = jsonDecode(response.body);
      setState(() {
        categories = res['categories'];
       
      });
    });
    return response;
  }

  Future<http.Response> _getAuthors() async {
    final http.Response response =
        await Network().postData({'name': ''}, '/getAuthors.php');

    // print('response ---- ${jsonDecode(response.body)}');

    setState(() {
      var res = jsonDecode(response.body);
      setState(() {
        authors = res['authors'];
        _selectedAuthor = authors[0]['author_name'];
      });
    });
    return response;
  }
  Future<http.Response> _updateBook() async {
    final http.Response response =
        await Network().postData({
          'BookID': bookID,
          'Title': bookName,
          'Price': price,
          'StockQuantity': quantity,
          'AuthorID': _selectedAuthor,
          'description': description,
          'CategoryId': _selectedCategory,
          
          }, '/updateProduct.php');

    // print('response ---- ${jsonDecode(response.body)}');

    setState(() {
      var res = jsonDecode(response.body);
      setState(() {
        authors = res['authors'];
        _selectedAuthor = authors[0]['author_name'];
      });
    });
    return response;
  }

   Future<http.Response> _getAuthorsByCategory(String catName) async {
    final http.Response response =
        await Network().postData({'name': catName}, '/getAuthorByCat.php');

    // print('response ---- ${jsonDecode(response.body)}');

    setState(() {
      var res = jsonDecode(response.body);
      setState(() {
        authors = res['authors'];
        _selectedAuthor = authors[0]['author_name'];
      });
    });
    return response;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getCategories();
    _getAuthors();
     _selectedCategory = widget.book['name'];
    _selectedAuthor = widget.book['author_name'];
    bookName = widget.book['Title'];
    description = widget.book['description'];
    quantity = widget.book['StockQuantity'];
    price = widget.book['Price'];
    bookID = widget.book['BookID'];
  }

  void _showConfirmationDailog(){
    
    showDialog(context: context, builder: (context) {
      
      return AlertDialog(
        backgroundColor: Colors.white,
        title: const Text('Information' , style: TextStyle(
          color: Colors.black , fontSize: 22, fontWeight: FontWeight.bold
        ),),
        content: const Text("Do You Reqlly Want to Update this record" , style: TextStyle(
          color: Colors.black , fontSize: 14, fontWeight: FontWeight.w600
        ),),
        actions:   [
          Row(
            children: [
              SizedBox(width: 120, child: ElevatedButton(onPressed: (){
                Navigator.pop(context);
              }, child: const Text('Cancle')),),
          const SizedBox(width: TSizes.spaceBtwInputFields,),
          SizedBox(width: 120, child: ElevatedButton(onPressed: (){
            _updateBook();
            Navigator.pop(context);
          }, child: const Text('Okay')),),
            ],
          )
        ],
      );
    },);
  }
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(
            vertical: TSizes.defultSpace, horizontal: TSizes.defultSpace),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: kToolbarHeight,
              ),
              Text(
                "Update books here",
                style: Theme.of(context).textTheme.displaySmall,
              ),
              const SizedBox(
                height: TSizes.spaceBtwInputFields,
              ),
              TextFormField(
                onChanged: (value) {
                  setState(() {
                    bookName = value;
                  });
                },
                initialValue: bookName,
                decoration: const InputDecoration(
                    labelText: 'Bookname', prefixIcon: Icon(Iconsax.book)),
              ),
              const SizedBox(
                height: TSizes.spaceBtwInputFields,
              ),
              TextFormField(
                onChanged: (value) {
                  setState(() {
                    price = value;
                  });
                },
                initialValue: price,
                        decoration: const InputDecoration(
                            labelText: 'Price',
                            prefixIcon: Icon(Iconsax.wallet)),
                      ),
                      const SizedBox(
                height: TSizes.spaceBtwInputFields,
              ),
                      TextFormField(
                        onChanged: (value) {
                  setState(() {
                    quantity = value;
                  });
                },
                        initialValue: quantity,
                        expands: false,
                        decoration: const InputDecoration(
                            labelText: 'Quantity',
                            prefixIcon: Icon(Iconsax.cloud_plus)),
                      ),
              
              const SizedBox(
                height: TSizes.spaceBtwInputFields,
              ),
              TextFormField(
                onChanged: (value) {
                  setState(() {
                    description = value;
                  });
                },
                initialValue: description,
                decoration: const InputDecoration(
                    labelText: 'Description',
                    prefixIcon: Icon(Iconsax.document)),
              ),
              const SizedBox(
                height: TSizes.spaceBtwInputFields,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: SizedBox(
                        width: MediaQuery.of(context).size.width / 2,
                        child: DropdownButtonFormField<String>(
                          value: _selectedCategory,
                          items:
                              categories.map<DropdownMenuItem<String>>((elem) {
                            return DropdownMenuItem<String>(
                              value: elem['name'],
                              child: Text(elem['name']),
                            );
                          }).toList(),
                          validator: (value) {
                            if (value!.isEmpty ||
                                value == '' ||
                                value == 'Select Category') {
                              return 'Please Selecy Book Category';
                            }
                            return null;
                          },
                          hint: Text(
                            'Select Category',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          onChanged: (value) {
                            setState(() {
                              _selectedCategory = value!;
                              _getAuthorsByCategory(_selectedCategory);
                            });
                          },
                        )
                        ),
                  ),
                  const SizedBox(
                    width: TSizes.spaceBtwInputFields,
                  ),
                  Expanded(
                      child: DropdownButtonFormField(
                    items: authors.map<DropdownMenuItem<String>>((elem) {
                      return DropdownMenuItem(
                          value: elem['author_name'],
                          child: Text(elem['author_name']));
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedAuthor = value!;
                      });
                    },
                    value: _selectedAuthor,
                    validator: (value) {
                      if (value!.isEmpty || value == '') {
                        return 'Please Selecy Book Author';
                      }
                      return null;
                    },
                  )),
                ],
              ),
              const SizedBox(height: TSizes.spaceBtwSections,),
              SizedBox(width: MediaQuery.of(context).size.width, child: ElevatedButton(onPressed: (){
                if(_formKey.currentState!.validate()){
                  _showConfirmationDailog();
                }
              }, child: const Text("Update books")),)
            ],
          ),
        ),
      ),
    );
  }
}