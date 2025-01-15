import 'dart:convert';
import 'package:book_store/feature/authentication/screens.onboarding/signup/signup.dart';
import 'package:http/http.dart' as http;
import '../../../../shop/controller/NetworkHelper.dart';
import '/bottom_navigation.dart';
import '/feature/authentication/screens.onboarding/forget_password/forget_password.dart';
import '/utils/constants/sizes.dart';
import '/utils/constants/text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool obstext = true;
  String email = '';
  String password = '';
  String msg = '';
  String customeId = '';
  bool isCustomer = false;
  final _formKey = GlobalKey<FormState>();
  List customer = [];

  Future<http.Response> _getCustomer() async {
    final http.Response response = await Network().postData(
        {'email': email, 'password': password}, '/customerByEmail.php');

    print('response ---- ${jsonDecode(response.body)}');

    setState(() {
      var res = jsonDecode(response.body);
      List user = res['customer'];
      if (user.isNotEmpty) {
       setState(() {
         customer = res['customer'];
        final route = MaterialPageRoute(builder: (context) =>  ProductTabPage(title: customer[0]['Name'],
        id: customer[0]['CustomerID'],
        role: customer[0]['Role'],
        ),
        );
        Navigator.push(context, route);
       });
        
      } else {
        setState(() {
          msg = 'Email or Password Incorrect';
        });
      }
    });
    return response;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: TSizes.spaceBtwSections),
        child: Column(
          children: [
            Text(
              msg,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(
              height: TSizes.spaceBtwInputFields,
            ),
            TextFormField(
              validator: (value) {
                if (value == '' || value == null) {
                  return 'Email Field Required';
                }
                return null;
              },
              onChanged: (value) {
                setState(() {
                  email = value;
                });
              },
              decoration: const InputDecoration(
                  prefixIcon: Icon(Iconsax.direct_right),
                  labelText: TText.email),
            ),
            const SizedBox(
              height: TSizes.spaceBtwInputFields,
            ),
            TextFormField(
              validator: (value) {
                if (value == '' || value == null) {
                  return 'Password Field Required';
                }
                return null;
              },
              onChanged: (value) {
                setState(() {
                  password = value;
                });
              },
              obscureText: obstext,
              decoration: InputDecoration(
                  prefixIcon: const Icon(Iconsax.password_check),
                  labelText: TText.password,
                  suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          obstext = !obstext;
                        });
                      },
                      icon: obstext
                          ? const Icon(Iconsax.eye_slash)
                          : const Icon(Iconsax.eye))),
            ),
            const SizedBox(
              height: TSizes.spaceBtwInputFields / 2,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Checkbox(value: true, onChanged: (value) {}),
                    const Text(TText.rememberMe),
                  ],
                ),
                TextButton(
                  onPressed: () => Get.to(() => const ForgetPassword()),
                  child: const Text(TText.forgetPassword),
                ),
              ],
            ),
            const SizedBox(
              height: TSizes.spaceBtwSections,
            ),
            // Sign In Button
            SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _getCustomer();
                      }
                    },
                    child: const Text(TText.signIn))),

            const SizedBox(
              height: TSizes.spcBtwItems,
            ),
            // Create Account Button
            SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                    onPressed: () => Get.to(() => const SignUpScreen()),
                    child: const Text(TText.createAccount)))
          ],
        ),
      ),
    );
  }
}
