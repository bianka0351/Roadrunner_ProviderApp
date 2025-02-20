import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:roadrunner_provider_app/core/app_colors.dart';

class CustomErrorMessage {
  void showCustomMessage({required String message, required IconData icon}) {
    BotToast.showCustomNotification(
      toastBuilder: (cancelFunc) => Container(
        padding: EdgeInsets.all(10.w),
        height: 36.h,
        width: 344.w,
        decoration: BoxDecoration(
          color: Color(0xffFFF0F0),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10.r,
              offset: Offset(0, 4.h),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: AppColors.errorColor,
              size: 20.sp,
            ),
            SizedBox(width: 8.w),
            Flexible(
              child: Wrap(children: [
                Text(
                  message,
                  style: TextStyle(
                    color: AppColors.errorColor,
                    fontSize: 12.sp,
                    fontFamily: 'Poppins-SemiBold',
                  ),
                  softWrap: true,
                ),
              ]),
            ),
          ],
        ),
      ),
      duration: Duration(seconds: 4),
      align: Alignment.lerp(Alignment.center, Alignment.bottomCenter, 0.4),
    );
  }
}
