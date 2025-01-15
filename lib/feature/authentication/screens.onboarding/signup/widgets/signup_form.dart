// import 'package:book_store/feature/authentication/screens.onboarding/signup/verify_email.dart';
import 'dart:convert';

import 'package:book_store/feature/authentication/screens.onboarding/login/login.dart';
import 'package:book_store/utils/constants/colors.dart';
import 'package:http/http.dart' as http;
// import 'package:get/get.dart';

import '../../../../shop/controller/NetworkHelper.dart';
import '/utils/constants/sizes.dart';
import '/utils/constants/text.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
// import 'package:flutter_regex/flutter_regex.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  bool obstext = true;
  String firstName = '';
  String lastName = '';
  String address = '';
  String email = '';
  String phone = '';
  String zipCode = '';
  String password = '';
  String gender = '';
  List<String> genders = ["Male", "Female"];

  final _key = GlobalKey<FormState>();

  var msg;
  Future<http.Response> _addUser() async {
    final http.Response response = await Network().postData({
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'phone': phone,
      'address': address,
      'gender': gender,
      'password': password,
    }, '/addUser.php');

    print('response ---- ${jsonDecode(response.body)}');

    setState(() {
      var res = jsonDecode(response.body);
      setState(() {
        msg = res['msg'];
      });
    });
    return response;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _key,
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                    child: TextFormField(
                  onChanged: (value) {
                    setState(() {
                      firstName = value;
                    });
                  },
                  validator: (value) {
                    if (value == '') {
                      return 'Plese Enter First name';
                    } else if (!RegExp('[a-zA-Z]{3,}')
                        .hasMatch(value.toString())) {
                      return 'First name must be valid';
                    }
                    return null;
                  },
                  expands: false,
                  decoration: const InputDecoration(
                    labelText: TText.firstName,
                    prefixIcon: Icon(Iconsax.user),
                  ),
                )),
                const SizedBox(
                  width: TSizes.spaceBtwInputFields,
                ),
                Expanded(
                    child: TextFormField(
                  onChanged: (value) {
                    setState(() {
                      lastName = value;
                    });
                  },
                  validator: (value) {
                    if (value == '' || value == null) {
                      return 'Plese Enter Last name';
                    } else if (!RegExp('[a-zA-Z]{3,}')
                        .hasMatch(value.toString())) {
                      return 'First last must be valid';
                    }
                    return null;
                  },
                  expands: false,
                  decoration: const InputDecoration(
                    labelText: TText.lastName,
                    prefixIcon: Icon(Iconsax.user),
                  ),
                )),
              ],
            ),
            const SizedBox(
              height: TSizes.spaceBtwInputFields,
            ),
            TextFormField(
              onChanged: (value) {
                setState(() {
                  email = value;
                });
              },
              // validator: (value) {
              //   if (value == '' || value == null) {
              //     return 'Plese Enter Email Address';
              //   } else if (RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
              //       .hasMatch(value)) {
              //         return 'Email must be valid';
              //       }
              //   return null;
              // },
              decoration: const InputDecoration(
                labelText: TText.email,
                prefixIcon: Icon(Iconsax.direct),
              ),
            ),
            const SizedBox(
              height: TSizes.spaceBtwInputFields,
            ),
            TextFormField(
              onChanged: (value) {
                setState(() {
                  address = value;
                });
              },
              validator: (value) {
                if (value == '') {
                  return 'Plese Enter Address';
                } else if (!RegExp(r"^[A-Za-z0-9'\.\-\s\,]{8,}")
                    .hasMatch(value.toString())) {
                  return 'Address must be valid';
                }
                return null;
              },
              decoration: const InputDecoration(
                labelText: 'Address',
                prefixIcon: Icon(Iconsax.note_favorite),
              ),
            ),
            const SizedBox(
              height: TSizes.spaceBtwInputFields,
            ),
            TextFormField(
              onChanged: (value) {
                setState(() {
                  phone = value;
                });
              },
              // validator: (value) {
              //   if (value == '') {
              //     return 'Plese Enter Phone Number';
              //   } else if (!RegExp(r'^(?:\+?|0088)?01[13-9]\d{8,}$')
              //       .hasMatch(value.toString())) {
              //     return 'Phone number is not valid';
              //   }
              //   return null;
              // },
              decoration: const InputDecoration(
                labelText: TText.phoneNumber,
                prefixIcon: Icon(Iconsax.call),
              ),
            ),
            const SizedBox(
              height: TSizes.spaceBtwInputFields,
            ),
            DropdownButtonFormField<String>(
                validator: (value) {
                  if (value == '') {
                    return 'Please Select gender first';
                  }
                  return null;
                },
                hint: const Text('Select Gender'),
                items: genders.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (val) {
                  setState(() {
                    gender = val.toString();
                  });
                  print(gender);
                }),
            const SizedBox(
              height: TSizes.spaceBtwInputFields,
            ),
            TextFormField(
              onChanged: (value) {
                setState(() {
                  password = value;
                });
              },
              validator: (value) {
                if (value == '') {
                  return 'Please Enter Password';
                } else if (!RegExp(
                        r"^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$")
                    .hasMatch(value.toString())) {
                  return "Password must contain 1 upper 1 lower character 1 special characer & should be 8 letters minimum";
                }
                return null;
              },
              obscureText: obstext,
              decoration: InputDecoration(
                  labelText: TText.password,
                  prefixIcon: const Icon(Iconsax.password_check),
                  suffixIcon: IconButton(
                    icon: obstext
                        ? const Icon(Iconsax.eye_slash)
                        : const Icon(Iconsax.eye),
                    onPressed: () {
                      setState(() {
                        obstext = !obstext;
                      });
                    },
                  )),
            ),
            const SizedBox(
              height: TSizes.spcBtwItems,
            ),
            Row(
              children: [
                SizedBox(
                  width: 24,
                  height: 24,
                  child: Checkbox(value: true, onChanged: (value) {}),
                ),
                const SizedBox(
                  width: TSizes.spcBtwItems,
                ),
                Text.rich(TextSpan(children: [
                  TextSpan(
                      text: TText.isAgree,
                      style: Theme.of(context).textTheme.bodySmall),
                  TextSpan(
                      text: ' ${TText.privacyPolicy} ',
                      style: Theme.of(context).textTheme.bodyMedium!.apply(
                          color: TColors.primary,
                          decoration: TextDecoration.underline,
                          decorationColor: TColors.primary)),
                  TextSpan(
                      text: TText.and,
                      style: Theme.of(context).textTheme.bodySmall),
                  TextSpan(
                      text: ' ${TText.termsOfUse} ',
                      style: Theme.of(context).textTheme.bodyMedium!.apply(
                          color: TColors.primary,
                          decoration: TextDecoration.underline,
                          decorationColor: TColors.primary)),
                ])),
              ],
            ),
            const SizedBox(
              height: TSizes.spcBtwItems,
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () {
                    if (_key.currentState!.validate()) {
                      _addUser();
                      final route = MaterialPageRoute(builder: (context) => const LoginScreen());
                      Navigator.push(context, route);
                    }
                  },
                  child: const Text(TText.createAccount)),
            )
          ],
        ));
  }
}
