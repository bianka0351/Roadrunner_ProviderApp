/*
run from profile

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:roadrunner_provider_app/features/profile/buisness_logic/bloc/profile_bloc.dart';
import 'package:roadrunner_provider_app/features/profile/data/repository/profile_repository.dart';
import 'package:roadrunner_provider_app/features/profile/data/service/profile_api.dart';
import 'package:roadrunner_provider_app/features/profile/presentaion/screen/profile_screen.dart';

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
                headlineLarge: TextStyle(fontFamily: 'Roboto', fontSize: 32),
                titleLarge:
                    TextStyle(fontFamily: 'Poppins-SemiBold', fontSize: 24),
                bodyMedium: TextStyle(fontFamily: 'Inter', fontSize: 16),
              ),
            ),
            debugShowCheckedModeBanner: false,
            title: 'Profile',
            home: BlocProvider(
              create: (context) => ProfileBloc(
                  repository: ProfileRepository(
                      profileApi: ProfileApi(
                          url:
                              'http://roadrunnergo.azurewebsites.net/api/ProviderAccountService/GetProfile?Id=82e12922-4dbd-47cd-ad32-a110a84dd82c'))),
              child: ProfileScreen(),
            ),
          );
        });
  }
}

*/

/*
run from splash

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:roadrunner_provider_app/features/auth/bloc/bloc/auth_bloc.dart';
import 'package:roadrunner_provider_app/features/auth/presentation/screens/splash_screen.dart';
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
    return BlocProvider<AuthBloc>(
      create: (context) => AuthBloc(),
      child: ScreenUtilInit(
          designSize: const Size(428, 926), // Reference size for the design.

          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            builder: BotToastInit(),
            home: SplashScreen(),
          )),
    );
  }
}
*/
