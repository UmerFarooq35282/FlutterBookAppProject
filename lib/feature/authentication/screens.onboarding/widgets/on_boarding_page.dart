import '/utils/constants/sizes.dart';
import '/utils/helpers/helper_function.dart';
import 'package:flutter/material.dart';

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({super.key , required this.title , required this.image , required this.subtitle});

  final String title , image , subtitle; 
  @override
  Widget build(BuildContext context) {
    return   Padding(
      padding: const  EdgeInsets.all(TSizes.defultSpace),
      child:  Column(
        children: [
          Image(
            width: THelperFunctions.getScreenWidth() * 0.8,
            height: THelperFunctions.getScreenHeight() * 0.6,
            image: AssetImage(image)
            ),
            Text(title , style: Theme.of(context).textTheme.headlineMedium, textAlign: TextAlign.center,),
            const SizedBox(height: TSizes.spcBtwItems,),
            Text(subtitle , style: Theme.of(context).textTheme.bodyMedium, textAlign: TextAlign.center,)
        ],
      ),
      );
  }
}