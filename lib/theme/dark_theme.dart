import 'package:flutter/material.dart';

ThemeData dark = ThemeData(
  fontFamily: 'Roboto',
  primaryColor: const Color(0xFF33B7AF),
  secondaryHeaderColor: const Color(0xFFffcb05),
  disabledColor: const Color(0xffa2a7ad),
  brightness: Brightness.dark,
  hintColor: const Color(0xFFbebebe),
  cardColor: Colors.black,
  textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(foregroundColor: const Color(0xFF33B7AF),)), colorScheme: const ColorScheme.dark(
      primary: Color(0xFF33B7AF), secondary: Color(0xFF33B7AF),).copyWith(background: const Color(0xFF343636)).copyWith(error: const Color(0xFFdd3135)),
);
