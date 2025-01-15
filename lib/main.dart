import 'dart:ui';
import 'package:book_store/bottom_navigation.dart';
import 'package:book_store/feature/shop/controller/customer_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import './utils/themes/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CustomerDetsProvider())
      ],
      child: GetMaterialApp(
        scrollBehavior: const MaterialScrollBehavior().copyWith(
        dragDevices: {PointerDeviceKind.mouse},
        ),
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        themeMode: ThemeMode.dark,
        theme: TTheme.lightTheme,
        darkTheme: TTheme.darkTheme,
        home: const ProductTabPage()
      ),
    );
  }
}




