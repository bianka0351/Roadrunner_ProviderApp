import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../cubit/client_cubit.dart';
import '../../cubit/client_state.dart';

class CreateButtonWidget extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final ValueNotifier<bool> allFieldsFilledNotifier;
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController emailController;
  final TextEditingController phoneNumberController;
  final TextEditingController paymentMethodController;

  const CreateButtonWidget({
    required this.formKey,
    required this.allFieldsFilledNotifier,
    required this.firstNameController,
    required this.lastNameController,
    required this.emailController,
    required this.phoneNumberController,
    required this.paymentMethodController,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ClientCubit, ClientState>(
      listener: (context, state) {
        if (state is ClientFailure) {
          BotToast.showText(text: state.message);
        } else if (state is ClientSuccess) {
          BotToast.showText(text: 'Client created successfully!');
        }
      },
      builder: (context, state) {
        return ValueListenableBuilder<bool>(
          valueListenable: allFieldsFilledNotifier,
          builder: (context, allFieldsFilled, child) {
            return Center(
              child: ElevatedButton(
                onPressed: allFieldsFilled
                    ? () {
                        if (formKey.currentState!.validate()) {
                          context.read<ClientCubit>().createClient(
                            firstName: firstNameController.text,
                            lastName: lastNameController.text,
                            email: emailController.text,
                            phoneNumber: phoneNumberController.text,
                            paymentMethod: paymentMethodController.text,
                          );
                        }
                      }
                    : null, // Disable the button if not all fields are filled
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF38C3E4),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: 112.w,
                    vertical: 17.h,
                  ),
                ),
                child: Text(
                  'CREATE',
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    fontFamily: 'Inter',
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}