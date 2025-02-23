import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_fonts.dart';

class CustomPaymentSummary extends StatefulWidget {
  const CustomPaymentSummary({super.key});

  @override
  State<CustomPaymentSummary> createState() => _CustomPaymentSummaryState();
}

class _CustomPaymentSummaryState extends State<CustomPaymentSummary> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 408.w,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.r),
          border: Border.all(color: Color(0xffDDDDDD))),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.h),
        child: ExpansionTile(
          minTileHeight: 10.h,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
          title: Text('Payment summary ',
              style: AppFonts.poppinsExtraBold(fontSize: 16.sp)),
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Divider(),
                detailRow(
                  title: 'Basic haircut',
                  value: 'Price : \$20',
                ),
                detailRow(
                  title: 'Extra massage (Add-ons)',
                  value: 'Price : \$20',
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Total price:',
                          style: AppFonts.poppinsBold(fontSize: 14.sp)),
                      Text(' \$30',
                          style: AppFonts.poppinsBold(fontSize: 14.sp)),
                    ],
                  ),
                ),
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
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 25.w),
        child: Text(title, style: AppFonts.poppinsBold(fontSize: 14.sp)),
      ),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 25.w),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(value, style: AppFonts.poppinsRegular(fontSize: 12.sp)),
        ),
      ),
      Divider(),
    ],
  );
}
