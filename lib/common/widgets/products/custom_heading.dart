import 'package:flutter/material.dart';

class CustomHeadingWidget extends StatelessWidget {
  const CustomHeadingWidget({
    super.key, this.title, this.btnText, this.btnOnPressed,
  });
  final String? title;
  final String? btnText;
  final VoidCallback? btnOnPressed;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('$title' , style: Theme.of(context).textTheme.headlineSmall,),
        TextButton(onPressed: btnOnPressed, child: Text('$btnText' , style: Theme.of(context).textTheme.labelLarge,))
      ],
    );
  }
}