import 'package:flutter/material.dart';

class TAppbarTheme{
  TAppbarTheme._();

  static AppBarTheme lightAppbarTheme = const AppBarTheme(

    backgroundColor: Colors.transparent,
    titleTextStyle: TextStyle(
      color: Colors.black,
      fontSize: 30,
      fontWeight: FontWeight.w700
    ),
    elevation: 0,
    foregroundColor: Colors.black

  );

  static AppBarTheme darkAppbarTheme = const AppBarTheme(
    backgroundColor: Colors.transparent,
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 30,
      fontWeight: FontWeight.w700
    ),
    elevation: 0,
    foregroundColor: Colors.white,
  );
}