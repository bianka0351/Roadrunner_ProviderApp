import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roadrunner_provider_app/core/constants/app_colors.dart';
import 'package:roadrunner_provider_app/core/constants/app_dimensions.dart';
import 'package:roadrunner_provider_app/core/constants/app_fonts.dart';
import '../../bloc/time_block_request_bloc.dart';
import '../../bloc/time_block_request_event.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NoteInputWidget extends StatelessWidget {
  final TextEditingController controller;

  const NoteInputWidget({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<TimeBlockRequestBloc>();

    return Container(
      decoration: BoxDecoration(
        color: AppColors.tritiaryColor,
        borderRadius: BorderRadius.circular(AppDimensions.smallBorderRadius.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(
              red: 0,
              green: 0,
              blue: 0,
              alpha: 0.2,
            ),
            offset: const Offset(0, 4),
            blurRadius: AppDimensions.smallBlurRdius,
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        maxLines: 10,
        decoration: InputDecoration(
          hintText: 'WRITE A NOTE',
          hintStyle: const TextStyle(
            fontFamily: AppFonts.poppinsFontFamily,
            color: Color(0x00ff0000),
            fontWeight: AppFonts.semiBold,
          ),
          filled: true,
          fillColor: AppColors.tritiaryColor,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppDimensions.smallBorderRadius.r),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppDimensions.smallBorderRadius.r),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppDimensions.smallBorderRadius.r),
            borderSide: BorderSide.none,
          ),
        ),
        onChanged: (value) {
          bloc.add(AddNotesEvent(value));
        },
      ),
    );
  }
}