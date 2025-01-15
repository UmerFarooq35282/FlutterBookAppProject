import 'package:flutter/material.dart';

class CustomPasswordField extends StatefulWidget {
  const CustomPasswordField({Key? key, required this.controller})
      : super(key: key);
  final TextEditingController controller;

  @override
  State<CustomPasswordField> createState() => _CustomPasswordFieldState();
}

class _CustomPasswordFieldState extends State<CustomPasswordField> {
  var obsText = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: obsText,
      decoration: InputDecoration(
        hintText: 'Password',
        prefixIcon: const Icon(Icons.lock),
        suffixIcon: InkWell(
            onTap: () {
              setState(() {
                obsText = !obsText;
              }
              );
              print(obsText);
            },
            child: obsText
                ? const Icon(Icons.visibility_off)
                : const Icon(Icons.visibility)),
                    
      ),
    );
  }
}
