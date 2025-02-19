import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:roadrunner_provider_app/features/map/presentation/screen/test_map_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences sharedPref;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedPref = await SharedPreferences.getInstance();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: Size(428, 926),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
            theme: ThemeData(
              fontFamily: 'Poppins-Regular', // Default font for the app
              textTheme: TextTheme(
                headlineLarge: TextStyle(fontFamily: 'Roboto', fontSize: 32.sp),
                titleLarge:
                    TextStyle(fontFamily: 'Poppins-SemiBold', fontSize: 24.sp),
                bodyMedium: TextStyle(fontFamily: 'Inter', fontSize: 16.sp),
              ),
            ),
            debugShowCheckedModeBanner: false,
            title: 'Profile',
            home: MapScreen(),
          );
        });
  }
}
