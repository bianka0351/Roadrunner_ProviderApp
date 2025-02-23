import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_fonts.dart';

class CustomClientDetail extends StatelessWidget {
  const CustomClientDetail(
      {super.key,
      required this.clientName,
      required this.time,
      required this.durationTime,
      required this.location,
      required this.phoneNumber,
      required this.status,
      required this.clientImage});
  final String clientName;
  final String time;
  final String durationTime;
  final String location;
  final String phoneNumber;
  final String status;
  final String clientImage;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 408.w,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.r),
          border: Border.all(color: Color(0xffDDDDDD))),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 5.h),
        child: ExpansionTile(
          minTileHeight: 10.h,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
          leading: CircleAvatar(
            radius: 25.r,
            backgroundImage: (clientImage.isNotEmpty &&
                    Uri.tryParse(clientImage)?.hasAbsolutePath == true)
                ? NetworkImage(
                    clientImage,
                  )
                : null,
            child: (clientImage.isEmpty ||
                    Uri.tryParse(clientImage)?.hasAbsolutePath != true)
                ? Icon(Icons.person, size: 30.sp, color: Colors.white)
                : null,
          ),
          title:
              Text('Client', style: AppFonts.poppinsExtraBold(fontSize: 16.sp)),
          subtitle:
              Text(clientName, style: AppFonts.poppinsRegular(fontSize: 12.sp)),
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Divider(),
                detailRow(
                  title: 'Date & Time',
                  value: 'Sun, 15 Jan - $time',
                  icon: Icons.edit_outlined,
                  onIconTap: () {},
                  isUnderlined: false,
                ),
                detailRow(
                    title: 'Duration Time',
                    value: durationTime,
                    isUnderlined: false),
                detailRow(
                  title: 'Location',
                  value: location,
                  icon: Icons.copy_rounded,
                  isUnderlined: true,
                  onIconTap: () {},
                ),
                detailRow(
                    title: 'Phone Number',
                    value: phoneNumber,
                    valueColor: Color(0xffEE8105),
                    isUnderlined: false),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.w),
                  child: Row(
                    children: [
                      Text('Status:',
                          style: AppFonts.poppinsBold(fontSize: 14.sp)),
                      Text(' $status',
                          style: AppFonts.poppinsRegular(
                              fontSize: 14.sp, color: AppColors.primaryColor)),
                    ],
                  ),
                ),
                SizedBox(height: 10.h),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Widget detailRow({
  required String title,
  required String value,
  IconData? icon,
  VoidCallback? onIconTap,
  required bool isUnderlined,
  Color? valueColor,
}) {
  return Column(
    children: [
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 25.w),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(title, style: AppFonts.poppinsBold(fontSize: 14.sp)),
            SizedBox(width: 15.w),
            if (icon != null)
              InkWell(
                onTap: onIconTap,
                child: Icon(icon, size: 20.sp),
              ),
          ],
        ),
      ),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 25.w),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            value,
            style: TextStyle(
              fontFamily: "Poppins",
              fontWeight: FontWeight.w400,
              fontSize: 12.sp,
              color: valueColor ?? Colors.black,
              decoration:
                  isUnderlined ? TextDecoration.underline : TextDecoration.none,
            ),
          ),
        ),
      ),
      Divider(),
    ],
  );
}
