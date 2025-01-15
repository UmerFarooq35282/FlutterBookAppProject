import '/feature/authentication/controllers.onboarding/onboarding_controller.dart';
import '/feature/authentication/screens.onboarding/widgets/on_boarding_page.dart';
import '/utils/constants/image_strings.dart';
import '/utils/constants/sizes.dart';
import '/utils/constants/text.dart';
import '/utils/device/device_utility.dart';
import 'package:flutter/gestures.dart';
// import 'package:elevated_button_theme/utils/helpers/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
// import 'package:iconsax/iconsax.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnBoardingCOntroller());
    
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: controller.pageController,
            onPageChanged: controller.updatePageIndecator,
            dragStartBehavior: DragStartBehavior.start,
            scrollDirection: Axis.horizontal,
            children: [
              OnBoardingPage(
                  title: TText.onBoardingTitle1,
                  image: TImages.onBoardingImage1,
                  subtitle: TText.onBoardingSubtitle1),
              OnBoardingPage(
                  title: TText.onBoardingTitle2,
                  image: TImages.onBoardingImage2,
                  subtitle: TText.onBoardingSubtitle2),
              OnBoardingPage(
                  title: TText.onBoardingTitle3,
                  image: TImages.onBoardingImage3,
                  subtitle: TText.onBoardingSubtitle3),
            ],
          ),
          // Skip Button
          const OnBoardingWidget(),

          const OnBordingDotNav(),
          const OnBoardingNext(),
        ],
      ),
    );
  }
}

class OnBoardingNext extends StatelessWidget {
  const OnBoardingNext({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnBoardingCOntroller());
    return Positioned(
        right: TSizes.defultSpace,
        bottom: TDeviceUtils.bottonNavigationHeight(),
        child: ElevatedButton(
          onPressed: () => controller.nextPage(),
          child: const Icon(Iconsax.arrow_right_3),
          style: ElevatedButton.styleFrom(
            shape: const CircleBorder(),
          ),
        ));
  }
}

class OnBordingDotNav extends StatelessWidget {
  const OnBordingDotNav({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnBoardingCOntroller());
    return Positioned(
      left: TSizes.defultSpace,
      bottom: TDeviceUtils.bottonNavigationHeight(),
      child: SmoothPageIndicator(
        controller: controller.pageController,
        onDotClicked: controller.dotNavigationClick,
        count: 3,
        effect: const ExpandingDotsEffect(
            activeDotColor: Colors.blue, dotHeight: 5),
      ),
    );
  }
}

class OnBoardingWidget extends StatelessWidget {
  const OnBoardingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnBoardingCOntroller());
    return Positioned(
            top: TDeviceUtils.getAppBarHeight(),
            right: TSizes.defultSpace,
            child: TextButton(
            onPressed: (){
              controller.skipPage();
            },
            child: const Text(
              'Skip',
            )));
  }
}
