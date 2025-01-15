import 'dart:convert';

import 'package:book_store/admin/category/category.dart';
import 'package:book_store/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:iconsax/iconsax.dart';

import '../../feature/shop/controller/NetworkHelper.dart';

class AddCategoryPage extends StatefulWidget {
  const AddCategoryPage({super.key});

  @override
  State<AddCategoryPage> createState() => _AddCategoryPageState();
}

class _AddCategoryPageState extends State<AddCategoryPage> {
  List categories = [];
  List authors = [];
  String catName = '';
  String catDescription = '';
  String catImage = '';
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

  Future<http.Response> _addCategory() async {
    final http.Response response =
        await Network().postData({
          'name': catName, 
          'description' : catDescription , 
          }, '/addCategory.php');

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
        content: const Text("click okay to insert this record" , style: TextStyle(
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
            _addCategory();
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
              const SizedBox(
                height: kToolbarHeight,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(msg , style: const TextStyle(
                    fontSize: 22,
                    
                  ),)
                ],
              ),
              const SizedBox(height: TSizes.spaceBtwInputFields,),
              Text(
                "Add Category here",
                style: Theme.of(context).textTheme.displaySmall,
              ),
              const SizedBox(
                height: TSizes.spaceBtwInputFields,
              ),
              TextFormField(

                validator: (value) {
                  if (value!.isEmpty || value == '') {
                    return 'Category name must be required';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    catName = value;
                  });
                },
                decoration: const InputDecoration(
                    labelText: 'CategoryName', prefixIcon: Icon(Iconsax.book)),
              ),
              const SizedBox(
                height: TSizes.spaceBtwInputFields,
              ),
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty || value == '') {
                    return 'Category description must be required';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    catDescription = value;
                  });
                },
                decoration: const InputDecoration(
                    labelText: 'Description', prefixIcon: Icon(Iconsax.wallet)),
              ),
              const SizedBox(
                height: TSizes.spaceBtwSections,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                    onPressed: () {
                      if(_formKey.currentState!.validate()){
                        _showConfirmationDailog();
                      }
                    }, child: const Text("Add Category")),
              )
            ],
          ),
        ),
      ),
    );
  }
}
