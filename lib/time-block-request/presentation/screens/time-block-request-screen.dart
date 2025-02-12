// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:intl/intl.dart';
// import 'package:roadrunner_provider_app/core/app_dimensions.dart';
// import 'package:roadrunner_provider_app/core/app_fonts.dart';
// import '../../../core/app_colors.dart';
// import '../../../core/network/bloc/network_bloc.dart';
// import '../../../core/network/bloc/network_state.dart';
// import '../../../core/utils/text_scale_util.dart';
// import '../../bloc/time_block_request_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// import '../../bloc/time_block_request_event.dart';
// import '../../bloc/time_block_request_state.dart';

// class TimeBlockRequestScreen extends StatelessWidget {
//   TimeBlockRequestScreen({super.key});

//   final TextEditingController noteController = TextEditingController();
//   final DateFormat timeFormat = DateFormat.jm();

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//         child: Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         backgroundColor: Colors.transparent,
//         elevation: 0, // Remove shadow
//         title: Text('Time Block Request',
//             style: TextStyle(
//               fontFamily: AppFonts.poppinsFontFamily,
//               fontSize: AppFonts.titleFontSize.sp,
//               fontWeight: AppFonts.veryBold,
//             )),
//         centerTitle: true,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.menu),
//             onPressed: () {},
//           ),
//         ],
//       ),
//       body: TextScaleUtil.constantTextScale(
//         child:
//             //  BlocConsumer<TimeBlockRequestBloc, TimeBlockRequestState>(
//             //   listener: (context, state) {
//             //     if (state is TimeBlockRequestSuccess) {
//             //       ScaffoldMessenger.of(context).showSnackBar(
//             //         const SnackBar(
//             //             content: Text('Request submitted successfully!')),
//             //       );
//             //     } else if (state is TimeBlockRequestFailure) {
//             //       ScaffoldMessenger.of(context).showSnackBar(
//             //         SnackBar(content: Text('Error: ${state.errorMessage}')),
//             //       );
//             //     }
//             //   },
//             BlocConsumer<TimeBlockRequestBloc, TimeBlockRequestState>(
//           listener: (context, state) {
//             if (state is TimeBlockRequestSuccess) {
//               ScaffoldMessenger.of(context).showSnackBar(
//                 const SnackBar(
//                     content: Text('Request submitted successfully!')),
//               );
//             } else if (state is TimeBlockRequestFailure) {
//               ScaffoldMessenger.of(context).showSnackBar(
//                 SnackBar(content: Text('Error: ${state.errorMessage}')),
//               );
//             }
//           },
//           builder: (context, state) {
//             final bloc = context.read<TimeBlockRequestBloc>();

