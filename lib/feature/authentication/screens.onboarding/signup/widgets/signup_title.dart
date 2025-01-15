import '/utils/constants/text.dart';
import 'package:flutter/material.dart';

class SignUpTitle extends StatelessWidget {
  const SignUpTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          TText.signUpTitle,
          style: Theme.of(context).textTheme.headlineMedium,
        )
      ],
    );
  }
}