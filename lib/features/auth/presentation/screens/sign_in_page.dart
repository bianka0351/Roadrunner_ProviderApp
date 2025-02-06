import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:roadrunner_provider_app/core/app_colors.dart';
import 'package:roadrunner_provider_app/features/auth/bloc/bloc/auth_bloc.dart';
import 'package:roadrunner_provider_app/features/auth/presentation/widgets/custom_button.dart';
import 'package:roadrunner_provider_app/features/auth/presentation/widgets/custom_password_text_field.dart';
import 'package:roadrunner_provider_app/features/auth/presentation/widgets/custom_text_field.dart';
import 'package:roadrunner_provider_app/features/home-page/presentation/screens/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  bool isValidPassword(String password) {
    final passwordRegExp = RegExp(r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d).{8,}$');
    return passwordRegExp.hasMatch(password);
  }

  bool staySignedIn = false;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadStaySignedIn();
  }

  Future<void> _loadStaySignedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool staySignedInPref = prefs.getBool('staySignedIn') ?? false;

    if (staySignedInPref) {
      Future.microtask(() {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      });
    } else {
      setState(() {
        staySignedIn = staySignedInPref;
        isLoading = false;
      });
    }
  }

  Future<void> _saveStaySignedIn(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('staySignedIn', value);
    setState(() {
      staySignedIn = value;
    });
  }

  void showCustomMessage({required String message, required IconData icon}) {
    BotToast.showCustomNotification(
      toastBuilder: (cancelFunc) => Container(
        padding: EdgeInsets.all(10.w),
        height: 36.h,
        width: 250.w,
        decoration: BoxDecoration(
          color: Color(0xffFFF0F0),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10.r,
              offset: Offset(0, 4.h),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: Color(0xffEB5454),
              size: 20.sp,
            ),
            SizedBox(width: 8.w),
            Text(
              message,
              style: TextStyle(
                color: Color(0xffEB5454),
                fontSize: 13.sp,
                fontFamily: 'Poppins-SemiBold',
              ),
            ),
          ],
        ),
      ),
      duration: Duration(seconds: 4),
      align: Alignment.lerp(Alignment.center, Alignment.bottomCenter, 0.4),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthLoading) {
            BotToast.showLoading(clickClose: false);
          } else if (state is AuthSuccess) {
            BotToast.closeAllLoading();
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          } else {
            BotToast.closeAllLoading();
            showCustomMessage(
                message: "The user is not a runner",
                icon: Icons.warning_amber_rounded);
          }
        },
        child: isLoading
            ? Center(child: CircularProgressIndicator())
            : Scaffold(
                backgroundColor: AppColors.whiteColor,
                body: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    child: Form(
                      key: _formfield,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: 70.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Road ',
                                style: TextStyle(
                                  fontSize: 38.sp,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w900,
                                  color: AppColors.blackColor,
                                ),
                              ),
                              Text(
                                'Runner',
                                style: TextStyle(
                                  fontSize: 38.sp,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w900,
                                  color: AppColors.lightBlueColor,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 40.h),
                          Center(
                            child: Text(
                              'Sign in',
                              style: TextStyle(
                                fontSize: 40.sp,
                                fontFamily: 'Poppins-SemiBold',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Center(
                            child: Text(
                              'Please sign in to your account',
                              style: TextStyle(
                                fontSize: 22.sp,
                                fontWeight: FontWeight.w200,
                                fontFamily: 'Poppins-Regular',
                                color: AppColors.blackColor,
                              ),
                            ),
                          ),
                          SizedBox(height: 24.h),
                          CustomTextField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please enter your Org ID.  ";
                                }
                                return null;
                              },
                              hintText: 'Organization-ID',
                              controller: organizationIdController),
                          SizedBox(height: 16.h),
                          CustomTextField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please enter your UserName.  ";
                                }
                                return null;
                              },
                              hintText: 'User-Name',
                              controller: userNameController),
                          SizedBox(height: 16.h),
                          CustomPasswordTextField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please enter your Password.  ";
                                }
                                if (!isValidPassword(value)) {
                                  return 'Password must be at least 8 characters,\ninclude an uppercase letter,\na lowercase letter, and a number.';
                                }
                                return null;
                              },
                              hintText: ' Password',
                              controller: passwordController),
                          SizedBox(height: 16.h),
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
                              Checkbox(
                                activeColor: AppColors.darkBlueColor,
                                side: BorderSide(
                                  color: AppColors.darkBlueColor,
                                ),
                                value: staySignedIn,
                                onChanged: (value) async {
                                  await _saveStaySignedIn(value!);
                                },
                              ),
                              Text(
                                'Stay signed in',
                                style: TextStyle(
                                  fontFamily: 'Poppins-Regular',
                                  fontSize: 16.sp,
                                ),
                              ),
                              SizedBox(width: 50.w),
                              TextButton(
                                  onPressed: () {},
                                  child: Text(
                                    'Forget Password?',
                                    style: TextStyle(
                                      color: AppColors.darkBlueColor,
                                      fontSize: 16.sp,
                                      fontFamily: 'Inter',
                                    ),
                                  ))
                            ],
                          ),
                          SizedBox(height: 130.h),
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
                            padding: EdgeInsets.symmetric(horizontal: 20.w),
                            child: RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                text:
                                    'By Registering, you are agree to Road Runner ',
                                style: TextStyle(
                                  fontFamily: 'Poppins-SemiBold',
                                  fontSize: 12.sp,
                                  color: AppColors.greyColor,
                                ),
                                children: [
                                  TextSpan(
                                    text: 'User Agreement',
                                    style: TextStyle(
                                      fontFamily: 'Poppins-SemiBold',
                                      color: AppColors.darkBlueColor,
                                      fontSize: 12.sp,
                                    ),
                                  ),
                                  TextSpan(
                                      text: ' and ',
                                      style: TextStyle(
                                        fontFamily: 'Poppins-SemiBold',
                                        fontSize: 12.sp,
                                      )),
                                  TextSpan(
                                    text: 'Cookies & Internet Advertising.',
                                    style: TextStyle(
                                      fontFamily: 'Poppins-SemiBold',
                                      color: AppColors.darkBlueColor,
                                      fontSize: 12.sp,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ));
  }
}
