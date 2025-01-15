import '/common/widgets/login_signup/custom_divider.dart';
import '/common/widgets/login_signup/social_icon_widget.dart';
// import '/feature/authentication/screens.onboarding/signup/widgets/sign_up_button.dart';
import '/feature/authentication/screens.onboarding/signup/widgets/signup_form.dart';
import '/feature/authentication/screens.onboarding/signup/widgets/signup_title.dart';
import '/utils/constants/sizes.dart';
import '/utils/constants/text.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Padding(
        padding: EdgeInsets.all(TSizes.defultSpace),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              SignUpTitle(),
              SizedBox(
                height: TSizes.spaceBtwSections,
              ),

              // SignUp Form
              SignUpForm(),
              SizedBox(height: TSizes.spaceBtwInputFields ,),
              // Divider
              TCustomDivider(dividerText: TText.orSignUpWith),
              SizedBox(
                height: TSizes.spaceBtwSections,
              ),
              // SOcial Icons
              TSocialIcons()
            ],
          ),
        ),
      ),
    );
  }
}








