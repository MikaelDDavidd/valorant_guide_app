import 'package:flutter/material.dart';

class AppColors {
  static List<AppTheme> appColorsTheme = [
    AppTheme(
      //theme 1
      background: const Color(0xFF0F1923),
      primary: const Color(0xFFFD4959),
      text: const Color(0xFFEEEEEE),
    ),
    AppTheme(
      //theme 1
      background: const Color(0xFFEEEEEE),
      primary: const Color(0xFFFD4959),
      text: const Color(0xFF14212E),
    ),
  ];

  static const Color selectedTabColor = Color(0xFFFD4959);
  static const Color gradientStartColor = Color(0xFF6365C2);
  static const Color gradientEndColor = Color(0xFF292A4B);
  static const Color darkPurple = Color(0xFF1E2050);
  static const Color grey = Color(0xFF9192A7);
  static const Color detailListBackground = Color(0xFF14212E);
  static const Color red = Color.fromARGB(255, 255, 0, 0);
  static const Color green = Color.fromARGB(255, 0, 255, 76);
  static const Color blue = Color.fromARGB(255, 0, 53, 105);
  static const Color white =Color.fromARGB(255, 255, 255, 255);
}

class AppTheme {
  Color background;
  Color primary;
  Color text;

  AppTheme({required this.background, required this.primary, required this.text});
}
