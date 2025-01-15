import 'dart:convert';

// import 'package:book_store/admin/category/category.dart';
import 'package:book_store/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:iconsax/iconsax.dart';

import '../../feature/shop/controller/NetworkHelper.dart';

class AddCustomersPage extends StatefulWidget {
  const AddCustomersPage({super.key});

  @override
  State<AddCustomersPage> createState() => _AddCustomersPageState();
}

class _AddCustomersPageState extends State<AddCustomersPage> {
  List categories = [];
  String _selectedCategory = '';
  List authors = [];
  String authName = '';
  String authBio = '';
  String catImage = '';
  String msg = '';

  

  Future<http.Response> _AddCustomers() async {
    final http.Response response = await Network().postData({
      'name': authName,
      'bio': authBio,
      'category': _selectedCategory,
    }, '/AddCustomers.php');

    // print('response ---- ${jsonDecode(response.body)}');

    setState(() {
      var res = jsonDecode(response.body);
      setState(() {
        msg = res['msg'];
      });
    });
    return response;
  }

  void _showConfirmationDailog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: const Text(
            'Information',
            style: TextStyle(
                color: Colors.black, fontSize: 22, fontWeight: FontWeight.bold),
          ),
          content: const Text(
            "Record has been inserted",
            style: TextStyle(
                color: Colors.black, fontSize: 14, fontWeight: FontWeight.w600),
          ),
          actions: [
            Row(
              children: [
                SizedBox(
                  width: 120,
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Cancle')),
                ),
                const SizedBox(
                  width: TSizes.spaceBtwInputFields,
                ),
                SizedBox(
                  width: 120,
                  child: ElevatedButton(
                      onPressed: () {
                        _AddCustomers();
                        final route = MaterialPageRoute(
                            builder: (context) =>  super.widget);
                        Navigator.pushReplacement(context, route);
                      },
                      child: const Text('Okay')),
                ),
              ],
            )
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    // _getCategories();
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
                  Text(
                    msg,
                    style: const TextStyle(
                      fontSize: 22,
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: TSizes.spaceBtwInputFields,
              ),
              Text(
                "Add Author here",
                style: Theme.of(context).textTheme.displaySmall,
              ),
              const SizedBox(
                height: TSizes.spaceBtwInputFields,
              ),
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty || value == '') {
                    return 'Author name must be required';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    authName = value;
                  });
                },
                decoration: const InputDecoration(
                    labelText: 'Author Name', prefixIcon: Icon(Iconsax.user)),
              ),
              const SizedBox(
                height: TSizes.spaceBtwInputFields,
              ),
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty || value == '') {
                    return 'Authors Bio must be required';
                  }else if (value.length == 30){
                    return 'Author Bio Must be atleast 30 character';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    authBio = value;
                  });
                },
                decoration: const InputDecoration(
                    labelText: 'Authors Bio', prefixIcon: Icon(Iconsax.book)),
              ),
              const SizedBox(
                height: TSizes.spaceBtwInputFields,
              ),
              DropdownButtonFormField<String>(
                value: _selectedCategory,
                items: categories.map<DropdownMenuItem<String>>((elem) {
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
                  });
                },
              ),
              const SizedBox(
                height: TSizes.spaceBtwSections,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _showConfirmationDailog();
                      }
                    },
                    child: const Text("Add Category")),
              )
            ],
          ),
        ),
      ),
    );
  }
}
