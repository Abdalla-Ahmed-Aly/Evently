import 'package:flutter/material.dart';

class AppThem {
  static const Color primary = Color(0xff5669FF);
  static const Color backgroundLight = Color(0xffF2FEFF);
  static const Color backgroundDark = Color(0xffF2FEFF);
  static const Color backgroundlight = Color(0xff101127);
  static const Color black = Color(0xff1C1C1C);
  static const Color white = Color(0xffFFFFFF);
  static const Color grey = Color(0xff7B7B7B);
  static const Color red = Color(0xffff5659);

  static ThemeData LightThem = ThemeData(
    primaryColor: primary,
    appBarTheme: AppBarTheme(
      backgroundColor: backgroundLight,
      foregroundColor: primary,
      centerTitle: true,
      titleTextStyle:
          TextStyle(fontSize: 22, fontWeight: FontWeight.w500, color: primary),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: primary,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: white,
        unselectedItemColor: white),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: primary,
        foregroundColor: white,
        shape: CircleBorder(side: BorderSide(width: 5, color: white))),
    scaffoldBackgroundColor: backgroundLight,
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: grey,
      ),
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 1,
            color: grey,
          ),
          borderRadius: BorderRadius.circular(16)),
      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 1,
            color: grey,
          ),
          borderRadius: BorderRadius.circular(16)),
      errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 1,
            color: red,
          ),
          borderRadius: BorderRadius.circular(16)),
      focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 1,
            color: red,
          ),
          borderRadius: BorderRadius.circular(16)),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primary,
        foregroundColor: white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
          foregroundColor: primary,
          textStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
              decoration: TextDecoration.underline)),
    ),
    textTheme: TextTheme(
      labelSmall: TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.w400,
        color: black,
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: black,
      ),
      bodyLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: black,
      ),
      titleLarge: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w500,
        color: white,
      ),
      displayMedium: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: white,
      ),
    ),
  );

  static ThemeData darkThem = ThemeData();
}
