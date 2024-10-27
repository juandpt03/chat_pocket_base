import 'package:flutter/material.dart';

class AppTheme {
  static final AppTheme _instance = AppTheme._();

  AppTheme._();

  factory AppTheme() => _instance;

  ThemeData get lightTheme => ThemeData.light().copyWith(
        colorScheme: ColorScheme.fromSeed(
          primary: const Color(0xFF00BF6D),
          seedColor: const Color(0xFF00BF6D),
        ),
        scaffoldBackgroundColor: const Color(0xFFFAFAFA),
      );

  ThemeData get darkTheme => ThemeData.dark();
}
