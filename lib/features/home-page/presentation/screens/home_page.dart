import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:roadrunner_provider_app/core/app_colors.dart';
import 'package:roadrunner_provider_app/core/app_fonts.dart';
import 'package:roadrunner_provider_app/core/widgets/custom_app_bar.dart';
import 'package:roadrunner_provider_app/features/home-page/presentation/widgets/build_map_section.dart';
import 'package:roadrunner_provider_app/features/home-page/presentation/widgets/custom_calendar.dart';
import 'package:roadrunner_provider_app/features/home-page/presentation/widgets/custom_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(text: 'Order List'),
      body: Padding(
        padding: EdgeInsets.all(10.w),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 10.h),
              CustomCalendar(),
              BuildMapSection(),
              SizedBox(height: 30.h),
              SizedBox(
                height: 350.h,
                child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: 15,
                    itemBuilder: (context, index) {
                      return CustomCard();
                    }),
              ),
              SizedBox(
                height: 10.h,
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    fixedSize: Size(224.w, 38.h),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r))),
                child: Text("Add Appointment ",
                    style: AppFonts.poppinsSemiBold(
                      fontSize: 16.sp,
                      color: Colors.white,
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
