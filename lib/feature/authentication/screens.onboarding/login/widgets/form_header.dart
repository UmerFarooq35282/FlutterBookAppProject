import '/utils/constants/image_strings.dart';
import '/utils/constants/text.dart';
import 'package:flutter/material.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Image(height: 150, image: AssetImage(TImages.loginLogoImage)),
        Text(
          TText.loginTitile,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        Text(
          TText.loginSubTitile,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
}