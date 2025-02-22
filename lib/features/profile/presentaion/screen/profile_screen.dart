import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:roadrunner_provider_app/core/app_colors.dart';
import 'package:roadrunner_provider_app/core/app_fonts.dart';
import 'package:roadrunner_provider_app/core/widgets/custom_button.dart';
import 'package:roadrunner_provider_app/core/widgets/custom_text_field.dart';
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Runner Profile',
            style: AppFonts.poppinsSemiBold(fontSize: 32.sp)),
        centerTitle: true,
        actions: [
          PopupMenuButton<String>(
            color: Colors.white,
            icon: Icon(Icons.menu),
            onSelected: (value) {
              if (value == "profile") {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return ProfileScreen();
                }));
              }
            },
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem<String>(
                  value: "profile",
                  child: Text("Profile"),
                ),
              ];
            },
          ),
        ],
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
                    CustomTextField(
                        hintText: 'Username', controller: _usernameController),

                    SizedBox(
                      height: 20.h,
                    ),
                    // Email
                    CustomTextField(
                        hintText: 'Email', controller: _emailController),

                    SizedBox(
                      height: 20.h,
                    ),
                    // Address
                    TextField(
                      controller: _addressController,
                      readOnly: true,
                      decoration: InputDecoration(
                        suffixIcon: Padding(
                          padding: const EdgeInsets.all(5),
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                                fixedSize: Size(60.w, 37.h),
                                padding: EdgeInsets.all(10.r),
                                backgroundColor: AppColors.secondaryColor,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(7.r))),
                            child: Text(
                              'Edit',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        fillColor: Colors.white,
                        filled: true,
                        labelText: 'Address',
                        labelStyle: AppFonts.poppinsRegular(
                          fontSize: 20.sp,
                          color: Color(0xFFB2B2C2),
                        ),
                        floatingLabelStyle: AppFonts.poppinsRegular(
                            fontSize: 20.sp, color: AppColors.secondaryColor),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.r),
                          borderSide: BorderSide(color: Color(0xFFDDDDDD)),
                        ),
                        errorStyle: TextStyle(color: AppColors.errorColor),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: AppColors.errorColor),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: AppColors.secondaryColor),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 12.h,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    // Phone Number
                    CustomTextField(
                        hintText: 'Phone Number',
                        controller: _phoneNumberController),

                    SizedBox(
                      height: 20.h,
                    ),
                    // Organization ID
                    CustomTextField(
                      hintText: 'Organization Name',
                      controller: _organizationTitleController,
                      readOnly: true,
                    ),

                    // reset password
                    Align(
                      alignment: Alignment.centerLeft,
                      child: TextButton(
                          onPressed: () {},
                          child: Text(
                            'Reset Password',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,
                              decoration: TextDecoration.underline,
                              decorationColor: AppColors.secondaryColor,
                              decorationThickness: 2,
                              color: AppColors.secondaryColor,
                            ),
                          )),
                    ),
                    SizedBox(
                      height: 10.h,
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
                      height: 10.h,
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
                    CustomButton(text: "Save", onpressed: () {}),
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
