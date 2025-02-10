import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:roadrunner_provider_app/core/app_fonts.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(text, style: AppFonts.poppinsSemiBold(fontSize: 32.sp)),
        leading: IconButton(
            padding: EdgeInsets.only(left: 15.w),
            onPressed: () {},
            icon: Icon(
              Icons.arrow_back,
              size: 35.sp,
            )),
        actions: [
          IconButton(
              padding: EdgeInsets.only(right: 15.w),
              onPressed: () {},
              icon: Icon(
                Icons.menu,
                size: 35.sp,
              ))
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
