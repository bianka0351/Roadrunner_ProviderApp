import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:roadrunner_provider_app/features/auth/bloc/bloc/auth_bloc.dart';
import 'package:roadrunner_provider_app/features/auth/presentation/screens/splash_screen.dart';
import 'package:roadrunner_provider_app/features/home-page/buisness_logic/bloc/order_bloc.dart';


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

    return MultiProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(),
        ),
        BlocProvider<OrderBloc>(
          create: (context) => OrderBloc(),
        ),
      ],
      child: ScreenUtilInit(
        designSize: const Size(428, 926), // Reference size for the design.

        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(

            debugShowCheckedModeBanner: false,
            builder: BotToastInit(),
            navigatorObservers: [BotToastNavigatorObserver()],
            home: SplashScreen(),
          );
        },
      ),
    );

  }
}
