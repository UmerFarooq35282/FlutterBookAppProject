import 'dart:convert';

// import 'package:book_store/common/widgets/appbar/appbar.dart';
// import 'package:book_store/common/widgets/products/custom_heading.dart';
import 'package:book_store/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../controller/NetworkHelper.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key,  this.id =''});

  final String id;
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
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
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(),
      body:  user.isNotEmpty ? SingleChildScrollView(
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
                              child: TextFormField(initialValue: user[0]['Name'], enabled: false,))
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
                            Text('Email' , style: Theme.of(context).textTheme.titleLarge,),
                            const SizedBox(height: TSizes.spaceBtwInputFields,),
                            SizedBox(
                              width: MediaQuery.of(context).size.width - 80,
                              child: TextFormField(initialValue: user[0]['Email'], enabled: false,))
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
                            Text('Password' , style: Theme.of(context).textTheme.titleLarge,),
                            const SizedBox(height: TSizes.spaceBtwInputFields,),
                            SizedBox(
                              width: MediaQuery.of(context).size.width - 80,
                              child: TextFormField(initialValue: user[0]['password'], enabled: false,))
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
                              child: TextFormField(initialValue: user[0]['Phone'], enabled: false,))
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
                              child: TextFormField(initialValue: user[0]['Address'], enabled: false,))
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