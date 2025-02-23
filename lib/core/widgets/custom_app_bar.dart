import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/app_fonts.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(text, style: AppFonts.poppinsSemiBold(fontSize: 32.sp)),
        centerTitle: true,
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
