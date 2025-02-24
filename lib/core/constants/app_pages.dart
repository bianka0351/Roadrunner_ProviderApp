// app_pages.dart
import 'package:flutter/material.dart';
import 'package:roadrunner_provider_app/features/client/presentaion/screen/client_screen.dart';
import '../../features/client/presentaion/screen/location_screen.dart';
import 'app_routes.dart';

class AppPages {
  static Map<String, WidgetBuilder> routes = {
    AppRoutes.home: (context) => CreateClientScreen(),
    AppRoutes.orderList: (context) => CreateClientScreen(),
    AppRoutes.profile: (context) => CreateClientScreen(),
    AppRoutes.bookings: (context) => CreateClientScreen(),
    AppRoutes.timeBlockRequest: (context) => CreateClientScreen(),
    AppRoutes.timeBlockHistory: (context) => CreateClientScreen(),
    AppRoutes.settings: (context) => CreateClientScreen(),
    AppRoutes.logout: (context) => LocationScreen(),
  };
}