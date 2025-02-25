import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:provider/provider.dart';
import 'package:roadrunner_provider_app/features/home-page/presentation/screens/home_page.dart';
import 'package:roadrunner_provider_app/features/map/buisness_logic/bloc/map_bloc.dart';
import 'package:roadrunner_provider_app/features/profile/buisness_logic/bloc/profile_bloc.dart';
import 'package:roadrunner_provider_app/features/profile/data/repository/profile_repository.dart';
import 'package:roadrunner_provider_app/features/profile/data/service/profile_api.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:roadrunner_provider_app/features/auth/bloc/bloc/auth_bloc.dart';
import 'package:roadrunner_provider_app/features/auth/presentation/screens/splash_screen.dart';
import 'package:roadrunner_provider_app/features/home-page/buisness_logic/bloc/order_bloc.dart';

late SharedPreferences sharedPref;

void main() async {
  await Hive.initFlutter();
  await Hive.openBox('orderCache');
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
        BlocProvider<MapBloc>(
          create: (context) => MapBloc(),
        ),
        BlocProvider(
          create: (context) => ProfileBloc(
              repository: ProfileRepository(
                  profileApi: ProfileApi(
                      url:
                          'http://roadrunnergo.azurewebsites.net/api/ProviderAccountService/GetProfile?Id=82e12922-4dbd-47cd-ad32-a110a84dd82c'))),
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
            home: HomePage(),
          );
        },
      ),
    );
  }
}
