import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final TextInputType keyboardType;

  const CustomTextField({
    required this.controller,
    required this.label,
    required this.hint,
    this.keyboardType = TextInputType.text,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            labelText: label,
            labelStyle: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w400,
              color: Color(0xFF9CA3AF),
              fontFamily: 'Poppins',
            ),
            hintText: hint,
            hintStyle: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w400,
              color: Color(0xFF9CA3AF),
              fontFamily: 'Poppins',
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6.r),
              borderSide: BorderSide(
                color: Color(0xFFE4E4EE),
                width: 1,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6.r),
              borderSide: BorderSide(
                color: Color(0xFFE4E4EE),
                width: 1,
              ),
            ),
            floatingLabelBehavior: FloatingLabelBehavior.auto,
          ),
        ),
        SizedBox(height: 16.h),
      ],
    );
  }
}