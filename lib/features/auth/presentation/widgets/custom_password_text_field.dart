import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:roadrunner_provider_app/core/app_colors.dart';

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
                child: Icon(value ? Icons.visibility : Icons.visibility_off),
              ),
              fillColor: AppColors.whiteColor,
              filled: true,
              hintText: hintText,
              hintStyle: TextStyle(
                color: Color(0xffB2B2C2),
                fontFamily: 'Poppins-Regular',
                fontSize: 20.sp,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: BorderSide(color: Color(0xffE4E4EE)),
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
