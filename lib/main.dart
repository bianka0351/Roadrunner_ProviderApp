import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:roadrunner_provider_app/features/client/presentaion/screen/client_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/constants/app_pages.dart';
import 'core/constants/app_routes.dart';
import 'features/client/cubit/client_cubit.dart';


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
        BlocProvider<ClientCubit>(
          create: (context) => ClientCubit(),
        ),
        // BlocProvider<AuthBloc>(
        //   create: (context) => AuthBloc(),
        // ),
        // BlocProvider<OrderBloc>(
        //   create: (context) => OrderBloc(),
        // ),
      ],
      child: ScreenUtilInit(
        designSize: const Size(428, 926), // Reference size for the design.

        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
             initialRoute: AppRoutes.home,
            routes: AppPages.routes,
            builder: BotToastInit(),
            navigatorObservers: [BotToastNavigatorObserver()],
            home: CreateClientScreen(),
          );
        },
      ),
    );
  }
}
