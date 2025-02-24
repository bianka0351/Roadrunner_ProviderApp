import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:roadrunner_provider_app/core/constants/app_colors.dart';
import 'package:roadrunner_provider_app/core/constants/app_fonts.dart';

// ignore: must_be_immutable
class CustomSmallButton extends StatelessWidget {
  CustomSmallButton({super.key, required this.icon, required this.text});

  IconData icon;
  String text;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
        fixedSize: Size(128.w, 47.h),
        backgroundColor: AppColors.secondaryColor,
      ),
      icon: Icon(
        icon,
        color: Colors.white,
        size: 25.sp,
      ),
      label: Text(
        text,
        style: AppFonts.poppinsSemiBold(color: Colors.white, fontSize: 16.sp),
      ),
    );
  }
}
