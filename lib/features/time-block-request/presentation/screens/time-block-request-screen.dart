
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roadrunner_provider_app/core/constants/app_dimensions.dart';
import 'package:roadrunner_provider_app/core/constants/app_fonts.dart';
import 'package:roadrunner_provider_app/core/constants/app_colors.dart';
import 'package:roadrunner_provider_app/core/network/bloc/network_bloc.dart';
import 'package:roadrunner_provider_app/core/network/bloc/network_state.dart';
import 'package:roadrunner_provider_app/core/utils/text_scale_util.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../bloc/time_block_request_bloc.dart';
import '../../bloc/time_block_request_event.dart';
import '../../bloc/time_block_request_state.dart';
import '../widgets/app_bar_widget.dart';
import '../widgets/date_picker_widget.dart';
import '../widgets/note_input_widget.dart';
import '../widgets/submit_button_widget.dart';
import '../widgets/time_picker_widget.dart';

class TimeBlockRequestScreen extends StatelessWidget {
  TimeBlockRequestScreen({super.key});

  final TextEditingController noteController = TextEditingController();
 // final DateFormat timeFormat = DateFormat.jm();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          onBackPressed: () {
            Navigator.pop(context);
          },
          onMenuPressed: () {},
        ),
        body: TextScaleUtil.constantTextScale(
          child: BlocConsumer<TimeBlockRequestBloc, TimeBlockRequestState>(
            listener: (context, state) {
              if (state is TimeBlockRequestSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text('Request submitted successfully!')),
                );
              } else if (state is TimeBlockRequestFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Error: ${state.errorMessage}')),
                );
              }
            },
            builder: (context, state) {
              final bloc = context.read<TimeBlockRequestBloc>();

              return BlocListener<NetworkBloc, NetworkState>(
                listener: (context, state) {
                  if (state is NetworkConnectedState) {
                    if (!state.isFirstLoad) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Internet connection restored!')),
                      );
                    }
                  } else if (state is NetworkDisconnectedState) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('No internet connection!')),
                    );
                  }
                },
                child: Stack(
                  children: [
                    SingleChildScrollView(
                      padding: EdgeInsets.symmetric(
                        vertical: AppDimensions.mediumPadding.h,
                        horizontal: AppDimensions.mediumPadding.w,
                      ),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: AppDimensions.mediumPadding.w,
                        ),
                        height: 550.h,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: AppDimensions.veryLargePadding.h),
                            Text(
                              'Pick dates',
                              style: TextStyle(
                                fontFamily: AppFonts.poppinsFontFamily,
                                fontWeight: AppFonts.semiBold,
                                fontSize: 20.sp,
                              ),
                            ),
                            const DatePickerWidget(),
                            if ((state is DatesSelectedState ||
                                    state is AllDayToggledState) &&
                                (state is DatesSelectedState
                                    ? (state).selectedDates.isNotEmpty
                                    : (state as AllDayToggledState)
                                        .selectedDates
                                        .isNotEmpty))
                              // Text(
                              //   'Selected Dates: ${(state is DatesSelectedState ? (state).selectedDates : (state as AllDayToggledState).selectedDates).map((date) => DateFormat.yMMMd().format(date)).join(' - ')}',
                              //   style: TextStyle(
                              //     fontFamily: AppFonts.poppinsFontFamily,
                              //     fontSize: 11.sp,
                              //   ),
                              // ),
                            SizedBox(height: AppDimensions.hugePadding.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Checkbox(
                                  value: bloc.isAllDay,
                                  onChanged: (value) {
                                    bloc.add(ToggleAllDayEvent(value ?? false));
                                  },
                                  checkColor: AppColors.secondaryColor,
                                  activeColor: AppColors.primaryColor,
                                ),
                                Text(
                                  'All day',
                                  style: TextStyle(
                                    fontFamily: AppFonts.poppinsFontFamily,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14.sp,
                                  ),
                                ),
                                SizedBox(width: AppDimensions.mediumPadding.w),
                                Row(
                                  children: [
                                    TimePickerWidget(
                                      isStartTime: true,
                                      // time: bloc.startTime,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal:
                                            AppDimensions.smallPadding.w,
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            bottom:
                                                AppDimensions.smallPadding.h),
                                        child: SizedBox(
                                          width: 8,
                                          child: Text(
                                            '_',
                                            style: TextStyle(
                                              fontFamily:
                                                  AppFonts.poppinsFontFamily,
                                              fontSize: 26.sp,
                                              fontWeight: AppFonts.regular,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    TimePickerWidget(
                                      isStartTime: false,
                                      //  time: bloc.endTime,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: AppDimensions.veryLargePadding.sp),
                            NoteInputWidget(controller: noteController),
                            SizedBox(height: AppDimensions.largePadding.h),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: AppDimensions.smallHeight.h,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: BlocBuilder<NetworkBloc, NetworkState>(
                          builder: (context, networkState) {
                            final isConnected =
                                networkState is NetworkConnectedState;
                            return isConnected
                                ? const SubmitButtonWidget()
                                : Container();
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
