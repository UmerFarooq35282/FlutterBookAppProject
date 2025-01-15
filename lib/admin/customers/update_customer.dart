import 'dart:convert';

// import 'package:book_store/common/widgets/appbar/appbar.dart';
import 'package:book_store/feature/shop/controller/NetworkHelper.dart';
import 'package:book_store/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// import '../../controller/NetworkHelper.dart';

class UpdateCustomerScreen extends StatefulWidget {
  const UpdateCustomerScreen({super.key, this.isLogedin = false, this.id = ''});

  final bool isLogedin;
  final String id;
  @override
  State<UpdateCustomerScreen> createState() => _UpdateCustomerScreenState();
}

class _UpdateCustomerScreenState extends State<UpdateCustomerScreen> {
  List user = [];
  String name = '';
  String email = '';
  String password = '';
  String phone = '';
  String address = '';
  String role = '';
  String gender = '';

  // getCustomerById.php

  Future<http.Response> _getUser() async {
    final http.Response response = await Network().postData({
      'id': widget.id,
    }, '/getCustomerById.php');

    print('response ---- ${jsonDecode(response.body)}');

    setState(() {
      var res = jsonDecode(response.body);
      setState(() {
        user = res['customer'];
        
        name = user[0]['Name'];
        email = user[0]['Email'];
        password = user[0]['password'];
        phone = user[0]['Phone'];
        address = user[0]['Address'];
        role = user[0]['Role'];
        gender = user[0]['Gender'];
      });
    });
    return response;
  }

  @override
  void initState() {
    super.initState();
    _getUser();
  }
  // user[0]['Name']

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: user.isNotEmpty
          ? SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: TSizes.defultSpace),
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
                            child: Image(
                                image:
                                    AssetImage('assets/images/Users/male.jpg')),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: TSizes.spaceBtwInputFields,
                    ),
                    SingleChildScrollView(
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'User Name',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge,
                                    ),
                                    const SizedBox(
                                      height: TSizes.spaceBtwInputFields,
                                    ),
                                    SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width -
                                                80,
                                        child: TextFormField(
                                          initialValue: name,
                                        ))
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: TSizes.spaceBtwInputFields,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Form(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Email',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge,
                                      ),
                                      const SizedBox(
                                        height: TSizes.spaceBtwInputFields,
                                      ),
                                      SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              80,
                                          child: TextFormField(
                                            initialValue: email,
                                          ))
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: TSizes.spaceBtwInputFields,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Password',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge,
                                    ),
                                    const SizedBox(
                                      height: TSizes.spaceBtwInputFields,
                                    ),
                                    SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width -
                                                80,
                                        child: TextFormField(
                                          initialValue: password,
                                        ))
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: TSizes.spaceBtwInputFields,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Phone',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge,
                                    ),
                                    const SizedBox(
                                      height: TSizes.spaceBtwInputFields,
                                    ),
                                    SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width -
                                                80,
                                        child:
                                            TextFormField(initialValue: phone))
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: TSizes.spaceBtwInputFields,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Address',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge,
                                    ),
                                    const SizedBox(
                                      height: TSizes.spaceBtwInputFields,
                                    ),
                                    SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width -
                                                80,
                                        child: TextFormField(
                                          initialValue: address,
                                        ))
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          : Center(
              child: Text(
                'Please Login First',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            ),
    );
  }
}
