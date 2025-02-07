import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:roadrunner_provider_app/profile/buisness_logic/bloc/profile_bloc.dart';
import 'package:roadrunner_provider_app/profile/data/repository/profile_repository.dart';
import 'package:roadrunner_provider_app/profile/data/service/profile_api.dart';
import 'package:roadrunner_provider_app/profile/presentaion/screen/profile_screen.dart';

void main() {
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
            debugShowCheckedModeBanner: false,
            title: 'Profile',
            home: BlocProvider(
              create: (context) => ProfileBloc(
                  repository: ProfileRepository(
                      profileApi: ProfileApi(
                          baseUrl:
                              'http://roadrunnergo.azurewebsites.net/api/ProviderAccountService'))),
              child: ProfileScreen(),
            ),
          );
        });
  }
}
