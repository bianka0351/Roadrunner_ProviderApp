import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_fonts.dart';
class CustomMap extends StatelessWidget {
  CustomMap({super.key});
  final ValueNotifier<bool> _isShowRouteMap = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: _isShowRouteMap,
      builder: (context, isShowRouteMap, child) {
        return Column(
          children: [
            TextButton(
              onPressed: () {
                _isShowRouteMap.value = !_isShowRouteMap.value;
              },
              child: Text(
                isShowRouteMap ? "Hide Map" : "Show Map",
                style: AppFonts.poppinsRegular(
                  fontSize: 16.sp,
                  color: isShowRouteMap
                      ? AppColors.tertiaryColor
                      : AppColors.primaryColor,
                ),
              ),
            ),
            if (isShowRouteMap)
              Container(
                height: 288.h,
                width: 408.w,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(15.r),
                ),
                child: Center(
                    child: Icon(Icons.map, size: 50.sp, color: Colors.white)),
              )
          ],
        );
      },
    );
  }
}
