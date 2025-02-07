import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:roadrunner_provider_app/core/app-dimensions.dart';
import 'package:roadrunner_provider_app/core/app-fonts.dart';
import '../../../core/app_colors.dart';
import '../../bloc/time_block_request_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TimeBlockRequestScreen extends StatelessWidget {
  TimeBlockRequestScreen({Key? key}) : super(key: key);

  final TextEditingController noteController = TextEditingController();
  final DateFormat timeFormat = DateFormat.jm();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Time Block Request',
            style: TextStyle(
                fontSize: AppFonts.titleFontSize.sp,
                fontWeight: AppFonts.veryBold)),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Back action
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.menu), // Menu icon
            onPressed: () {
              // Add your menu action here
            },
          ),
        ],
      ),
      body: BlocConsumer<TimeBlockRequestBloc, TimeBlockRequestState>(
        listener: (context, state) {
          if (state is TimeBlockRequestSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Request submitted successfully!')),
            );
          } else if (state is TimeBlockRequestFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Error: ${state.errorMessage}')),
            );
          }
        },
        builder: (context, state) {
          final bloc = context.read<TimeBlockRequestBloc>();

          return Stack(
            children: [
              SingleChildScrollView(
                padding: const EdgeInsets.all(AppDimensions.mediumPadding),
                child: Container(
                  padding: EdgeInsets.all(AppDimensions.mediumPadding.sp),
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: AppDimensions.veryLargePadding.sp),
                      Text(
                        'Pick dates',
                        style: TextStyle(
                            fontWeight: AppFonts.semiBold,
                            fontSize: AppFonts.largeFontSize.sp),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          final selectedDates = await showDateRangePicker(
                            context: context,
                            firstDate: DateTime.now(),
                            lastDate:
                                DateTime.now().add(const Duration(days: 365)),
                          );
                          if (selectedDates != null) {
                            bloc.add(SelectDatesEvent([
                              selectedDates.start,
                              selectedDates.end,
                            ]));
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryHoverColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(AppDimensions
                                .smallBorderRadius), // Set border radius here
                          ),
                          elevation: AppDimensions.smallBlurRdius,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.calendar_today,
                              color: AppColors.lightTextColor,
                            ), // Calendar icon
                            SizedBox(
                                width: AppDimensions.smallPadding
                                    .sp), // Spacer between icon and text
                            Text('Time-Block Dates',
                                style:
                                    TextStyle(color: AppColors.lightTextColor)),
                          ],
                        ),
                      ),
                      if (state is DatesSelectedState)
                        Text(
                          ' ${state.selectedDates.map((date) => DateFormat.yMMMd().format(date)).join(', ')}',
                          style:
                              TextStyle(fontSize: AppFonts.mediumFontSize.sp),
                        ),
                      SizedBox(height: AppDimensions.hugePadding.sp),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Checkbox(
                            value: bloc.isAllDay,
                            onChanged: (value) {
                              bloc.add(ToggleAllDayEvent(value ?? false));
                            },
                            checkColor: AppColors.primaryHoverColor,
                            activeColor: AppColors.primaryColor,
                          ),
                          Text(
                            'All day',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: AppFonts.largeFontSize.sp),
                          ),
                          SizedBox(width: AppDimensions.mediumPadding.sp),
                          Row(
                            children: [
                              SizedBox(
                                width: AppDimensions.mediumWidth.sp,
                                child: ElevatedButton(
                                  onPressed: bloc.isAllDay
                                      ? null
                                      : () async {
                                          final time = await showTimePicker(
                                            context: context,
                                            initialTime: TimeOfDay.now(),
                                          );
                                          if (time != null) {
                                            final formattedTime =
                                                time.format(context);
                                            bloc.add(SetTimeRangeEvent(
                                              startTime: formattedTime,
                                              endTime: bloc.endTime,
                                            ));
                                          }
                                        },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        AppColors.primaryHoverColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          AppDimensions
                                              .smallBorderRadius), // Set border radius here
                                    ),
                                    elevation: AppDimensions.smallBlurRdius,
                                  ),
                                  child: Text(
                                    bloc.startTime == ''
                                        ? 'Start time'
                                        : '${bloc.startTime}',
                                    style: AppFonts.poppinsLight(),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: AppDimensions.smallPadding.sp),
                                child: Padding(
                                  padding:  EdgeInsets.only(bottom: AppDimensions.smallPadding.sp),
                                  child: SizedBox(
                                    width: 8,
                                    child: Text(
                                      '_',
                                      style: TextStyle(
                                          fontSize:
                                              AppFonts.extraLargeFontSize.sp,
                                          fontWeight: AppFonts.regular),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: AppDimensions.mediumWidth.sp,
                                child: ElevatedButton(
                                  onPressed: bloc.isAllDay
                                      ? null
                                      : () async {
                                          final time = await showTimePicker(
                                            context: context,
                                            initialTime: TimeOfDay.now(),
                                          );
                                          if (time != null) {
                                            final formattedTime =
                                                time.format(context);
                                            bloc.add(SetTimeRangeEvent(
                                              startTime: bloc.startTime,
                                              endTime: formattedTime,
                                            ));
                                          }
                                        },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        AppColors.primaryHoverColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          AppDimensions
                                              .smallBorderRadius), // Set border radius here
                                    ),
                                    elevation: AppDimensions.smallBlurRdius,
                                  ),
                                  child: Text(
                                    bloc.endTime == ''
                                        ? 'End time'
                                        : '${bloc.endTime}',
                                    style: AppFonts.poppinsLight(),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: AppDimensions.veryLargePadding.sp),
                      Container(
                        decoration: BoxDecoration(
                          color:
                              AppColors.textFormFillColor, // Background color
                          borderRadius:
                              BorderRadius.circular(12.0), // Border radius
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(
                                red: 0,
                                green: 0,
                                blue: 0,
                                alpha: 0.2, // Opacity value
                              ),
                              offset: Offset(0, 4), // Shadow offset
                              blurRadius: AppDimensions
                                  .smallBlurRdius, // Shadow blur radius
                            ),
                          ],
                        ),
                        child: TextField(
                          controller: noteController,
                          maxLines: 10,
                          decoration: InputDecoration(
                            hintText: 'WRITE A NOTE',
                            hintStyle: const TextStyle(
                              color: AppColors.blackTextColor,
                              fontWeight: AppFonts.semiBold,
                            ),
                            filled: true,
                            fillColor: AppColors.textFormFillColor,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                  AppDimensions.smallBorderRadius),
                              borderSide: BorderSide.none,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                  AppDimensions.smallBorderRadius),
                              borderSide: BorderSide.none,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                  AppDimensions.smallBorderRadius),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          onChanged: (value) {
                            bloc.add(AddNotesEvent(value));
                          },
                        ),
                      ),
                      SizedBox(height: AppDimensions.largePadding.sp),
                      ElevatedButton(
                        onPressed: () {
                          bloc.add(FetchRequestsEvent());
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryHoverColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                AppDimensions.smallBorderRadius),
                          ),
                          elevation: AppDimensions.smallBlurRdius,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.history,
                                color: AppColors.lightTextColor),
                            SizedBox(width: AppDimensions.smallPadding.sp),
                            Text('Fetch previous Time-blocks',
                                style: TextStyle(
                                    fontSize: AppFonts.smallFontSize.sp,
                                    color: AppColors.lightTextColor)),
                          ],
                        ),
                      ),
                      if (state is TimeBlockRequestsLoaded)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: AppDimensions.mediumPadding.sp),
                            Text(
                              'Previous Requests',
                              style: TextStyle(
                                  fontWeight: AppFonts.semiBold,
                                  fontSize: AppFonts.largeFontSize.sp),
                            ),
                            ...state.requests.map((request) => ListTile(
                                  title: Text(request.note),
                                  subtitle: Text(
                                      'Dates: ${request.selectedDates.map((date) => DateFormat.yMMMd().format(date)).join(', ')}'),
                                )),
                          ],
                        ),
                    ],
                  ),
                ),
              ),
              // Positioned the Send Button at the bottom of the screen
              Positioned(
                bottom: AppDimensions.hugeHeight.sp,
                left: 0,
                right: 0,
                child: Center(
                  child: ElevatedButton(
                    onPressed: state is! TimeBlockRequestSubmitting
                        ? () {
                            bloc.add(SubmitRequestEvent());
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                        horizontal: AppDimensions.largePadding.sp,
                        vertical: AppDimensions.smallPadding.sp,
                      ),
                      backgroundColor: AppColors.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            AppDimensions.smallBorderRadius),
                      ),
                      elevation: AppDimensions
                          .smallBlurRdius, // This adds a shadow effect
                    ),
                    child: state is TimeBlockRequestSubmitting
                        ? const CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : Text(
                            'Send The Request',
                            style: TextStyle(
                                fontSize: AppFonts.mainButtonFontSize.sp,
                                color: Colors.white),
                          ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
