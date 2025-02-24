import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roadrunner_provider_app/core/constants/app_colors.dart';
import 'package:roadrunner_provider_app/core/constants/app_dimensions.dart';
import 'package:roadrunner_provider_app/core/constants/app_fonts.dart';
import '../../../../core/network/bloc/network_bloc.dart';
import '../../../../core/network/bloc/network_state.dart';
import '../../bloc/time_block_request_bloc.dart';
import '../../bloc/time_block_request_event.dart';
import '../../bloc/time_block_request_state.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'confirmation_dialog.dart';

class SubmitButtonWidget extends StatelessWidget {
  const SubmitButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<TimeBlockRequestBloc>();

    return BlocBuilder<TimeBlockRequestBloc, TimeBlockRequestState>(
      builder: (context, state) {
        return BlocBuilder<NetworkBloc, NetworkState>(
          builder: (context, networkState) {
            final isConnected = networkState is NetworkConnectedState;

            return ElevatedButton(
              onPressed: (state is! TimeBlockRequestSubmitting && isConnected)
    ? () async {
        // Validate selected dates
        if (bloc.selectedDates.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text('Please select the time block dates.')),
          );
          return;
        }

        // Validate start and end time if not an all-day event
        if (!bloc.isAllDay &&
            (bloc.startTime.isEmpty || bloc.endTime.isEmpty)) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text('Please select the start and end time.')),
          );
          return;
        }

        // Show custom confirmation dialog
        final confirmed = await showDialog<bool>(
          context: context,
          builder: (context) => CustomConfirmationDialog(
            onNoPressed: () => Navigator.of(context).pop(false),
            onYesPressed: () => Navigator.of(context).pop(true),
          ),
        );

        // If user confirmed, submit the request
        if (confirmed == true) {
          bloc.add(SubmitRequestEvent());
        }
      }
    : null,
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(
                  horizontal: AppDimensions.largePadding.w,
                  vertical: AppDimensions.smallPadding.h,
                ),
                backgroundColor: AppColors.primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(AppDimensions.smallBorderRadius.r),
                ),
                elevation: AppDimensions.smallBlurRdius,
              ),
              child: state is TimeBlockRequestSubmitting
                  ? const CircularProgressIndicator(
                      color: Colors.white,
                    )
                  : Text(
                      'Send The Request',
                      style: TextStyle(
                        fontFamily: AppFonts.poppinsFontFamily,
                        fontSize: 18.sp,
                        color: Colors.white,
                      ),
                    ),
            );
          },
        );
      },
    );
  }
}