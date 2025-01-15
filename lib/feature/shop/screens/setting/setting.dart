import 'dart:convert';

// import 'package:book_store/common/widgets/appbar/appbar.dart';
import 'package:book_store/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../controller/NetworkHelper.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key, this.isLogedin = false, this.id = ''});

  final bool isLogedin;
  final String id;
  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {

   List user = [];

  // getCustomerById.php

  Future<http.Response> _getUser() async {
    final http.Response response = await Network()
        .postData({'id': widget.id,}, '/getCustomerById.php');

    print('response ---- ${jsonDecode(response.body)}');

    setState(() {
      var res = jsonDecode(response.body);
      setState(() {
        user = res['customer'];
      });
    });
    return response;
  }

  @override
  void initState() {
    super.initState();
    _getUser();
  }
  String name = ''; 
  String email = ''; 
  String password = ''; 
  String phone = ''; 
  String address = ''; 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: user.isNotEmpty ? SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: TSizes.defultSpace),
          child: Column(
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                   ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(150)),
                     child: SizedBox(
                      width: 150,
                      height: 150,
                      child: Image(image: AssetImage('assets/images/Users/male.jpg')),
                                       ),
                   ),
                ],
              ),
              const SizedBox(height: TSizes.spaceBtwInputFields,),
              SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('User Name' , style: Theme.of(context).textTheme.titleLarge,),
                            const SizedBox(height: TSizes.spaceBtwInputFields,),
                            SizedBox(
                              width: MediaQuery.of(context).size.width - 80,
                              child: TextFormField(initialValue: user[0]['Name'],))
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: TSizes.spaceBtwInputFields,),
                     Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Form(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Email' , style: Theme.of(context).textTheme.titleLarge,),
                              const SizedBox(height: TSizes.spaceBtwInputFields,),
                              SizedBox(
                                width: MediaQuery.of(context).size.width - 80,
                                child: TextFormField(initialValue: user[0]['Email'],))
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: TSizes.spaceBtwInputFields,),
                     Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Password' , style: Theme.of(context).textTheme.titleLarge,),
                            const SizedBox(height: TSizes.spaceBtwInputFields,),
                            SizedBox(
                              width: MediaQuery.of(context).size.width - 80,
                              child: TextFormField(initialValue: user[0]['password'],))
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: TSizes.spaceBtwInputFields,),
                     Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Phone' , style: Theme.of(context).textTheme.titleLarge,),
                            const SizedBox(height: TSizes.spaceBtwInputFields,),
                            SizedBox(
                              width: MediaQuery.of(context).size.width - 80,
                              child: TextFormField(initialValue: user[0]['Phone']))
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: TSizes.spaceBtwInputFields,),
                     Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Address' , style: Theme.of(context).textTheme.titleLarge,),
                            const SizedBox(height: TSizes.spaceBtwInputFields,),
                            SizedBox(
                              width: MediaQuery.of(context).size.width - 80,
                              child: TextFormField(initialValue: user[0]['Address'],))
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ) : Center(
        child: Text('Please Login First' , style: Theme.of(context).textTheme.headlineLarge,),
      ),
    );
  }
}