import '/common/styles/spapcing_style.dart';
// import '/utils/constants/image_strings.dart';
import '/utils/constants/sizes.dart';
import '/utils/constants/text.dart';
import '/utils/helpers/helper_function.dart';
import 'package:flutter/material.dart';

class SuccessSreen extends StatelessWidget {
  const SuccessSreen({super.key, required this.image, required this.title, required this.subTitle, required this.onPressed});

  final String image , title , subTitle;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: TSpacingStyle.paddingWithAppBarHeight * 2,
        child: Column(
          children: [
            SizedBox(
                  width: THelperFunctions.getScreenWidth() * 0.6,
                  child: Image(image: AssetImage(image))),
              const SizedBox(
                height: TSizes.spaceBtwSections,
              ),
              Text(
                title,
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: TSizes.spcBtwItems,
              ),
              Text(
                subTitle,
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: TSizes.spaceBtwSections,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: onPressed, child: const Text(TText.tContinueBtn)),
              ),
          ],
        ),
        ),
    );
  }
}