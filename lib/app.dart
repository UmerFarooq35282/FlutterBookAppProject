import 'package:flutter/material.dart';
import './utils/constants/sizes.dart';

class CMyAppPage extends StatefulWidget {
  const CMyAppPage({super.key, required this.title});
  final String title;

  @override
  State<CMyAppPage> createState() => _CMyAppPageState();
}

class _CMyAppPageState extends State<CMyAppPage> {
  TextEditingController passController = TextEditingController();
  var obsText = true;
  var checkBoxState = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.email), hintText: "Email"),
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.email), hintText: "Email"),
                    ),
                    const SizedBox(
                      height: TSizes.spcBtwItems,
                    ),
                    TextFormField(
                      controller: passController,
                      obscureText: obsText,
                      decoration: InputDecoration(
                          hintText: "Password",
                          prefixIcon: Icon(Icons.lock),
                          suffixIcon: InkWell(
                            onTap: () {
                              setState(() {
                                obsText = !obsText;
                              });
                            },
                            child: obsText
                                ? const Icon(Icons.visibility_off)
                                : const Icon(Icons.visibility),
                          )),
                    ),
                    const SizedBox(
                      height: TSizes.spcBtwItems,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                          onPressed: () {},
                          child: const Text('Testing 01'),
                        ),
                        OutlinedButton(
                            onPressed: () {}, child: const Text('Testing 02'))
                      ],
                    ),
                    const SizedBox(
                      height: TSizes.spcBtwItems,
                    ),
                    Row(
                      children: [
                        Checkbox(
                          value: checkBoxState,
                          onChanged: (value) {
                            setState(() {
                              checkBoxState = !checkBoxState;
                            });
                          },
                        ),
                        const Text('Remember Me')
                      ],
                    ),
                   const  SizedBox(height: TSizes.spcBtwItems,),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InputChip(
                          label: Text("One"),
                        ),
                        Chip(
                          label: Text("Two"),
                        ),
                        Chip(
                          label: Text("Three"),
                        ),
                        Chip(
                          label: Text("Four"),
                        )
                      ],
                    )
                  ]))),
    );
  }
}
