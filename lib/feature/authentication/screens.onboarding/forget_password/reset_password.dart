import '/common/styles/spapcing_style.dart';
import '/feature/authentication/screens.onboarding/login/login.dart';
import '/utils/constants/image_strings.dart';
import '/utils/constants/sizes.dart';
import '/utils/constants/text.dart';
import '/utils/helpers/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class RestPassword extends StatelessWidget {
  const RestPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(onPressed: () => Get.back(), icon: Icon(Iconsax.close_square))
        ],
      ),
      body: Padding(
        padding: TSpacingStyle.paddingWithAppBarHeight,
        child: Column(
          children: [
            SizedBox(
                  width: THelperFunctions.getScreenWidth() * 0.6,
                  child: const Image(image: AssetImage(TImages.emailSend))),
              const SizedBox(
                height: TSizes.spaceBtwSections,
              ),
              Text(
                TText.resetPassDone,
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: TSizes.spcBtwItems,
              ),
              Text(
                TText.resetPassDoneSubTitle,
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: TSizes.spaceBtwSections,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () => Get.to(()=> const LoginScreen()), child: const Text(TText.tContinueBtn)),
              ),
              const SizedBox(
                height: TSizes.spcBtwItems,
              ),
              SizedBox(
                width: double.infinity,
                child: TextButton(
                    onPressed: () => Get.to(()=> const LoginScreen()), child: const Text(TText.resendEmail)),
              ),
          ],
        ),
        ),
    );
  }
}