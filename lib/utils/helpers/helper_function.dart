import 'package:flutter/material.dart';
import 'package:get/get.dart';

class THelperFunctions{
  THelperFunctions._();

  static Color? getColor(String value){
    if(value == 'Greem'){
      return Colors.green;
    }else if(value == 'Red'){
      return Colors.red;
    }else if(value == 'Blue'){
      return Colors.blue;
    }else if(value == 'Pink'){
      return Colors.pink;
    }else if(value == 'Purple'){
      return Colors.purple;
    }else if(value == 'Grey'){
      return Colors.grey;
    }else if(value == 'Black'){
      return Colors.black;
    }else if(value == 'White'){
      return Colors.white;
    }else if(value == 'Brown'){
      return Colors.brown;
    }else if(value == 'Teal'){
      return Colors.teal;
    }else if(value == 'Indigo'){
      return Colors.indigo;
    }else{
      return null;
    }
  }

  static void showSnackBar(String message){
    ScaffoldMessenger.of(Get.context!).showSnackBar(
      SnackBar(content: Text(message))
    );
  }

  static void showAlert(String title , String message){
    showDialog(context: Get.context!, builder: (BuildContext context){
      return AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('OK'))
        ],
      );
    });
  }

  static void navigateToScreen(BuildContext context , Widget screen){
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => screen)
      );
  }

  static String truncateText(String text , int maxLength){
    if(text.length <= maxLength){
      return text;
    }else{
      return '${text.substring(0 , maxLength)}...';
    }
  }

  static bool isDarkMode(BuildContext contxet){
    return Theme.of(contxet).brightness == Brightness.dark;
  }

  static Size screenSize(){
    return MediaQuery.of(Get.context!).size;
  }

  static double getScreenHeight(){
    return MediaQuery.of(Get.context!).size.height;
  }

  static double getScreenWidth(){
    return MediaQuery.of(Get.context!).size.width;
  }
}