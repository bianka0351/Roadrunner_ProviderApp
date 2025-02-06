import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppFonts {
  // Poppins font family
  static const String poppinsFontFamily = 'Poppins';

  // Font weights
  static const FontWeight light = FontWeight.w300;
  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight semiBold = FontWeight.w600;
  static const FontWeight bold = FontWeight.w700;

  // Font sizes
  static const double smallFontSize = 12.0;
  static const double mediumFontSize = 13.0;
  static const double largeFontSize = 16.0;
  static const double extraLargeFontSize = 18.0;
  static const double headingFontSize = 24.0;
  static const double titleFontSize = 32.0;
static const TextStyle Function({double fontSize, Color color}) poppinsLightStyle = poppinsLight;

  // Text styles
  static TextStyle  poppinsLight(
      {double fontSize = mediumFontSize,
      Color color = AppColors.lightTextColor}) {
    return TextStyle(
      fontFamily: poppinsFontFamily,
      fontWeight: medium,
      fontSize: fontSize,
      color: color,
    );
  }

}
