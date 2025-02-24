import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:roadrunner_provider_app/core/constants/app_fonts.dart';
import 'package:roadrunner_provider_app/features/profile/presentaion/screen/profile_screen.dart';

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
        leading: PopupMenuButton<String>(
          color: Colors.white,
          icon: Icon(Icons.menu),
          onSelected: (value) {
            if (value == "profile") {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return ProfileScreen();
              }));
            }
          },
          itemBuilder: (BuildContext context) {
            return [
              PopupMenuItem<String>(
                value: "profile",
                child: Text("Profile"),
              ),
            ];
          },
        ),
        actions: [
          Padding(
              padding: EdgeInsets.only(right: 15.w),
              child: Stack(
                children: [
                  Icon(
                    Icons.chat_bubble_outline,
                    size: 30.sp,
                  ),
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Container(
                      padding: EdgeInsets.all(4.w),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      constraints: BoxConstraints(
                        minWidth: 10.w,
                        minHeight: 10.w,
                      ),
                    ),
                  ),
                ],
              ))
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
