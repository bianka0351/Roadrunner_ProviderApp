import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:roadrunner_provider_app/core/app_colors.dart';
import 'package:roadrunner_provider_app/features/profile/buisness_logic/bloc/profile_bloc.dart';
import 'package:roadrunner_provider_app/features/profile/buisness_logic/bloc/profile_event.dart';
import 'package:roadrunner_provider_app/features/profile/buisness_logic/bloc/profile_state.dart';
import 'package:roadrunner_provider_app/features/profile/presentaion/widget/profile_avatar_widget.dart';
import 'package:roadrunner_provider_app/features/profile/presentaion/widget/custom_switch_widget.dart';
import 'package:roadrunner_provider_app/features/profile/presentaion/widget/working_hours_widget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ProfileScreenState();
  }
}

class _ProfileScreenState extends State<ProfileScreen> {
  late bool _instantBookingSwitch;

  // Define controllers
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _organizationTitleController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<ProfileBloc>().add(FetchProfile());
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
      resizeToAvoidBottomInset: false,
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state is ProfileLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is ProfileError) {
            return Center(child: Text(state.message));
          } else if (state is ProfileLoaded) {
            final profile = state.profile;

            _usernameController.text = profile.username;
            _emailController.text = profile.email;
            _addressController.text = profile.address;
            _phoneNumberController.text = profile.phoneNumber;
            _organizationTitleController.text = profile.organizationTitle;
            _instantBookingSwitch = profile.instantBooking;

            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 40.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // profile image
                    Stack(children: [
                      ProfileAvatar(
                        imageUrl: profile.profileImage,
                        size: 70,
                      ),
                      Positioned(
                        bottom: 0.0,
                        right: 0.0,
                        child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                                shape: CircleBorder(),
                                backgroundColor: AppColors.primaryColor),
                            child: Icon(
                              Icons.edit,
                              color: Colors.white,
                            )),
                      )
                    ]),
                    SizedBox(
                      height: 20.h,
                    ),
                    // username
                    TextField(
                      controller: _usernameController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0.r)),
                          hintText: 'Username'),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    // Email
                    TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0.r)),
                          hintText: 'Email'),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    // Address
                    TextField(
                      controller: _addressController,
                      readOnly: true,
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
                                  backgroundColor: AppColors.secondaryColor,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(7.r))),
                              child: Text(
                                'Edit',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          )),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    // Phone Number
                    TextField(
                      controller: _phoneNumberController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0.r)),
                          hintText: 'PhoneNumber'),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    // Organization ID
                    TextField(
                      controller: _organizationTitleController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0.r)),
                          hintText: 'Organization ID'),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    // reset password
                    Align(
                      alignment: Alignment.centerLeft,
                      child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.all(10.r),
                              backgroundColor: AppColors.secondaryColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(7.r))),
                          child: Text(
                            'Reset Password',
                            style: TextStyle(color: Colors.white),
                          )),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    // instant booking
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        children: [
                          CustomSwitchWidget(
                            value: _instantBookingSwitch,
                            onChanged: (value) {
                              setState(() {});
                            },
                          ),
                          SizedBox(
                            width: 15.w,
                          ),
                          Text(
                            'Instant Booking',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.sp,
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    // Working Hours
                    WorkingHoursWidget(workingHours: {
                      'Monday - Tuesday': '10 am - 8 pm',
                      'Wednesday - Thursday': '11 am - 12 pm',
                      'Friday': '9 am - 6 pm',
                    }),
                    SizedBox(
                      height: 20.h,
                    ),
                    // Save
                    SizedBox(
                      width: 300.w,
                      height: 70.h,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.r)),
                            elevation: 5.h,
                            shadowColor: Colors.black),
                        child: Text(
                          'Save',
                          style:
                              TextStyle(color: Colors.white, fontSize: 24.sp),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                  ],
                ),
              ),
            );
          } else {
            return Center(child: Text('Unknown state'));
          }
        },
      ),
    );
  }
}
