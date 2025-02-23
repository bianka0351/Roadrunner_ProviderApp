import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/app_colors.dart';

// ignore: must_be_immutable
class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.textColor = Colors.white,
    this.buttonColor,
    this.textSize = 20.0,
    this.buttonWidth = 319.0,
    this.buttonHeight = 55.0,
    this.buttonRadius = 10.0,
  });

  final String text;
  final Function() onPressed;
  final Color textColor;
  final Color? buttonColor;
  final double textSize;
  final double buttonWidth;
  final double buttonHeight;
  final double buttonRadius;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: buttonColor ?? AppColors.primaryColor,
        fixedSize: Size(buttonWidth.w, buttonHeight.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(buttonRadius.r),
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontFamily: 'Poppins-SemiBold',
          fontSize: textSize.sp,
          color: textColor,
        ),
      ),
    );
  }
}