//             return BlocListener<NetworkBloc, NetworkState>(
//               listener: (context, state) {
//                 if (state is NetworkConnectedState) {
//                   // Do NOT show Snackbar for NetworkConnectedState during the first load
//                   if (!state.isFirstLoad) {
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       const SnackBar(
//                           content: Text('Internet connection restored!')),
//                     );
//                   }
//                 } else if (state is NetworkDisconnectedState) {
//                   // Show Snackbar for NetworkDisconnectedState only during the first load or while the app is running
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     const SnackBar(content: Text('No internet connection!')),
//                   );
//                 }
//               },
//               child: Stack(
//                 children: [
//                   SingleChildScrollView(
//                     padding: EdgeInsets.symmetric(
//                       vertical: AppDimensions.mediumPadding.h,
//                       horizontal: AppDimensions.mediumPadding.w,
//                     ),
//                     child: Container(
//                       padding: EdgeInsets.symmetric(
//                         horizontal: AppDimensions.mediumPadding.w,
//                       ),
//                       height: 550.h,
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           SizedBox(height: AppDimensions.veryLargePadding.h),
//                           Text(
//                             'Pick dates',
//                             style: TextStyle(
//                               fontFamily: AppFonts.poppinsFontFamily,
//                               fontWeight: AppFonts.semiBold,
//                               fontSize: AppFonts.largeFontSize.sp,
//                             ),
//                           ),
//                           BlocBuilder<NetworkBloc, NetworkState>(
//                             builder: (context, networkState) {
//                               return ElevatedButton(
//                                 onPressed: () async {
//                                   final selectedDates =
//                                       await showDateRangePicker(
//                                     context: context,
//                                     firstDate: DateTime.now(),
//                                     lastDate: DateTime.now()
//                                         .add(const Duration(days: 365)),
//                                     builder: (context, child) {
//                                       return Theme(
//                                         data: Theme.of(context).copyWith(
//                                           colorScheme: ColorScheme.light(
//                                             primary: AppColors
//                                                 .primaryColor, // Use your custom color
//                                           ),
//                                           textButtonTheme: TextButtonThemeData(
//                                             style: TextButton.styleFrom(
//                                               foregroundColor: AppColors
//                                                   .primaryColor, // Button text color
//                                             ),
//                                           ),
//                                           datePickerTheme: DatePickerThemeData(
//                                             rangePickerBackgroundColor: Colors
//                                                 .white, // Background color
//                                             rangePickerSurfaceTintColor: AppColors
//                                                 .primaryColor, // Surface tint color
//                                             rangePickerHeaderBackgroundColor:
//                                                 AppColors
//                                                     .primaryColor, // Header background color
//                                             rangePickerHeaderForegroundColor:
//                                                 Colors
//                                                     .white, // Header text color
//                                             rangePickerShape:
//                                                 RoundedRectangleBorder(
//                                               borderRadius:
//                                                   BorderRadius.circular(
//                                                       12.0), // Border radius
//                                             ),
//                                             rangePickerElevation:
//                                                 4.0, // Elevation
//                                             rangePickerShadowColor: const Color(
//                                                 0x33000000), // Shadow color with 20% opacity
//                                             rangeSelectionBackgroundColor:
//                                                 AppColors.primaryColor.withAlpha(
//                                                     51), // 20% opacity (51 = 0.2 * 255)
//                                             rangePickerHeaderHeadlineStyle:
//                                                 TextStyle(
//                                               fontFamily:
//                                                   AppFonts.poppinsFontFamily,
//                                               fontSize: 20.0,
//                                               fontWeight: FontWeight.bold,
//                                               color: Colors.white,
//                                             ),
//                                             rangePickerHeaderHelpStyle:
//                                                 TextStyle(
//                                               fontFamily:
//                                                   AppFonts.poppinsFontFamily,
//                                               fontSize: 14.0,
//                                               color: const Color(
//                                                   0xCCFFFFFF), // 80% opacity (0xCC = 0.8 * 255)
//                                             ),
//                                           ),
//                                         ),
//                                         child: child!,
//                                       );
//                                     },
//                                   );
//                                   if (selectedDates != null) {
//                                     bloc.add(SelectDatesEvent([
//                                       selectedDates.start,
//                                       selectedDates.end,
//                                     ]));
//                                   }
//                                 },
//                                 style: ElevatedButton.styleFrom(
//                                   backgroundColor: AppColors.primaryHoverColor,
//                                   shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(
//                                         AppDimensions.smallBorderRadius.r),
//                                   ),
//                                   elevation: AppDimensions.smallBlurRdius.r,
//                                 ),
//                                 child: Row(
//                                   mainAxisSize: MainAxisSize.min,
//                                   children: [
//                                     Icon(
//                                       Icons.calendar_today,
//                                       color: AppColors.lightTextColor,
//                                     ),
//                                     SizedBox(
//                                         width: AppDimensions.smallPadding.w),
//                                     Text(
//                                       'Time-Block Dates',
//                                       style: TextStyle(
//                                         fontFamily: AppFonts.poppinsFontFamily,
//                                         color: AppColors.lightTextColor,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               );
//                             },
//                           ),
//                           if ((state is DatesSelectedState ||
//                                   state is AllDayToggledState) &&
//                               (state is DatesSelectedState
//                                   ? (state).selectedDates.isNotEmpty
//                                   : (state as AllDayToggledState)
//                                       .selectedDates
//                                       .isNotEmpty))
//                             Text(
//                               'Selected Dates: ${(state is DatesSelectedState ? (state).selectedDates : (state as AllDayToggledState).selectedDates).map((date) => DateFormat.yMMMd().format(date)).join(' - ')}',
//                               style: TextStyle(
//                                 fontFamily: AppFonts.poppinsFontFamily,
//                                 fontSize: AppFonts.smallFontSize.sp,
//                               ),
//                             ),
//                           SizedBox(height: AppDimensions.hugePadding.h),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             children: [
//                               Checkbox(
//                                 value: bloc.isAllDay,
//                                 onChanged: (value) {
//                                   bloc.add(ToggleAllDayEvent(value ?? false));
//                                 },
//                                 checkColor: AppColors.primaryHoverColor,
//                                 activeColor: AppColors.primaryColor,
//                               ),
//                               Text(
//                                 'All day',
//                                 style: TextStyle(
//                                   fontFamily: AppFonts.poppinsFontFamily,
//                                   fontWeight: FontWeight.bold,
//                                   fontSize: AppFonts.mediumFontSize.sp,
//                                 ),
//                               ),
//                               SizedBox(width: AppDimensions.mediumPadding.w),
//                               Row(
//                                 children: [
//                                   BlocBuilder<NetworkBloc, NetworkState>(
//                                     builder: (context, networkState) {
//                                       return SizedBox(
//                                         width: AppDimensions.mediumWidth.w,
//                                         child: ElevatedButton(
//                                           onPressed: bloc.isAllDay
//                                               ? null
//                                               : () async {
//                                                   final time =
//                                                       await showTimePicker(
//                                                     context: context,
//                                                     initialTime:
//                                                         TimeOfDay.now(),
//                                                     builder: (context, child) {
//                                                       return Theme(
//                                                         data: Theme.of(context)
//                                                             .copyWith(
//                                                           colorScheme:
//                                                               ColorScheme.light(
//                                                             primary: AppColors
//                                                                 .primaryColor, // Use your custom color
//                                                           ),
//                                                           textButtonTheme:
//                                                               TextButtonThemeData(
//                                                             style: TextButton
//                                                                 .styleFrom(
//                                                               foregroundColor:
//                                                                   AppColors
//                                                                       .primaryColor, // Button text color
//                                                             ),
//                                                           ),
//                                                         ),
//                                                         child: child!,
//                                                       );
//                                                     },
//                                                   );

//                                                   if (time != null) {
//                                                     final formattedTime =
//                                                         time.format(context);
//                                                     bloc.add(SetTimeRangeEvent(
//                                                       startTime: formattedTime,
//                                                       endTime: bloc.endTime,
//                                                     ));
//                                                   }
//                                                 },
//                                           style: ElevatedButton.styleFrom(
//                                             padding: EdgeInsets.symmetric(
//                                               horizontal:
//                                                   AppDimensions.smallPadding.w,
//                                             ),
//                                             backgroundColor:
//                                                 AppColors.primaryHoverColor,
//                                             shape: RoundedRectangleBorder(
//                                               borderRadius:
//                                                   BorderRadius.circular(
//                                                       AppDimensions
//                                                           .smallBorderRadius.r),
//                                             ),
//                                             elevation:
//                                                 AppDimensions.smallBlurRdius,
//                                           ),
//                                           child: Text(
//                                             bloc.startTime == ''
//                                                 ? 'Start time'
//                                                 : bloc.startTime,
//                                             style: AppFonts.poppinsLight(),
//                                           ),
//                                         ),
//                                       );
//                                     },
//                                   ),
//                                   Padding(
//                                     padding: EdgeInsets.symmetric(
//                                       horizontal: AppDimensions.smallPadding.w,
//                                     ),
//                                     child: Padding(
//                                       padding: EdgeInsets.only(
//                                           bottom: AppDimensions.smallPadding.h),
//                                       child: SizedBox(
//                                         width: 8,
//                                         child: Text(
//                                           '_',
//                                           style: TextStyle(
//                                             fontFamily:
//                                                 AppFonts.poppinsFontFamily,
//                                             fontSize:
//                                                 AppFonts.extraLargeFontSize.sp,
//                                             fontWeight: AppFonts.regular,
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                   BlocBuilder<NetworkBloc, NetworkState>(
//                                     builder: (context, networkState) {
//                                       return SizedBox(
//                                         width: AppDimensions.mediumWidth.w,
//                                         child: ElevatedButton(
//                                           onPressed: bloc.isAllDay
//                                               ? null
//                                               : () async {
//                                                   final time =
//                                                       await showTimePicker(
//                                                     context: context,
//                                                     initialTime:
//                                                         TimeOfDay.now(),
//                                                     builder: (context, child) {
//                                                       return Theme(
//                                                         data: Theme.of(context)
//                                                             .copyWith(
//                                                           colorScheme:
//                                                               ColorScheme.light(
//                                                             primary: AppColors
//                                                                 .primaryColor,
//                                                           ),
//                                                           textButtonTheme:
//                                                               TextButtonThemeData(
//                                                             style: TextButton
//                                                                 .styleFrom(
//                                                               foregroundColor:
//                                                                   AppColors
//                                                                       .primaryColor,
//                                                             ),
//                                                           ),
//                                                         ),
//                                                         child: child!,
//                                                       );
//                                                     },
//                                                   );
//                                                   if (time != null) {
//                                                     final formattedTime =
//                                                         time.format(context);
//                                                     bloc.add(SetTimeRangeEvent(
//                                                       startTime: bloc.startTime,
//                                                       endTime: formattedTime,
//                                                     ));
//                                                   }
//                                                 },
//                                           style: ElevatedButton.styleFrom(
//                                             padding: EdgeInsets.symmetric(
//                                               horizontal:
//                                                   AppDimensions.smallPadding.w,
//                                             ),
//                                             backgroundColor:
//                                                 AppColors.primaryHoverColor,
//                                             shape: RoundedRectangleBorder(
//                                               borderRadius:
//                                                   BorderRadius.circular(
//                                                       AppDimensions
//                                                           .smallBorderRadius.r),
//                                             ),
//                                             elevation:
//                                                 AppDimensions.smallBlurRdius,
//                                           ),
//                                           child: Text(
//                                             bloc.endTime == ''
//                                                 ? 'End time'
//                                                 : bloc.endTime,
//                                             style: AppFonts.poppinsLight(),
//                                           ),
//                                         ),
//                                       );
//                                     },
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                           SizedBox(height: AppDimensions.veryLargePadding.sp),
//                           Container(
//                             decoration: BoxDecoration(
//                               color: AppColors.textFormFillColor,
//                               borderRadius: BorderRadius.circular(
//                                   AppDimensions.smallBorderRadius.r),
//                               boxShadow: [
//                                 BoxShadow(
//                                   color: Colors.black.withValues(
//                                     red: 0,
//                                     green: 0,
//                                     blue: 0,
//                                     alpha: 0.2,
//                                   ),
//                                   offset: const Offset(0, 4),
//                                   blurRadius: AppDimensions.smallBlurRdius,
//                                 ),
//                               ],
//                             ),
//                             child: TextField(
//                               controller: noteController,
//                               maxLines: 10,
//                               decoration: InputDecoration(
//                                 hintText: 'WRITE A NOTE',
//                                 hintStyle: const TextStyle(
//                                   fontFamily: AppFonts.poppinsFontFamily,
//                                   color: AppColors.blackTextColor,
//                                   fontWeight: AppFonts.semiBold,
//                                 ),
//                                 filled: true,
//                                 fillColor: AppColors.textFormFillColor,
//                                 border: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(
//                                       AppDimensions.smallBorderRadius.r),
//                                   borderSide: BorderSide.none,
//                                 ),
//                                 enabledBorder: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(
//                                       AppDimensions.smallBorderRadius.r),
//                                   borderSide: BorderSide.none,
//                                 ),
//                                 focusedBorder: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(
//                                       AppDimensions.smallBorderRadius.r),
//                                   borderSide: BorderSide.none,
//                                 ),
//                               ),
//                               onChanged: (value) {
//                                 bloc.add(AddNotesEvent(value));
//                               },
//                             ),
//                           ),
//                           SizedBox(height: AppDimensions.largePadding.h),
//                           BlocBuilder<NetworkBloc, NetworkState>(
//                             builder: (context, networkState) {
//                               return ElevatedButton(
//                                 onPressed: () {
//                                   bloc.add(FetchRequestsEvent());
//                                 },
//                                 style: ElevatedButton.styleFrom(
//                                   backgroundColor: AppColors.primaryHoverColor,
//                                   shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(
//                                         AppDimensions.smallBorderRadius.r),
//                                   ),
//                                   elevation: AppDimensions.smallBlurRdius,
//                                 ),
//                                 child: Row(
//                                   mainAxisSize: MainAxisSize.min,
//                                   children: [
//                                     Icon(
//                                       Icons.history,
//                                       color: AppColors.lightTextColor,
//                                     ),
//                                     SizedBox(
//                                         width: AppDimensions.smallPadding.w),
//                                     Text(
//                                       'Fetch previous Time-blocks',
//                                       style: TextStyle(
//                                         fontFamily: AppFonts.poppinsFontFamily,
//                                         fontSize: AppFonts.smallFontSize.sp,
//                                         color: AppColors.lightTextColor,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               );
//                             },
//                           ),
//                           if (state is TimeBlockRequestsLoaded)
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 SizedBox(height: AppDimensions.mediumPadding.h),
//                                 Text(
//                                   'Previous Requests',
//                                   style: TextStyle(
//                                     fontFamily: AppFonts.poppinsFontFamily,
//                                     fontWeight: AppFonts.semiBold,
//                                     fontSize: AppFonts.largeFontSize.sp,
//                                   ),
//                                 ),
//                                 ...state.requests.map((request) => ListTile(
//                                       title: Text(request.note),
//                                       subtitle: Text(
//                                           'Dates: ${request.selectedDates.map((date) => DateFormat.yMMMd().format(date)).join(', ')}'),
//                                     )),
//                               ],
//                             ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   // Positioned the Send Button at the bottom of the screen
//                   Positioned(
//                     bottom: AppDimensions.smallHeight.h,
//                     left: 0,
//                     right: 0,
//                     child: Center(
//                       child: BlocBuilder<NetworkBloc, NetworkState>(
//                         builder: (context, networkState) {
//                           final isConnected =
//                               networkState is NetworkConnectedState;
//                           return ElevatedButton(
//                             onPressed: (state is! TimeBlockRequestSubmitting &&
//                                     isConnected)
//                                 ? () {
//                                     if (bloc.selectedDates.isEmpty) {
//                                       ScaffoldMessenger.of(context)
//                                           .showSnackBar(
//                                         const SnackBar(
//                                             content: Text(
//                                                 'Please select the time block dates.')),
//                                       );
//                                       return;
//                                     }

//                                     if (!bloc.isAllDay &&
//                                         (bloc.startTime.isEmpty ||
//                                             bloc.endTime.isEmpty)) {
//                                       ScaffoldMessenger.of(context)
//                                           .showSnackBar(
//                                         const SnackBar(
//                                             content: Text(
//                                                 'Please select the start and end time.')),
//                                       );
//                                       return;
//                                     }

//                                     bloc.add(SubmitRequestEvent());
//                                   }
//                                 : null,
//                             style: ElevatedButton.styleFrom(
//                               padding: EdgeInsets.symmetric(
//                                 horizontal: AppDimensions.largePadding.w,
//                                 vertical: AppDimensions.smallPadding.h,
//                               ),
//                               backgroundColor: AppColors.primaryColor,
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(
//                                     AppDimensions.smallBorderRadius.r),
//                               ),
//                               elevation: AppDimensions.smallBlurRdius,
//                             ),
//                             child: state is TimeBlockRequestSubmitting
//                                 ? const CircularProgressIndicator(
//                                     color: Colors.white,
//                                   )
//                                 : Text(
//                                     'Send The Request',
//                                     style: TextStyle(
//                                       fontFamily: AppFonts.poppinsFontFamily,
//                                       fontSize: AppFonts.mainButtonFontSize.sp,
//                                       color: Colors.white,
//                                     ),
//                                   ),
//                           );
//                           // ElevatedButton(
//                           //   onPressed: (state is! TimeBlockRequestSubmitting &&
//                           //           isConnected)
//                           //       ? () {
//                           //           bloc.add(SubmitRequestEvent());
//                           //         }
//                           //       : null,
//                           //   style: ElevatedButton.styleFrom(
//                           //     padding: EdgeInsets.symmetric(
//                           //       horizontal: AppDimensions.largePadding.w,
//                           //       vertical: AppDimensions.smallPadding.h,
//                           //     ),
//                           //     backgroundColor: AppColors.primaryColor,
//                           //     shape: RoundedRectangleBorder(
//                           //       borderRadius: BorderRadius.circular(
//                           //           AppDimensions.smallBorderRadius.r),
//                           //     ),
//                           //     elevation: AppDimensions.smallBlurRdius,
//                           //   ),
//                           //   child: state is TimeBlockRequestSubmitting
//                           //       ? const CircularProgressIndicator(
//                           //           color: Colors.white,
//                           //         )
//                           //       : Text(
//                           //           'Send The Request',
//                           //           style: TextStyle(
//                           //             fontFamily: AppFonts.poppinsFontFamily,
//                           //             fontSize: AppFonts.mainButtonFontSize.sp,
//                           //             color: Colors.white,
//                           //           ),
//                           //         ),
//                           // );
//                         },
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             );
//           },
//         ),
//       ),
//     ));
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
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
import '../widgets/pop_up_dialog.dart';
import '../widgets/submit_button_widget.dart';
import '../widgets/time_picker_widget.dart';

class TimeBlockRequestScreen extends StatelessWidget {
  TimeBlockRequestScreen({super.key});

  final TextEditingController noteController = TextEditingController();
  final DateFormat timeFormat = DateFormat.jm();

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
                              Text(
                                'Selected Dates: ${(state is DatesSelectedState ? (state).selectedDates : (state as AllDayToggledState).selectedDates).map((date) => DateFormat.yMMMd().format(date)).join(' - ')}',
                                style: TextStyle(
                                  fontFamily: AppFonts.poppinsFontFamily,
                                  fontSize: 11.sp,
                                ),
                              ),
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
                            ElevatedButton(
                              onPressed: () {
                                // Dispatch the FetchRequestsEvent to fetch time blocks
                                context
                                    .read<TimeBlockRequestBloc>()
                                    .add(FetchRequestsEvent(
                                      userId:
                                          'user123', // Replace with actual user ID
                                      organizationId:
                                          'org123', // Replace with actual organization ID
                                    ));

                                // Show the dialog to display the results
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return BlocBuilder<TimeBlockRequestBloc,
                                        TimeBlockRequestState>(
                                      builder: (context, state) {
                                        return TimeBlockRequestsDialog(
                                            state: state);
                                      },
                                    );
                                  },
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.secondaryColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                    AppDimensions.smallBorderRadius.r,
                                  ),
                                ),
                                elevation: AppDimensions.smallBlurRdius,
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.history,
                                    color: AppColors.tritiaryColor,
                                  ),
                                  SizedBox(width: AppDimensions.smallPadding.w),
                                  Text(
                                    'Fetch previous Time-blocks',
                                    style: TextStyle(
                                      fontFamily: AppFonts.poppinsFontFamily,
                                      fontSize: 11.sp,
                                      color: AppColors.tritiaryColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
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
