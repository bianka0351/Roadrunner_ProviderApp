import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../bloc/time_block_request_bloc.dart';

class TimeBlockRequestScreen extends StatelessWidget {
  TimeBlockRequestScreen({Key? key}) : super(key: key);

  final TextEditingController noteController = TextEditingController();
  final DateFormat timeFormat = DateFormat.jm();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Time Block Request'),
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
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 30),
                      const Text(
                        'Pick Dates',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      const SizedBox(height: 8),
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
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Icon(Icons.calendar_today), // Calendar icon
                            SizedBox(width: 8), // Spacer between icon and text
                            Text('Time-Block Dates'),
                          ],
                        ),
                      ),
                      if (state is DatesSelectedState)
                        Text(
                          ' ${state.selectedDates.map((date) => DateFormat.yMMMd().format(date)).join(', ')}',
                          style: const TextStyle(fontSize: 15),
                        ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Checkbox(
                            value: bloc.isAllDay,
                            onChanged: (value) {
                              bloc.add(ToggleAllDayEvent(value ?? false));
                            },
                          ),
                          const Text(
                            'All Day',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 14),
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
                                  child: Text(
                                    bloc.startTime == ''
                                        ? 'Start'
                                        : '${bloc.startTime}',
                                    style: const TextStyle(fontSize: 14),
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
                                  child: Text(
                                    bloc.endTime == ''
                                        ? 'End'
                                        : '${bloc.endTime}',
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Notes',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: noteController,
                        maxLines: 3,
                        decoration: const InputDecoration(
                          hintText: 'Add any additional notes',
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (value) {
                          bloc.add(AddNotesEvent(value));
                        },
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          bloc.add(FetchRequestsEvent());
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Icon(Icons.history), // History icon
                            SizedBox(width: 8),
                            Text('Fetch Previous Requests'),
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
                bottom: 40,
                left: 0,
                right: 0,
                child: Center(
                  child: ElevatedButton(
                    onPressed: state is! TimeBlockRequestSubmitting
                        ? () {
                            bloc.add(SubmitRequestEvent());
                          }
                        : null,
                    child: state is TimeBlockRequestSubmitting
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text('Send The Request',style: TextStyle(fontSize: 18),),
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
