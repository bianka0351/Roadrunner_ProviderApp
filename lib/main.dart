import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:roadrunner_provider_app/features/auth/bloc/bloc/auth_bloc.dart';
import 'package:roadrunner_provider_app/features/auth/presentation/screens/splash_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthBloc>(
      create: (context) => AuthBloc(),
      child: ScreenUtilInit(
          designSize: const Size(428, 926), // الحجم المرجعي للتصميم

          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            builder: BotToastInit(),
            home: SplashScreen(),
            // routes: {'PhoneNumberPage': (context) => PhoneNumberPage()},
          )),
    );
  }
}
