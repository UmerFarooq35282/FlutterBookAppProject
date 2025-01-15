import '/feature/authentication/screens.onboarding/login/login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnBoardingCOntroller extends GetxController{
  static OnBoardingCOntroller get instance => Get.find();


  final pageController = PageController();
  Rx<int> curentIndex = 0.obs;

  void updatePageIndecator(index) => curentIndex.value = index;

  void dotNavigationClick(index){
    curentIndex.value = index;
    pageController.jumpToPage(index);
  }

  void nextPage(){
    if(curentIndex.value == 2){
      Get.to(() => const LoginScreen());
    }else{
      int page = curentIndex.value + 1;
      pageController.jumpToPage(page);
    }
  }

  void skipPage(){
    curentIndex.value = 2;
    pageController.jumpToPage(2); 
  }
}