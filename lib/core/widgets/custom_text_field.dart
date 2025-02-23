import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.validator,
    required this.hintText,
    required this.controller,
  });
  final String? Function(String?) validator;
  final String hintText;
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        fillColor: Colors.white,
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
  }
}
