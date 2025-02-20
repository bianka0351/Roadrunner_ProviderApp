import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:roadrunner_provider_app/core/app_colors.dart';
import 'package:roadrunner_provider_app/core/app_fonts.dart';

class CustomPasswordTextField extends StatelessWidget {
  CustomPasswordTextField({
    super.key,
    required this.validator,
    required this.hintText,
    required this.controller,
  });
  final String? Function(String?) validator;
  final String hintText;
  final TextEditingController controller;
  final obscure = ValueNotifier(true);
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: obscure,
        builder: (context, value, _) {
          return TextFormField(
            obscureText: value,
            controller: controller,
            decoration: InputDecoration(
              suffixIcon: InkWell(
                onTap: () {
                  obscure.value = !value;
                },
                child: Icon(
                  value ? Icons.visibility : Icons.visibility_off,
                ),
              ),
              fillColor: Colors.white,
              filled: true,
              labelText: hintText,
              labelStyle: AppFonts.poppinsRegular(
                fontSize: 20.sp,
                color: Color(0xFFB2B2C2),
              ),
              floatingLabelStyle: AppFonts.poppinsRegular(
                  fontSize: 20.sp, color: AppColors.secondaryColor),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: BorderSide(color: Color(0xFFDDDDDD)),
              ),
              errorStyle: TextStyle(color: AppColors.errorColor),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.errorColor),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.secondaryColor),
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16.w,
                vertical: 12.h,
              ),
            ),
            validator: validator,
          );
        });
  }
}
