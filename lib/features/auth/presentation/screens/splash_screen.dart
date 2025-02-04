import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:roadrunner_provider_app/core/app_colors.dart';
import 'package:roadrunner_provider_app/features/auth/presentation/screens/sign_in_page.dart';

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
        MaterialPageRoute(builder: (context) => SignInPage()),
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
            padding: EdgeInsets.symmetric(horizontal: 30.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Road Runner',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 48.sp,
                      fontFamily: "Roboto"),
                ),
                SizedBox(height: 30.h),
                Text(
                  'Bringing services to your doorstep–fast, easy, and reliable!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24.sp,
                    color: AppColors.softBlackColor,
                    fontFamily: 'Poppins-Regular',
                  ),
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
