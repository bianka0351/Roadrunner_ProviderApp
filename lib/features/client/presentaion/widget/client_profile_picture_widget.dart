import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:io';

class ClientProfilePictureWidget extends StatelessWidget {
  final ValueNotifier<File?> profileImageNotifier;
  final VoidCallback onTap;

  const ClientProfilePictureWidget({
    required this.profileImageNotifier,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: onTap,
        child: ValueListenableBuilder<File?>(
          valueListenable: profileImageNotifier,
          builder: (context, profileImage, child) {
            return Stack(
              children: [
                Container(
                  width: 131.w,
                  height: 132.h,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Color(0xFF38C3E4),
                      width: 1,
                    ),
                    image: profileImage != null
                        ? DecorationImage(
                            image: FileImage(profileImage),
                            fit: BoxFit.cover,
                          )
                        : DecorationImage(
                            image: AssetImage("assets/images/default_avatar.png"),
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    width: 38.64.w,
                    height: 38.64.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFF38C3E4),
                    ),
                    child: Icon(
                      Icons.edit,
                      color: Colors.white,
                      size: 20.sp,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}