import 'package:flutter/material.dart';

import 'text.theme.dart';

class AppTheme {
  static ThemeData theme() => ThemeData(
        useMaterial3: false,
        primaryColor: Colors.blue,
        primarySwatch: Colors.blue,
        textTheme: createTextTheme().apply(
          bodyColor: Colors.black,
          displayColor: Colors.black,
        ),
        inputDecorationTheme: InputDecorationTheme(
          contentPadding: EdgeInsets.zero,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            elevation: 0,
            padding: EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 12,
            ),
          ),
        ),
      );

  static const colorWhite = Colors.white;
  static const colorOutline = Color(0xFFE5E5E5);
  static const colorLightGray = Color(0xFFF2F2F2);
  static const colorDarkGray = Color(0xFF949C9E);
  static const colorBlack = Color(0xFF000000);
  static const colorRed = Color(0xFFF34642);
}
