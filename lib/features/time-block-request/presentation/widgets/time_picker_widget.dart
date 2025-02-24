import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roadrunner_provider_app/core/constants/app_colors.dart';
import 'package:roadrunner_provider_app/core/constants/app_dimensions.dart';
import 'package:roadrunner_provider_app/core/constants/app_fonts.dart';
import '../../bloc/time_block_request_bloc.dart';
import '../../bloc/time_block_request_event.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../bloc/time_block_request_state.dart';

class TimePickerWidget extends StatelessWidget {
  final bool isStartTime;

  const TimePickerWidget({
    super.key,
    required this.isStartTime,
  });

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<TimeBlockRequestBloc>();

    return BlocBuilder<TimeBlockRequestBloc, TimeBlockRequestState>(
      builder: (context, state) {
        // Determine the time to display based on whether it's the start or end time
        final time = isStartTime ? bloc.startTime : bloc.endTime;
        final placeholderText = isStartTime ? 'Start time' : 'End time';

        return SizedBox(
          width: AppDimensions.mediumWidth.w,
          child: ElevatedButton(
            onPressed: bloc.isAllDay
                ? null
                : () async {
                    final selectedTime = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
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
                          ),
                          child: child!,
                        );
                      },
                    );

                    if (selectedTime != null) {
                      // ignore: use_build_context_synchronously
                      final formattedTime = selectedTime.format(context);
                      if (isStartTime) {
                        bloc.add(SetTimeRangeEvent(
                          startTime: formattedTime,
                          endTime: bloc.endTime,
                        ));
                      } else {
                        bloc.add(SetTimeRangeEvent(
                          startTime: bloc.startTime,
                          endTime: formattedTime,
                        ));
                      }
                    }
                  },
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(
                horizontal: AppDimensions.smallPadding.w,
              ),
              backgroundColor: AppColors.secondaryColor,
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(AppDimensions.smallBorderRadius.r),
              ),
              elevation: AppDimensions.smallBlurRdius,
            ),
            child: Text(
              time.isEmpty ? placeholderText : time,
              style: AppFonts.poppinsLight(color: AppColors.lightTextColor),
            ),
          ),
        );
      },
    );
  }
}