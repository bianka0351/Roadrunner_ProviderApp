import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:roadrunner_provider_app/core/app_colors.dart';

// ignore: must_be_immutable
class CustomButton extends StatelessWidget {
  CustomButton({super.key, required this.text, required this.onpressed});
  String text;
  final Function() onpressed;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onpressed,
      style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryColor,
          fixedSize: Size(319.w, 55.h),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.r))),
      child: Text(
        text,
        style: TextStyle(
            fontFamily: 'Poppins-SemiBold',
            fontSize: 20.sp,
            color: AppColors.whiteColor),
      ),
    );
  }
}
