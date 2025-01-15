import 'package:flutter/material.dart';

class TElevatedButtonTheme {
  TElevatedButtonTheme._();


  static ElevatedButtonThemeData lightElevatedButtonTheme = const  ElevatedButtonThemeData(
    style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(Colors.blue),
            foregroundColor: WidgetStatePropertyAll(Colors.white),
            textStyle: WidgetStatePropertyAll(
                TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
            padding: WidgetStatePropertyAll(
                EdgeInsets.symmetric(horizontal: 20, vertical: 15)),
            elevation: WidgetStatePropertyAll(0),
  ));

  static ElevatedButtonThemeData darkElevatedButtonTheme = const  ElevatedButtonThemeData(
    style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(Colors.blue),
            foregroundColor: WidgetStatePropertyAll(Colors.white),
            textStyle: WidgetStatePropertyAll(
                TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
            padding: WidgetStatePropertyAll(
                EdgeInsets.symmetric(horizontal: 20, vertical: 15)),
            elevation: WidgetStatePropertyAll(0),
  ));
}