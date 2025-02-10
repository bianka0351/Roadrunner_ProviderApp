import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // Add this import
import 'package:roadrunner_provider_app/core/network/bloc/network_bloc.dart';
import 'package:roadrunner_provider_app/time-block-request/presentation/screens/time-block-request-screen.dart';
import 'core/network/bloc/network_event.dart';
import 'core/utils/orientation_util.dart';
import 'core/utils/text_scale_util.dart';
import 'time-block-request/bloc/time_block_request_bloc.dart';
import 'time-block-request/data/repositories/time-block-request-repository.dart';
import 'time-block-request/data/datasources/time_block_request_api_service.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
// Set transparent status bar
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light, // Change based on background color
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    OrientationUtil.lockPortrait();

    // Initialize API Service and Repository
    final apiService =
        TimeBlockRequestApiService(baseUrl: 'https://your-api-url.com/api');
    final repository = TimeBlockRequestRepositoryImpl(apiService: apiService);

    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider<TimeBlockRequestBloc>(
              create: (context) => TimeBlockRequestBloc(repository: repository),
            ),
            BlocProvider<NetworkBloc>(
              create: (context) => NetworkBloc()..add(ListenNetworkEvent()),
            ),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Time Block Request App',
            home: TextScaleUtil.constantTextScale(
              child: TimeBlockRequestScreen(),
            ),
          ),
        );
      },
    );
  }
}
