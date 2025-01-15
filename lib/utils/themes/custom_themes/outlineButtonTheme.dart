import 'package:flutter/material.dart';

class TOutlineButtonTheme{
  TOutlineButtonTheme._();

  static OutlinedButtonThemeData lightOutlinButtonTheme = const OutlinedButtonThemeData(
    style: ButtonStyle(
      elevation: MaterialStatePropertyAll(0),
      backgroundColor: MaterialStatePropertyAll(Colors.transparent),
      foregroundColor: MaterialStatePropertyAll(Colors.black),
      side: MaterialStatePropertyAll(BorderSide(
        color: Colors.black,
        width: 1
      )),
      textStyle: MaterialStatePropertyAll(TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w500
      )),
      padding: MaterialStatePropertyAll(EdgeInsets.symmetric(horizontal: 20 , vertical: 15)),
      
    )
  );

  static OutlinedButtonThemeData darkOutlinButtonTheme = const OutlinedButtonThemeData(
    style: ButtonStyle(
      elevation: MaterialStatePropertyAll(0),
      backgroundColor: MaterialStatePropertyAll(Colors.transparent),
      foregroundColor: MaterialStatePropertyAll(Colors.white),
      side: MaterialStatePropertyAll(BorderSide(
        color: Colors.white,
        width: 1
      )),
      textStyle: MaterialStatePropertyAll(TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w500
      )),
      padding: MaterialStatePropertyAll(EdgeInsets.symmetric(horizontal: 20 , vertical: 15)),
      
    )
  );
}