import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTheme {
  static ThemeData theme = ThemeData(
    brightness: Brightness.light,
    colorSchemeSeed: purple,
    scaffoldBackgroundColor: latte,
    fontFamily: 'urbanist',
    appBarTheme: AppBarTheme(
      backgroundColor: latte,
      elevation: 0,
      titleTextStyle: TextStyle(
        fontFamily: 'urbanist',
        fontSize: 24.sp,
        fontWeight: FontWeight.w600,
        color: Colors.black,
      ),
      systemOverlayStyle: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: latte,
        statusBarIconBrightness: Brightness.dark,
      ),
    ),
  );

  static const blue = Color(0xFF0C2747);
  static const pink = Color(0xFFF1DCEB);
  static const latte = Color(0xFFFEF6E9);
  static const yellow = Color(0xFFD7A745);
  static const purple = Color(0xFF5F33E1);
  static const purple2 = Color.fromARGB(255, 166, 144, 232);
  static const green = Color(0xFF2E7D32);
  static const red = Color(0xFFD32F2F);
}
