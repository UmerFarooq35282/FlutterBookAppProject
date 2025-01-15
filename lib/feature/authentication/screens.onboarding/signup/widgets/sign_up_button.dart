import '/feature/authentication/screens.onboarding/signup/verify_email.dart';
import '/utils/constants/text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class SignUpButton extends StatelessWidget {
  const SignUpButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
          onPressed: () => Get.to(() => const VerifyEmailScreen()), child: const Text(TText.createAccount)),
    );
  }
}