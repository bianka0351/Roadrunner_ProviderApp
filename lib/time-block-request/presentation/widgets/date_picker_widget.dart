import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roadrunner_provider_app/core/constants/app_colors.dart';
import 'package:roadrunner_provider_app/core/constants/app_dimensions.dart';
import 'package:roadrunner_provider_app/core/constants/app_fonts.dart';
import '../../bloc/time_block_request_bloc.dart';
import '../../bloc/time_block_request_event.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DatePickerWidget extends StatelessWidget {
  const DatePickerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<TimeBlockRequestBloc>();

    return ElevatedButton(
      onPressed: () async {
        final selectedDates = await showDateRangePicker(
          context: context,
          firstDate: DateTime.now(),
          lastDate: DateTime.now().add(const Duration(days: 365)),
          builder: (context, child) {
            return Theme(
              data: Theme.of(context).copyWith(
                colorScheme: ColorScheme.light(
                  primary: AppColors.primaryColor,
                ),
                textButtonTheme: TextButtonThemeData(
                  style: TextButton.styleFrom(
                    foregroundColor: AppColors.primaryColor,
                  ),
                ),
                datePickerTheme: DatePickerThemeData(
                  rangePickerBackgroundColor: Colors.white,
                  rangePickerSurfaceTintColor: AppColors.primaryColor,
                  rangePickerHeaderBackgroundColor: AppColors.primaryColor,
                  rangePickerHeaderForegroundColor: Colors.white,
                  rangePickerShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  rangePickerElevation: 4.0,
                  rangePickerShadowColor: const Color(0x33000000),
                  rangeSelectionBackgroundColor:
                      AppColors.primaryColor.withAlpha(51),
                  rangePickerHeaderHeadlineStyle: TextStyle(
                    fontFamily: AppFonts.poppinsFontFamily,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  rangePickerHeaderHelpStyle: TextStyle(
                    fontFamily: AppFonts.poppinsFontFamily,
                    fontSize: 14.0,
                    color: const Color(0xCCFFFFFF),
                  ),
                ),
              ),
              child: child!,
            );
          },
        );
        if (selectedDates != null) {
          bloc.add(SelectDatesEvent([selectedDates.start, selectedDates.end]));
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.secondaryColor,
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(AppDimensions.smallBorderRadius.r),
        ),
        elevation: AppDimensions.smallBlurRdius.r,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.calendar_today,
            color: AppColors.lightTextColor,
          ),
          SizedBox(width: AppDimensions.smallPadding.w),
          Text(
            'Time-Block Dates',
            style: TextStyle(
              fontFamily: AppFonts.poppinsFontFamily,
              color: AppColors.lightTextColor,
            ),
          ),
        ],
      ),
    );
  }
}
