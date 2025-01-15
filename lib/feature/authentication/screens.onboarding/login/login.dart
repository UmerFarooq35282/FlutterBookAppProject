import '/common/styles/spapcing_style.dart';
import '/common/widgets/login_signup/custom_divider.dart';
import '/common/widgets/login_signup/social_icon_widget.dart';
import '/feature/authentication/screens.onboarding/login/widgets/form_header.dart';
import '/feature/authentication/screens.onboarding/login/widgets/main_form.dart';
import '/utils/constants/sizes.dart';
import '/utils/constants/text.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: TSpacingStyle.paddingWithAppBarHeight,
          child: Column(
            children: [
              LoginHeader(),
              LoginForm(),
              TCustomDivider(dividerText: TText.orSignInWith,),
              SizedBox(height: TSizes.spaceBtwSections,),
              TSocialIcons()
            ],
          ),
        ),
      ),
    );
  }
}







