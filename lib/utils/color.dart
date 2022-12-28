import 'package:flutter/material.dart';

class AppColor{
  static const Color primaryColor = Color(0xFF8ec53f);
  static const Color secondaryColor = Color(0xFF5aab46);
   static const Color green = Colors.green;
   static const Color red = Colors.red;

  static const Color whiteColor = Colors.white;
  static const Color blackColor = Colors.black;

  // Button Color
  static const Color whiteBtnColor = Colors.white;

  static const LinearGradient gradientColor = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: <Color>[
        primaryColor,
        secondaryColor,
      ]);
}