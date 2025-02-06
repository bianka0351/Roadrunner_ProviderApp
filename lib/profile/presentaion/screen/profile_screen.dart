import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:roadrunner_provider_app/core/app_colors.dart';
import 'package:roadrunner_provider_app/profile/presentaion/widget/profile_avatar_widget.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ProfileScreenState();
  }
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _obscureText = true;

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Runner Profile',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28.sp),
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          width: 1.sw,
          height: 1.sh,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 40.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // profile image
                Stack(children: [
                  ProfileAvatar(
                    imageUrl:
                        'https://th.bing.com/th/id/OIP.IGNf7GuQaCqz_RPq5wCkPgHaLH?rs=1&pid=ImgDetMain',
                    size: 70,
                  ),
                  Positioned(
                    bottom: 0.0,
                    right: 0.0,
                    child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                            shape: CircleBorder(),
                            backgroundColor: AppColors.PrimaryColor),
                        child: Icon(
                          Icons.edit,
                          color: Colors.white,
                        )),
                  )
                ]),
                SizedBox(
                  height: 30.h,
                ),
                // username
                TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0.r)),
                      hintText: 'UserName'),
                ),
                SizedBox(
                  height: 30.h,
                ),
                // Email
                TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0.r)),
                      hintText: 'Email'),
                ),
                SizedBox(
                  height: 30.h,
                ),
                // Password
                TextField(
                  obscureText: _obscureText,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0.r),
                      ),
                      hintText: 'Password',
                      suffixIcon: IconButton(
                          onPressed: () {
                            _togglePasswordVisibility();
                          },
                          icon: Icon(_obscureText
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined))),
                ),
                SizedBox(
                  height: 30.h,
                ),
                // Address
                TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0.r)),
                      hintText: 'Address',
                      suffixIcon: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.all(10.r),
                              backgroundColor: AppColors.TertiaryColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(7.r))),
                          child: Text(
                            'Edit',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      )),
                ),
                SizedBox(
                  height: 30.h,
                ),
                // Phone Number
                TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0.r)),
                      hintText: 'Phone Number'),
                ),
                SizedBox(
                  height: 30.h,
                ),
                // Organization ID
                TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0.r)),
                      hintText: 'Organization ID'),
                ),
                SizedBox(
                  height: 80.h,
                ),
                // Save
                SizedBox(
                  width: 300.w,
                  height: 70.h,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.PrimaryColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.r)),
                        elevation: 5.h,
                        shadowColor: Colors.black),
                    child: Text(
                      'Save',
                      style: TextStyle(color: Colors.white, fontSize: 24.sp),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
