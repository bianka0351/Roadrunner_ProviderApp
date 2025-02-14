import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:roadrunner_provider_app/core/app_fonts.dart';

class OrderDetail extends StatelessWidget {
  const OrderDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text('Order Detail',
              style: AppFonts.poppinsSemiBold(fontSize: 32.sp)),
          centerTitle: true,
          leading: IconButton(
              padding: EdgeInsets.only(left: 15.w),
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back,
                size: 35.sp,
              ))),
    );
  }
}
