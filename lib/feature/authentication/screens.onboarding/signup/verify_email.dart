import '/common/widgets/success_screen/success_screen.dart';
import '/feature/authentication/screens.onboarding/login/login.dart';
import '/utils/constants/image_strings.dart';
import '/utils/constants/sizes.dart';
import '/utils/constants/text.dart';
import '/utils/helpers/helper_function.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VerifyEmailScreen extends StatelessWidget {
  const VerifyEmailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(onPressed: () => Get.back(), icon: const Icon(CupertinoIcons.clear))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                  width: THelperFunctions.getScreenWidth() * 0.6,
                  child: const Image(image: AssetImage(TImages.emailSend))),
              const SizedBox(
                height: TSizes.spaceBtwSections,
              ),
              Text(
                TText.verifyEmailTitle,
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: TSizes.spcBtwItems,
              ),
              Text(
                'support@farooq.com',
                style: Theme.of(context).textTheme.bodySmall,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: TSizes.spcBtwItems,
              ),
              Text(
                TText.verifyEmailSubTitle,
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: TSizes.spaceBtwSections,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () => Get.to(() => SuccessSreen(
                      image: TImages.verifyComplete, 
                      title: TText.verifyComplete, 
                      subTitle: TText.verifyCompleteSubtitle, 
                      onPressed: () => Get.to(() => const LoginScreen()),)),
                      child: const Text(TText.tContinueBtn)),
              ),
              const SizedBox(
                height: TSizes.spcBtwItems,
              ),
              SizedBox(
                width: double.infinity,
                child: TextButton(
                    onPressed: () {}, child: const Text(TText.resendEmail)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
