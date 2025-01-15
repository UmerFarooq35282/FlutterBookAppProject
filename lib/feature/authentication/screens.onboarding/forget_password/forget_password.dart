import '/feature/authentication/screens.onboarding/forget_password/reset_password.dart';
import '/utils/constants/sizes.dart';
import '/utils/constants/text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(TText.forgetPassword , style: Theme.of(context).textTheme.headlineMedium,),
              const SizedBox(height: TSizes.spcBtwItems,),
              Text(TText.forgetPasswordSubTitle , style: Theme.of(context).textTheme.labelMedium,),
              const SizedBox(height: TSizes.spaceBtwSections * 2),
              TextFormField(decoration: const InputDecoration(
                labelText: TText.email,
                prefixIcon: Icon(Iconsax.direct)
              ),),
              const SizedBox(height: TSizes.spaceBtwSections,),
              SizedBox(width: double.infinity,child: ElevatedButton(onPressed: () => Get.to(()=> const RestPassword() ), child: const Text(TText.done)))
            ],
          ),
        ),
      ),
    );
  }
}