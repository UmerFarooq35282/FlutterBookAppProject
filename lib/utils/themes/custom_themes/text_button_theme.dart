import 'package:flutter/material.dart';

class TTextButtonTheme{
  TTextButtonTheme._();

  static TextButtonThemeData lightTextButtonTheme = const TextButtonThemeData(
    style: ButtonStyle(
      foregroundColor: WidgetStatePropertyAll(Colors.black)
    )
  );

  static TextButtonThemeData darkTextButtonTheme = const TextButtonThemeData(
    style: ButtonStyle(
      foregroundColor: WidgetStatePropertyAll(Colors.white)
    )
  );
}