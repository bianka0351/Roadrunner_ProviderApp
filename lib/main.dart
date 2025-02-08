import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:roadrunner_provider_app/features/profile/buisness_logic/bloc/profile_bloc.dart';
import 'package:roadrunner_provider_app/features/profile/data/repository/profile_repository.dart';
import 'package:roadrunner_provider_app/features/profile/data/service/profile_api.dart';
import 'package:roadrunner_provider_app/features/profile/presentaion/screen/profile_screen.dart';

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
                          url:
                              'http://roadrunnergo.azurewebsites.net/api/ProviderAccountService/GetProfile?Id=82e12922-4dbd-47cd-ad32-a110a84dd82c'))),
              child: ProfileScreen(),
            ),
          );
        });
  }
}
