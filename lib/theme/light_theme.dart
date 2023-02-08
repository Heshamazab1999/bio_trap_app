import 'package:flutter/material.dart';

ThemeData light = ThemeData(
  fontFamily: 'Roboto',
  primaryColor: const Color(0xFF33B7AF),
  secondaryHeaderColor: const Color(0xFFffcb05),
  disabledColor: const Color(0xFFBABFC4),
  brightness: Brightness.light,
  hintColor: const Color(0xFF9F9F9F),
  cardColor: Colors.white,
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: const Color(0xFF33B7AF),
    ),
  ), colorScheme: const ColorScheme.light(
    primary: Color(0xFF33B7AF),
    secondary: Color(0xFF33B7AF),
  ).copyWith(background: const Color(0xFFF3F3F3)).copyWith(error: const Color(0xFFE84D4F)),
);
