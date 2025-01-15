import 'package:flutter/material.dart';

class TTextInputField {
  TTextInputField._();

  static InputDecorationTheme lightTextFieldTheme = const InputDecorationTheme(
      border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey, width: 2)),
      filled: true,
      fillColor: Colors.white,
      contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      focusedBorder:
          OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
      prefixIconColor: Colors.grey,
      suffixIconColor: Colors.grey,
      hintStyle: TextStyle(
          fontSize: 16, fontWeight: FontWeight.w800, color: Colors.grey),
      counterStyle: TextStyle(color: Colors.black , fontSize: 16 , fontWeight: FontWeight.w800),
      labelStyle: TextStyle(color: Colors.black , fontSize: 16 , fontWeight: FontWeight.w800),
    );

    static InputDecorationTheme darkTextFieldTheme = const InputDecorationTheme(
      border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white, width: 2)),
      filled: true,
      fillColor: Colors.transparent,
      contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      focusedBorder:
          OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
      prefixIconColor: Colors.white,
      suffixIconColor: Colors.white,
      hintStyle: TextStyle(
          fontSize: 16, fontWeight: FontWeight.w800, color: Colors.white),
      counterStyle: TextStyle(color: Colors.white , fontSize: 16 , fontWeight: FontWeight.w800),
      labelStyle: TextStyle(color: Colors.white , fontSize: 16 , fontWeight: FontWeight.w800),
    );
}
