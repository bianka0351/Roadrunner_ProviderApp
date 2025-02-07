// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'time-block-request/bloc/time_block_request_bloc.dart';
// import 'time-block-request/data/repositories/time-block-request-repository.dart';
// import 'time-block-request/data/datasources/time_block_request_api_service.dart';
// import 'time-block-request/presentation/screens/time-block-request-screen.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     // Initialize API Service and Repository
//     final apiService =
//         TimeBlockRequestApiService(baseUrl: 'https://your-api-url.com/api');
//     final repository = TimeBlockRequestRepositoryImpl(apiService: apiService);

//     return MultiBlocProvider(
//       providers: [
//         BlocProvider<TimeBlockRequestBloc>(
//           create: (context) => TimeBlockRequestBloc(repository: repository),
//         ),

//       ],
//       child: MaterialApp(
//         debugShowCheckedModeBanner: false,
//         title: 'Time Block Request App',
//         theme: ThemeData(
//           primarySwatch: Colors.blue,
//           visualDensity: VisualDensity.adaptivePlatformDensity,
//         ),
//         home: TimeBlockRequestScreen(),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // Add this import
import 'time-block-request/bloc/time_block_request_bloc.dart';
import 'time-block-request/data/repositories/time-block-request-repository.dart';
import 'time-block-request/data/datasources/time_block_request_api_service.dart';
import 'time-block-request/presentation/screens/time-block-request-screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized(); // Add this line
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize API Service and Repository
    final apiService =
        TimeBlockRequestApiService(baseUrl: 'https://your-api-url.com/api');
    final repository = TimeBlockRequestRepositoryImpl(apiService: apiService);

    return ScreenUtilInit(
      designSize:
          const Size(360, 690), // Adjust these values based on your design
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider<TimeBlockRequestBloc>(
              create: (context) => TimeBlockRequestBloc(repository: repository),
            ),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Time Block Request App',
            theme: ThemeData(
              primarySwatch: Colors.blue,
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            home: TimeBlockRequestScreen(),
          ),
        );
      },
    );
  }
}
