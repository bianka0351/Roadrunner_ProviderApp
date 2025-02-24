import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MenuWidget extends StatelessWidget {
  final Function(String) onItemSelected;

  const MenuWidget({super.key, required this.onItemSelected});

  @override
  Widget build(BuildContext context) {
    // List of drawer items and their corresponding routes
    final List<Map<String, String>> menuItems = [
      {'title': 'Order List', 'route': '/orderList'},
      {'title': 'Profile Page', 'route': '/profile'},
      {'title': 'Bookings', 'route': '/bookings'},
      {'title': 'Time-block Request', 'route': '/timeBlockRequest'},
      {'title': 'Time-block History', 'route': '/timeBlockHistory'},
      {'title': 'Settings', 'route': '/settings'},
      {'title': 'Log out', 'route': '/logout'},
    ];

    return Drawer(
      child: SafeArea(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            // Logo and Name Section
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Logo
                  Padding(
                    padding: EdgeInsets.only(top: 10.sp, bottom: 30.sp),
                    child: Image.asset(
                      'assets/images/logo.png',
                      height: 40.h,
                    ),
                  ),
                  // Divider below logo
                  Divider(),
                  // Name and Title
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 10.sp),
                        child: Text(
                          'vanso',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16.sp),
                        ),
                      ),
                      Text(
                        'Omar Shammas',
                        style: TextStyle(fontSize: 14.sp, color: Colors.grey),
                      ),
                    ],
                  ),
                  // Divider below Name and Title
                  Divider(),
                ],
              ),
            ),
            // List of Drawer Items with Divider using a loop
            ...menuItems.map((item) {
              return Column(
                children: [
                  ListTile(
                    title: Text(item['title']!, style: TextStyle(fontSize: 14.sp)),
                    onTap: () => onItemSelected(item['route']!),
                  ),
                  Divider(thickness: 0,),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }
}
