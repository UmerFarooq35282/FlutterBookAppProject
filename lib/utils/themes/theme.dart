import '/utils/themes/custom_themes/appbar_theme.dart';
import '/utils/themes/custom_themes/text_button_theme.dart';
import 'package:flutter/material.dart';
import './custom_themes/textTheme.dart';
import './custom_themes/elevatedButtonTheme.dart';
import './custom_themes/textFieldTheme.dart';
import './custom_themes/outlineButtonTheme.dart';
import 'custom_themes/checkBoxTheme.dart';
import 'custom_themes/chipTheme.dart';

class TTheme {
  TTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    textTheme: TTextTheme.lightTextTheme,
    elevatedButtonTheme: TElevatedButtonTheme.lightElevatedButtonTheme,
    inputDecorationTheme: TTextInputField.lightTextFieldTheme,
    outlinedButtonTheme: TOutlineButtonTheme.lightOutlinButtonTheme,
    checkboxTheme: TCheckBoxTheme.lightCheckBoxTheme,
    chipTheme: TChipTheme.lightChipTheme,
    appBarTheme: TAppbarTheme.lightAppbarTheme,
    textButtonTheme: TTextButtonTheme.lightTextButtonTheme,
    
  );
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Colors.black,
    textTheme: TTextTheme.darkTextTheme,
    elevatedButtonTheme: TElevatedButtonTheme.darkElevatedButtonTheme,
    inputDecorationTheme: TTextInputField.darkTextFieldTheme,
    outlinedButtonTheme: TOutlineButtonTheme.darkOutlinButtonTheme,
    checkboxTheme: TCheckBoxTheme.darkCheckBoxTheme,
    chipTheme: TChipTheme.darkChipTheme,
    appBarTheme: TAppbarTheme.darkAppbarTheme,
    textButtonTheme: TTextButtonTheme.darkTextButtonTheme
  );
}