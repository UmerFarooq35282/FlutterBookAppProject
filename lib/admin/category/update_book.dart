import 'dart:convert';

import 'package:book_store/admin/category/category.dart';
import 'package:book_store/feature/shop/controller/NetworkHelper.dart';
import 'package:book_store/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:iconsax/iconsax.dart';


class UpdateCategoryPage extends StatefulWidget {
  const UpdateCategoryPage({super.key, required this.book});

  final Map<String , dynamic> book;
  @override
  State<UpdateCategoryPage> createState() => _UpdateCategoryPageState();
}

class _UpdateCategoryPageState extends State<UpdateCategoryPage> {

  List categories = [];
  List authors = [];
  String name = '';
  String description = '';
  String image = '';
  String msg = '';

  Future<http.Response> _getCategories() async {
    final http.Response response =
        await Network().postData({"O": "0", "S": "15"}, '/getCategories.php');

    print('response ---- ${jsonDecode(response.body)}');

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

    print('response ---- ${jsonDecode(response.body)}');

    setState(() {
      var res = jsonDecode(response.body);
      setState(() {
        authors = res['authors'];
        
      });
    });
    return response;
  }
  Future<http.Response> _updateCategory() async {
    final http.Response response =
        await Network().postData({
          'id' : '${widget.book['id']}',
          'name': name,
          'description' : description,
          
          }, '/updateCategory.php');

    print('response ---- ${jsonDecode(response.body)}');

    setState(() {
      var res = jsonDecode(response.body);
      setState(() {
        msg = res['msg'];
      });
    });
    return response;
  }
void _showConfirmationDailog(){
    
    showDialog(context: context, builder: (context) {
      
      return AlertDialog(
        backgroundColor: Colors.white,
        title: const Text('Information' , style: TextStyle(
          color: Colors.black , fontSize: 22, fontWeight: FontWeight.bold
        ),),
        content: const Text("click okay to update this record" , style: TextStyle(
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
            _updateCategory();
            final route = MaterialPageRoute(builder: (context) => const CategoriesPage());

            Navigator.push(context, route); 
          }, child: const Text('Okay')),),
            ],
          )
        ],
      );
    },);
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getCategories();
    _getAuthors();
    name = widget.book['name'];
    description = widget.book['description'];
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
                "Update Category here",
                style: Theme.of(context).textTheme.displaySmall,
              ),
              const SizedBox(
                height: TSizes.spaceBtwInputFields,
              ),
              TextFormField(
                initialValue: name,
                onChanged: (value) {
                  setState(() {
                    name = value;
                  });
                },
                decoration: const InputDecoration(
                    labelText: 'Category Name', prefixIcon: Icon(Iconsax.book)),
              ),
              const SizedBox(
                height: TSizes.spaceBtwInputFields,
              ),
              TextFormField(
                initialValue: description,
                onChanged: (value) {
                  setState(() {
                    description = value;
                  });
                },
                        decoration: const InputDecoration(
                            labelText: 'Description',
                            prefixIcon: Icon(Iconsax.wallet)),
                      ),
                      const SizedBox(
                height: TSizes.spaceBtwInputFields,
              ),
              const SizedBox(height: TSizes.spaceBtwSections,),
              SizedBox(width: MediaQuery.of(context).size.width, child: ElevatedButton(onPressed: (){
                if(_formKey.currentState!.validate()){
                  _showConfirmationDailog();
                }
              }, child: const Text("Update Category")),)
            ],
          ),
        ),
      ),
    );
  }
}