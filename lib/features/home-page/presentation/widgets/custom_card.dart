import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:roadrunner_provider_app/core/app_colors.dart';
import 'package:roadrunner_provider_app/core/app_fonts.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: Column(
        children: [
          Container(
            height: 100.h,
            width: 387.w,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.r),
              border: Border.all(color: Color(0xFFBEC7D0)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 35.w,
                  height: 100.h,
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.r),
                        bottomLeft: Radius.circular(20.r)),
                  ),
                  alignment: Alignment.center,
                  child: Text("1",
                      style: AppFonts.poppinsSemiBold(
                        color: Colors.white,
                        fontSize: 16.sp,
                      )),
                ),
                SizedBox(width: 10.w),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 28.r,
                            // backgroundImage: AssetImage('assets/images/person.jpg'),
                          ),
                          SizedBox(width: 10.w),
                          Padding(
                            padding: EdgeInsets.only(top: 10.h),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Omar Shammas",
                                    style:
                                        AppFonts.poppinsBold(fontSize: 16.sp)),
                                Text("08 : 30 PM",
                                    style: AppFonts.poppinsMedium(
                                        fontSize: 14.sp)),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(Icons.location_on_rounded,
                              size: 20.sp, color: AppColors.secondaryColor),
                          SizedBox(width: 5.w),
                          Text("Phoenix, Arizona 85001",
                              style: AppFonts.poppinsRegular(
                                  fontSize: 13.sp, color: Color(0xFF464646))),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 30.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("vanso",
                        style: AppFonts.poppinsExtraBold(fontSize: 20.sp)),
                    Text("hair cut",
                        style: AppFonts.poppinsRegular(
                          fontSize: 11.sp,
                          color: Color(0xff484A58),
                        )),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(100.w, 38.h),
                        backgroundColor: AppColors.primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                      child: Text("Start",
                          style: AppFonts.poppinsSemiBold(
                            fontSize: 16.sp,
                            color: Colors.white,
                          )),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          Row(
            children: [
              Expanded(
                child: Divider(
                  color: AppColors.tritiaryColor,
                  thickness: 1.0,
                  indent: 20.w,
                ),
              ),
              Text('18 mil - 0:26 min',
                  style: AppFonts.poppinsSemiBold(
                    fontSize: 10.sp,
                    color: AppColors.tritiaryColor,
                  )),
              Expanded(
                child: Divider(
                  color: AppColors.tritiaryColor,
                  thickness: 1.0,
                  endIndent: 20.w,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10.h,
          ),
        ],
      ),
    );
  }
}
