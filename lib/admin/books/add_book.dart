import 'dart:convert';

import 'package:book_store/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:iconsax/iconsax.dart';

import '../../feature/shop/controller/NetworkHelper.dart';

class AddBookPage extends StatefulWidget {
  const AddBookPage({super.key});

  @override
  State<AddBookPage> createState() => _AddBookPageState();
}

class _AddBookPageState extends State<AddBookPage> {
  List categories = [];
  List authors = [];
  String _selectedCategory = "";
  String _selectedAuthor = "";
  String bookName = '';
  String description = '';
  double price = 0;
  int quantity = 0;
  String msg = '';

  Future<http.Response> _getCategories() async {
    final http.Response response =
        await Network().postData({"O": "0", "S": "50"}, '/getCategories.php');

    print('response ---- ${jsonDecode(response.body)}');

    setState(() {
      var res = jsonDecode(response.body);
      setState(() {
        categories = res['categories'];
        _selectedCategory = categories[0]['name'];
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

  Future<http.Response> _addBook() async {
    final http.Response response = await Network().postData({
      'Title': bookName,
      'Price': '$price',
      'StockQuantity': '$quantity',
      'AuthorID': _selectedAuthor,
      'description': description,
      'CategoryId': _selectedCategory,
    }, '/addProduct.php');

    // print('response ---- ${jsonDecode(response.body)}');

    setState(() {
      var res = jsonDecode(response.body);
      setState(() {
        msg = res['msg'];
      });
    });
    return response;
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getCategories();
    // _getAuthors();
  }

    final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(
            vertical: TSizes.defultSpace, horizontal: TSizes.defultSpace),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(msg , style: Theme.of(context).textTheme.headlineLarge,)
                ],
              ),
              Text(
                "Add books here",
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
                validator: (value) {
                  if (value!.isEmpty || value == '') {
                    return 'Bookname must be required';
                  } else if (value.length < 3) {
                    return 'bookname must be atleast 3 characters';
                  } else {
                    return null;
                  }
                },
                decoration: const InputDecoration(
                    labelText: 'Bookname', prefixIcon: Icon(Iconsax.book)),
              ),
              const SizedBox(
                height: TSizes.spaceBtwInputFields,
              ),
              TextFormField(
                onChanged: (value) {
                  setState(() {
                    price = double.parse(value);
                  });
                },
                validator: (value) {
                  if (value!.isEmpty || value == '') {
                    return 'Price must be required';
                  } else {
                    return null;
                  }
                },
                decoration: const InputDecoration(
                    labelText: 'Price', prefixIcon: Icon(Iconsax.wallet)),
              ),
              const SizedBox(
                height: TSizes.spaceBtwInputFields,
              ),
              TextFormField(
                onChanged: (value) {
                  setState(() {
                    quantity = int.parse(value);
                  });
                },
                validator: (value) {
                  if (value!.isEmpty || value == '') {
                    return 'Quanity must be required';
                  } else {
                    return null;
                  }
                },
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
                validator: (value) {
                  if (value!.isEmpty || value == '') {
                    return 'Discription must be required';
                  } else if (value.length < 10) {
                    return 'Description must be atleast of 10 charactor';
                  } else {
                    return null;
                  }
                },
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
              const SizedBox(
                height: TSizes.spaceBtwSections,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _addBook();
                      }
                    },
                    child: const Text("Add books")),
              )
            ],
          ),
        ),
      ),
    );
  }
}

// DropdownButton<String>( 
//                       value: _selectedAuthor,
//                       style: const TextStyle(
//                           color: Colors.white,//font size on dropdown button
//                           ),
//                       dropdownColor:
//                           Colors.redAccent, 
//                       items: authors.map((elem) {
//                         return DropdownMenuItem<String>(
//                           value: elem['author_name'],
//                           child: Text(elem['author_name']),
//                         );
//                       }).toList(),
//                       onChanged: (String? value) {
//                         setState(() {
//                           _selectedAuthor = value!;
//                           print(_selectedAuthor);
//                         });
//                       },
//                     ),

// DropdownButton<String>(
//                         value: _selectedCategory,
//                         style: const TextStyle(
//                             color: Colors.white, //font size on dropdown button
//                             ),

//                         dropdownColor:
//                             Colors.redAccent, 
                        
//                         items: categories.map((elem) {
//                           return DropdownMenuItem<String>(
//                             value: elem['name'],
//                             child: Text(elem['name']),
//                           );
//                         }).toList(),
//                         onChanged: (String? value) {
//                           setState(() {
//                             _selectedCategory = value!;
//                           _getAuthorsByCategory(_selectedCategory);
//                             print(_selectedCategory);
//                           });
//                         },
//                       ),