import 'package:flutter/material.dart';

class AppFonts {
  // Poppins font family
  static const String poppinsFontFamily = 'Poppins';

  // Font weights
  static const FontWeight light = FontWeight.w300;
  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight semiBold = FontWeight.w600;
  static const FontWeight bold = FontWeight.w700;
  static const FontWeight extraBold = FontWeight.w900;

  // Text styles
  static TextStyle poppinsLight({final double? fontSize, final Color? color}) {
    return TextStyle(
      fontFamily: poppinsFontFamily,
      fontWeight: light,
      fontSize: fontSize,
      color: color,
    );
  }

  static TextStyle poppinsRegular(
      {final double? fontSize, final Color? color}) {
    return TextStyle(
      fontFamily: poppinsFontFamily,
      fontWeight: regular,
      fontSize: fontSize,
      color: color,
    );
  }

  static TextStyle poppinsMedium({final double? fontSize, final Color? color}) {
    return TextStyle(
      fontFamily: poppinsFontFamily,
      fontWeight: medium,
      fontSize: fontSize,
      color: color,
    );
  }

  static TextStyle poppinsSemiBold(
      {final double? fontSize, final Color? color}) {
    return TextStyle(
      fontFamily: poppinsFontFamily,
      fontWeight: semiBold,
      fontSize: fontSize,
      color: color,
    );
  }

  static TextStyle poppinsBold({final double? fontSize, final Color? color}) {
    return TextStyle(
      fontFamily: poppinsFontFamily,
      fontWeight: bold,
      fontSize: fontSize,
      color: color,
    );
  }

  static TextStyle poppinsExtraBold(
      {final double? fontSize, final Color? color}) {
    return TextStyle(
      fontFamily: poppinsFontFamily,
      fontWeight: extraBold,
      fontSize: fontSize,
      color: color,
    );
  }
}
