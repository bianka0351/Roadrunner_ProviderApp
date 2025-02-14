import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:roadrunner_provider_app/core/app_colors.dart';
import 'package:roadrunner_provider_app/core/app_fonts.dart';
import 'package:roadrunner_provider_app/core/widgets/custom_error_message.dart';
import 'package:roadrunner_provider_app/features/auth/bloc/bloc/auth_bloc.dart';
import 'package:roadrunner_provider_app/features/auth/presentation/widgets/custom_button.dart';
import 'package:roadrunner_provider_app/features/auth/presentation/widgets/custom_password_text_field.dart';
import 'package:roadrunner_provider_app/features/auth/presentation/widgets/custom_road_runner.dart';
import 'package:roadrunner_provider_app/features/auth/presentation/widgets/custom_text_field.dart';
import 'package:roadrunner_provider_app/features/home-page/presentation/screens/home_page.dart';
import 'package:roadrunner_provider_app/main.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final obscure = ValueNotifier(true);
  TextEditingController organizationIdController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  // TextEditingController phoneNumberController = TextEditingController();
  final _formfield = GlobalKey<FormState>();
  // bool isValidUSPhoneNumber(String phoneNumber) {
  //   final usPhoneNumberRegExp = RegExp(r'^(?:\+1\s?)?(\d{3}[-.\s]?){2}\d{4}$');
  //   return usPhoneNumberRegExp.hasMatch(phoneNumber);
  // }

  // bool isValidPassword(String password) {
  //   final passwordRegExp = RegExp(r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d).{8,}$');
  //   return passwordRegExp.hasMatch(password);
  // }

  final ValueNotifier<bool> staySignedIn = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthLoading) {
            BotToast.showLoading(clickClose: false);
          } else if (state is AuthSuccess) {
            BotToast.closeAllLoading();
            if (staySignedIn.value) {
              sharedPref.setString("id", "${state.auth!.id}");
            }
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          } else if (state is AuthFailure) {
            BotToast.closeAllLoading();
            CustomErrorMessage().showCustomMessage(
                message: "Your email/username and password is incorrect.",
                icon: Icons.warning_amber_rounded);
          }
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.white,
          body: Stack(
            alignment: Alignment.topCenter,
            children: [
              SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 70.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomRoadRunner(
                            text: 'Road',
                            color: Colors.black,
                            fontSize: 38.sp,
                          ),
                          CustomRoadRunner(
                            text: ' Runner',
                            color: AppColors.primaryColor,
                            fontSize: 38.sp,
                          )
                        ],
                      ),
                      SizedBox(height: 40.h),
                      Center(
                        child: Text('Sign in',
                            style: AppFonts.poppinsSemiBold(fontSize: 40.sp)),
                      ),
                      SizedBox(height: 8.h),
                      Center(
                        child: Text('Please sign in to your account',
                            style: AppFonts.poppinsRegular(fontSize: 20.sp)),
                      ),
                      SizedBox(height: 24.h),
                      Form(
                        key: _formfield,
                        child: Column(
                          children: [
                            CustomTextField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Please enter your Org ID.  ";
                                  }
                                  return null;
                                },
                                hintText: 'Organization ID',
                                controller: organizationIdController),
                            SizedBox(height: 16.h),
                            CustomTextField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Please enter your UserName.  ";
                                  }
                                  return null;
                                },
                                hintText: 'User Name',
                                controller: userNameController),
                            SizedBox(height: 16.h),
                            CustomPasswordTextField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Please enter your Password.  ";
                                  }
                                  // if (!isValidPassword(value)) {
                                  //   return 'Password must be at least 8 characters,\ninclude an uppercase letter,\na lowercase letter, and a number.';
                                  // }
                                  return null;
                                },
                                hintText: 'Password',
                                controller: passwordController),
                          ],
                        ),
                      ),
                      // CustomTextField(
                      //     validator: (value) {
                      //       if (value == null || value.isEmpty) {
                      //         return "Please enter your phone number ";
                      //       } else if (!isValidUSPhoneNumber(value)) {
                      //         return 'Invalid US phone number';
                      //       }
                      //       return null;
                      //     },
                      //     hintText: ' Phone Number',
                      //     controller: phoneNumberController),
                      // SizedBox(height: 10.h),
                      Row(
                        children: [
                          ValueListenableBuilder(
                              valueListenable: staySignedIn,
                              builder: (context, value, _) {
                                return Checkbox(
                                  activeColor: AppColors.secondaryColor,
                                  side: BorderSide(
                                    color: AppColors.secondaryColor,
                                  ),
                                  value: staySignedIn.value,
                                  onChanged: (value) {
                                    staySignedIn.value = value!;
                                  },
                                );
                              }),
                          Text('Stay signed in',
                              style: AppFonts.poppinsRegular(fontSize: 16.sp)),
                          SizedBox(width: 70.w),
                          TextButton(
                            onPressed: () {},
                            child: Text('Forget Password?',
                                style: AppFonts.poppinsRegular(
                                  fontSize: 16.sp,
                                  color: AppColors.secondaryColor,
                                )),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Center(
                        child: CustomButton(
                            text: 'Sign in',
                            onpressed: () {
                              if (_formfield.currentState!.validate()) {
                                context.read<AuthBloc>().add(SignInEvent(
                                      organizationId:
                                          organizationIdController.text,
                                      userName: userNameController.text,
                                      password: passwordController.text,
                                      // phoneNumber: phoneNumberController.text,
                                    ));
                              }
                              return false;
                            })),
                    SizedBox(height: 10.h),
                    Divider(
                      thickness: 1.h,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: 20.w, right: 20.w, bottom: 20.h),
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          text:
                              '   By Registering, you are agree to Road Runner ',
                          style: AppFonts.poppinsSemiBold(
                            fontSize: 12.sp,
                            color: AppColors.tritiaryColor,
                          ),
                          children: [
                            TextSpan(
                              text: 'User Agreement',
                              style: AppFonts.poppinsSemiBold(
                                fontSize: 12.sp,
                                color: AppColors.secondaryColor,
                              ),
                            ),
                            TextSpan(
                              text: ' and ',
                              style: AppFonts.poppinsSemiBold(
                                fontSize: 12.sp,
                                color: AppColors.tritiaryColor,
                              ),
                            ),
                            TextSpan(
                              text: 'Cookies & Internet Advertising.',
                              style: AppFonts.poppinsSemiBold(
                                fontSize: 12.sp,
                                color: AppColors.secondaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
