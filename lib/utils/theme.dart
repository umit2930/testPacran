import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'colors.dart';

class DobareTheme {
  static var theme = ThemeData(
    fontFamily: "Vazirmatn",
    useMaterial3: false,
    // primarySwatch: green,
    // primaryColor: const Color.fromRGBO(99, 180, 80, 1),

    colorScheme: ColorScheme.fromSwatch(
      primarySwatch: green,
    ).copyWith(
      primary: const Color.fromRGBO(99, 180, 80, 1),
      // primary: const Color.fromRGBO(5, 59, 89, 1),
      onPrimary: Colors.white,
      // primaryContainer: const Color.fromRGBO(161, 210, 150, 1),
      // onPrimaryContainer: const Color.fromRGBO(59, 108, 48, 1),
      secondary: const Color.fromRGBO(5, 59, 89, 1),
      onSecondary: Colors.white,
      error: const Color.fromRGBO(222, 57, 57, 1),
      onSurface: const Color.fromRGBO(28, 27, 31, 1),
    ),

    textTheme: TextTheme(

        ///display
        displayLarge: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 48.sp,
            height: 1.5,
            color: black),
        displayMedium: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 32.sp,
            height: 1.5,
            color: black),
        displaySmall: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 20.sp,
            height: 1.5,
            color: black),

        ///title
        titleLarge: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 20.sp,
            height: 1.5,
            color: black),
        titleMedium: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 18.sp,
            height: 1.5,
            color: black),
        titleSmall: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 16.sp,
            height: 1.5,
            color: black),

        ///body
        bodyLarge: TextStyle(
            fontWeight: FontWeight.w500, fontSize: 16.sp, color: black),
        bodyMedium: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 14.sp,
            height: 1.5,
            color: black),
        bodySmall: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 14.sp,
            height: 1.5,
            color: natural2),
        labelLarge: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 12.sp,
            height: 1.5,
            color: natural2)),
  );

  static const MaterialColor green = MaterialColor(
    _greenPrimaryValue,
    <int, Color>{
      50: Color(0xFFF2F2F2),
      100: Color(0xFFDEF0DC),
      200: Color(0xFFDEF0DC),
      300: Color(0xFFA1D296),
      400: Color(0xFF82C372),
      500: Color(0xFF63B450),
      600: Color(0xFF4F9040),
      700: Color(0xFF3B6C30),
      800: Color(0xFF274820),
      900: Color(0xFF152211),
    },
  );
  static const int _greenPrimaryValue = 0xFF63B450;
}
