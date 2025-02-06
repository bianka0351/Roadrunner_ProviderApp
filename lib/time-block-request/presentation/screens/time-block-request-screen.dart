import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:roadrunner_provider_app/core/app-dimensions.dart';
import 'package:roadrunner_provider_app/core/app-fonts.dart';
import '../../../core/app_colors.dart';
import '../../bloc/time_block_request_bloc.dart';

class TimeBlockRequestScreen extends StatelessWidget {
  TimeBlockRequestScreen({Key? key}) : super(key: key);

  final TextEditingController noteController = TextEditingController();
  final DateFormat timeFormat = DateFormat.jm();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Time Block Request',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.w800)),
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
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  padding: EdgeInsets.all(AppDimensions.largePadding),
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 30),
                      const Text(
                        'Pick dates',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
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
                          elevation: 5
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Icon(
                              Icons.calendar_today,
                              color: AppColors.lightTextColor,
                            ), // Calendar icon
                            SizedBox(width: 8), // Spacer between icon and text
                            Text('Time-Block Dates',
                                style:
                                    TextStyle(color: AppColors.lightTextColor)),
                          ],
                        ),
                      ),
                      if (state is DatesSelectedState)
                        Text(
                          ' ${state.selectedDates.map((date) => DateFormat.yMMMd().format(date)).join(', ')}',
                          style: const TextStyle(fontSize: 15),
                        ),
                      const SizedBox(height: 50),
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
                          const Text(
                            'All day',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          SizedBox(width: 20),
                          Row(
                            children: [
                              SizedBox(
                                width: 110,
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
                                    elevation: 5
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
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                child: const SizedBox(
                                  width: 8,
                                  child: Text(
                                    '-',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 110,
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
                                    elevation: 5
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
                      const SizedBox(height: 30),
                      // const Text(
                      //   'Notes',
                      //   style: TextStyle(
                      //       fontWeight: FontWeight.bold, fontSize: 16),
                      // ),
                      // const SizedBox(height: 8),
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
                                alpha: 0.1, // Opacity value
                              ),
                              offset: Offset(-1, 4), // Shadow offset
                              blurRadius: 5, // Shadow blur radius
                            ),
                          ],
                        ),
                        child: TextField(
                          controller: noteController,
                          maxLines: 6,
                          decoration: InputDecoration(
                            hintText: 'WRITE A NOTE',
                            hintStyle: const TextStyle(
                              color: AppColors
                                  .blackTextColor, // Change hint text color
                              fontWeight: FontWeight
                                  .w600, // Change hint text font weight
                            ),
                            filled: true,
                            fillColor: AppColors.textFormFillColor,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                  12.0), // Set border radius
                              borderSide:
                                  BorderSide.none, // Remove the border line
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                  12.0), // Set border radius for enabled state
                              borderSide: BorderSide
                                  .none, // Remove the border line for enabled state
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                  12.0), // Set border radius for focused state
                              borderSide: BorderSide
                                  .none, // Remove the border line for focused state
                            ),
                          ),
                          onChanged: (value) {
                            bloc.add(AddNotesEvent(value));
                          },
                        ),
                      ),
                      const SizedBox(height: 25),
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
                          elevation: 5
                        ),
                        
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Icon(Icons.history,
                                color: AppColors.lightTextColor),
                            SizedBox(width: 8),
                            Text('Fetch Previous Requests',
                                style: TextStyle(
                                    fontSize: 14,
                                    color: AppColors.lightTextColor)),
                          ],
                        ),
                      ),
                      if (state is TimeBlockRequestsLoaded)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 16),
                            const Text(
                              'Previous Requests',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
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
                bottom: 130,
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
                        horizontal: AppDimensions.mediumPadding * 3,
                        vertical: AppDimensions.smallPadding,
                      ),
                      backgroundColor: AppColors.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            AppDimensions.smallBorderRadius),
                      ),
                      elevation: 5, // This adds a shadow effect
                    ),
                    child: state is TimeBlockRequestSubmitting
                        ? const CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : const Text(
                            'Send The Request',
                            style: TextStyle(fontSize: 26, color: Colors.white),
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
