import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:roadrunner_provider_app/features/auth/presentation/screens/sign_in_page.dart';
import 'package:roadrunner_provider_app/features/auth/presentation/widgets/custom_road_runner.dart';
import 'package:roadrunner_provider_app/features/home-page/presentation/screens/home_page.dart';
import 'package:roadrunner_provider_app/main.dart';

import '../../../../core/constants/app_fonts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 3), () {
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) =>
                sharedPref.getString("id") == null ? SignInPage() : HomePage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/images/splash_screen_image.jpg',
            height: double.infinity.sh,
            width: double.infinity.sw,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 50.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomRoadRunner(
                    color: Colors.black, text: "Road Runner", fontSize: 48.sp),
                SizedBox(height: 25.h),
                Text(
                  'Bringing services to your doorstep   – fast, easy, and reliable!',
                  textAlign: TextAlign.center,
                  style: AppFonts.poppinsRegular(fontSize: 20.sp),
                ),
                SizedBox(height: 150.h),
              ],
            ),
          )
        ],
      ),
    );
  }
}
