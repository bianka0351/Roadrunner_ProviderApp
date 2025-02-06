// // // import 'package:flutter/material.dart';
// // // import 'package:intl/intl.dart';

// // // class TimeBlockRequestPage extends StatefulWidget {
// // //   const TimeBlockRequestPage({super.key});

// // //   @override
// // //   _TimeBlockRequestPageState createState() => _TimeBlockRequestPageState();
// // // }

// // // class _TimeBlockRequestPageState extends State<TimeBlockRequestPage> {
// // //   final _noteController = TextEditingController();
// // //   List<DateTime> selectedDates = [DateTime.now()];
// // //   bool isAllDay = false;
// // //   TimeOfDay? startTime;
// // //   TimeOfDay? endTime;

// // //   DateTime currentMonth = DateTime.now();
// // //   DateTime currentWeekStart = DateTime.now();

// // //   @override
// // //   void dispose() {
// // //     _noteController.dispose();
// // //     super.dispose();
// // //   }

// // //   void _navigateMonth(bool isNext) {
// // //     setState(() {
// // //       currentMonth = DateTime(
// // //         currentMonth.year,
// // //         currentMonth.month + (isNext ? 1 : -1),
// // //       );

// // //       if (currentMonth.isBefore(DateTime.now())) {
// // //         currentMonth = DateTime.now();
// // //       }
// // //     });
// // //   }

// // //   void _navigateWeek(bool isNext) {
// // //     setState(() {
// // //       currentWeekStart = currentWeekStart.add(
// // //         Duration(days: isNext ? 7 : -7),
// // //       );

// // //       if (currentWeekStart.isBefore(DateTime.now())) {
// // //         currentWeekStart = DateTime.now();
// // //       }
// // //     });
// // //   }

// // //   Future<void> _pickTime(BuildContext context, bool isStart) async {
// // //     final time = await showTimePicker(
// // //       context: context,
// // //       initialTime: TimeOfDay.now(),
// // //     );
// // //     if (time != null) {
// // //       setState(() {
// // //         if (isStart) {
// // //           startTime = time;
// // //         } else {
// // //           endTime = time;
// // //         }
// // //       });
// // //     }
// // //   }

// // //   void _sendRequest(BuildContext context) {
// // //     if (isAllDay || (startTime != null && endTime != null)) {
// // //       final note = _noteController.text;
// // //       print('Request sent: Dates: $selectedDates, Note: $note');
// // //     } else {
// // //       ScaffoldMessenger.of(context).showSnackBar(
// // //         const SnackBar(
// // //           content: Text('Please select valid start and end times.'),
// // //         ),
// // //       );
// // //     }
// // //   }

// // //   List<DateTime> _getWeekDates(DateTime start) {
// // //     return List.generate(
// // //       7,
// // //       (index) => start.add(Duration(days: index)),
// // //     );
// // //   }

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     final weekDates = _getWeekDates(currentWeekStart);
// // //     final screenWidth = MediaQuery.of(context).size.width;

// // //     return Scaffold(
// // //       appBar: AppBar(
// // //         title: const Text('Time Block Request'),
// // //         centerTitle: true,
// // //       ),
// // //       body: Padding(
// // //         padding: const EdgeInsets.all(16.0),
// // //         child: Column(
// // //           crossAxisAlignment: CrossAxisAlignment.start,
// // //           children: [
// // //             // Month and Year Navigation
// // //             Row(
// // //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // //               children: [
// // //                 IconButton(
// // //                   onPressed: () => _navigateMonth(false),
// // //                   icon: const Icon(Icons.arrow_left),
// // //                 ),
// // //                 Text(
// // //                   DateFormat('MMMM yyyy').format(currentMonth),
// // //                   style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
// // //                 ),
// // //                 IconButton(
// // //                   onPressed: () => _navigateMonth(true),
// // //                   icon: const Icon(Icons.arrow_right),
// // //                 ),
// // //               ],
// // //             ),
// // //             const SizedBox(height: 16),

// // //             // Weekday Navigation
// // //             Row(
// // //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // //               children: [
// // //                 IconButton(
// // //                   onPressed: () => _navigateWeek(false),
// // //                   icon: const Icon(Icons.arrow_left),
// // //                 ),
// // //                 Expanded(
// // //                   child: Row(
// // //                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// // //                     children: weekDates.map((date) {
// // //                       final isSelected = selectedDates.contains(date);
// // //                       return GestureDetector(
// // //                         onTap: () {
// // //                           setState(() {
// // //                             selectedDates = [date];
// // //                           });
// // //                         },
// // //                         child: Container(
// // //                           width: 40,
// // //                           height: 60,
// // //                           decoration: BoxDecoration(
// // //                             color: isSelected ? Colors.blue : Colors.grey.shade200,
// // //                             borderRadius: BorderRadius.circular(8),
// // //                           ),
// // //                           child: Column(
// // //                             mainAxisAlignment: MainAxisAlignment.center,
// // //                             children: [
// // //                               Text(
// // //                                 DateFormat.E().format(date),
// // //                                 style: TextStyle(
// // //                                   color: isSelected ? Colors.white : Colors.black,
// // //                                   fontWeight: FontWeight.bold,
// // //                                 ),
// // //                               ),
// // //                               const SizedBox(height: 4),
// // //                               Text(
// // //                                 '${date.day}',
// // //                                 style: TextStyle(
// // //                                   color: isSelected ? Colors.white : Colors.black,
// // //                                 ),
// // //                               ),
// // //                             ],
// // //                           ),
// // //                         ),
// // //                       );
// // //                     }).toList(),
// // //                   ),
// // //                 ),
// // //                 IconButton(
// // //                   onPressed: () => _navigateWeek(true),
// // //                   icon: const Icon(Icons.arrow_right),
// // //                 ),
// // //               ],
// // //             ),
// // //             const SizedBox(height: 16),

// // //             Row(
// // //               children: [
// // //                 Checkbox(
// // //                   value: isAllDay,
// // //                   onChanged: (value) {
// // //                     setState(() {
// // //                       isAllDay = value!;
// // //                       startTime = null;
// // //                       endTime = null;
// // //                     });
// // //                   },
// // //                 ),
// // //                 const Text('All day', style: TextStyle(fontSize: 16)),
// // //               ],
// // //             ),

// // //             if (!isAllDay) ...[
// // //               const Text(
// // //                 'Select time range',
// // //                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
// // //               ),
// // //               const SizedBox(height: 8),
// // //               Row(
// // //                 children: [
// // //                   GestureDetector(
// // //                     onTap: () => _pickTime(context, true),
// // //                     child: Container(
// // //                       width: screenWidth * 0.4,
// // //                       height: 50,
// // //                       decoration: BoxDecoration(
// // //                         color: Colors.grey.shade200,
// // //                         borderRadius: BorderRadius.circular(8),
// // //                       ),
// // //                       alignment: Alignment.center,
// // //                       child: Text(
// // //                         startTime == null ? 'Start Time' : startTime!.format(context),
// // //                         style: const TextStyle(fontSize: 16),
// // //                       ),
// // //                     ),
// // //                   ),
// // //                   const SizedBox(width: 16),
// // //                   GestureDetector(
// // //                     onTap: () => _pickTime(context, false),
// // //                     child: Container(
// // //                       width: screenWidth * 0.4,
// // //                       height: 50,
// // //                       decoration: BoxDecoration(
// // //                         color: Colors.grey.shade200,
// // //                         borderRadius: BorderRadius.circular(8),
// // //                       ),
// // //                       alignment: Alignment.center,
// // //                       child: Text(
// // //                         endTime == null ? 'End Time' : endTime!.format(context),
// // //                         style: const TextStyle(fontSize: 16),
// // //                       ),
// // //                     ),
// // //                   ),
// // //                 ],
// // //               ),
// // //             ],
// // //             const SizedBox(height: 16),

// // //             const Text(
// // //               'Write a note',
// // //               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
// // //             ),
// // //             const SizedBox(height: 8),
// // //             TextField(
// // //               controller: _noteController,
// // //               maxLines: 3,
// // //               decoration: InputDecoration(
// // //                 hintText: 'Write your note here...',
// // //                 border: OutlineInputBorder(
// // //                   borderRadius: BorderRadius.circular(8),
// // //                 ),
// // //               ),
// // //             ),
// // //             const Spacer(),

// // //             SizedBox(
// // //               width: double.infinity,
// // //               height: 50,
// // //               child: ElevatedButton(
// // //                 onPressed: () => _sendRequest(context),
// // //                 child: const Text(
// // //                   'Send The Request',
// // //                   style: TextStyle(fontSize: 16),
// // //                 ),
// // //               ),
// // //             ),
// // //           ],
// // //         ),
// // //       ),
// // //     );
// // //   }
// // // }

// // import 'package:flutter/material.dart';
// // import 'package:flutter_bloc/flutter_bloc.dart';
// // import 'package:intl/intl.dart';

// // import '../../bloc/time_block_request_bloc.dart';

// // class TimeBlockRequestScreen extends StatelessWidget {
// //   TimeBlockRequestScreen({super.key});

// //   final TextEditingController noteController = TextEditingController();
// //   final DateFormat timeFormat = DateFormat.jm();

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: const Text('Time Block Request'),
// //         centerTitle: true,
// //       ),
// //       body: BlocConsumer<TimeBlockRequestBloc, TimeBlockRequestState>(
// //         listener: (context, state) {
// //           if (state is TimeBlockRequestSuccess) {
// //             ScaffoldMessenger.of(context).showSnackBar(
// //               const SnackBar(content: Text('Request submitted successfully!')),
// //             );
// //           } else if (state is TimeBlockRequestFailure) {
// //             ScaffoldMessenger.of(context).showSnackBar(
// //               SnackBar(content: Text('Error: ${state.errorMessage}')),
// //             );
// //           }
// //         },
// //         builder: (context, state) {
// //           final bloc = context.read<TimeBlockRequestBloc>();

// //           return SingleChildScrollView(
// //             padding: const EdgeInsets.all(16.0),
// //             child: Column(
// //               crossAxisAlignment: CrossAxisAlignment.start,
// //               children: [
// //                 // Select Dates
// //                 const Text(
// //                   'Pick Dates',
// //                   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
// //                 ),
// //                 const SizedBox(height: 8),
// //                 ElevatedButton(
// //                   onPressed: () async {
// //                     final selectedDates = await showDateRangePicker(
// //                       context: context,
// //                       firstDate: DateTime.now(),
// //                       lastDate: DateTime.now().add(const Duration(days: 365)),
// //                     );
// //                     if (selectedDates != null) {
// //                       bloc.add(SelectDatesEvent([
// //                         selectedDates.start,
// //                         selectedDates.end,
// //                       ]));
// //                     }
// //                   },
// //                   child: const Text('Pick Dates'),
// //                 ),
// //                 if (state is DatesSelectedState)
// //                   Text(
// //                     'Selected: ${state.selectedDates.map((date) => DateFormat.yMMMd().format(date)).join(' - ')}',
// //                     style: const TextStyle(fontSize: 14),
// //                   ),
// //                 const SizedBox(height: 16),

// //                 // Toggle All Day
// //                 Row(
// //                   children: [
// //                     Checkbox(
// //                       value: bloc.isAllDay,
// //                       onChanged: (value) {
// //                         bloc.add(ToggleAllDayEvent(value ?? false));
// //                       },
// //                     ),
// //                     const Text(
// //                       'All Day',
// //                       style:
// //                           TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
// //                     ),
// //                     SizedBox(width: 20),
// //                     Row(
// //                       children: [
// //                         SizedBox(
// //                           width: 110,
// //                           child: ElevatedButton(
// //                             onPressed: bloc.isAllDay
// //                                 ? null
// //                                 : () async {
// //                                     final time = await showTimePicker(
// //                                       context: context,
// //                                       initialTime: TimeOfDay.now(),
// //                                     );
// //                                     if (time != null) {
// //                                       final formattedTime =
// //                                           // ignore: use_build_context_synchronously
// //                                           time.format(context);
// //                                       bloc.add(SetTimeRangeEvent(
// //                                         startTime: formattedTime,
// //                                         endTime: bloc.endTime,
// //                                       ));
// //                                     }
// //                                   },
// //                             child: Text(
// //                               bloc.startTime == '' ? 'Start' : bloc.startTime,
// //                               style: const TextStyle(fontSize: 14),
// //                             ),
// //                           ),
// //                         ),
// //                         Padding(
// //                           padding: const EdgeInsets.symmetric(horizontal: 8),
// //                           child: const SizedBox(
// //                             width: 8,
// //                             child: Text(
// //                               '-',
// //                               style: TextStyle(
// //                                   fontSize: 20, fontWeight: FontWeight.bold),
// //                             ),
// //                           ),
// //                         ),
// //                         SizedBox(
// //                           width: 110, // Adjust the width as needed
// //                           child: ElevatedButton(
// //                             onPressed: bloc.isAllDay
// //                                 ? null
// //                                 : () async {
// //                                     final time = await showTimePicker(
// //                                       context: context,
// //                                       initialTime: TimeOfDay.now(),
// //                                     );
// //                                     if (time != null) {
// //                                       final formattedTime =
// //                                           // ignore: use_build_context_synchronously
// //                                           time.format(context);
// //                                       bloc.add(SetTimeRangeEvent(
// //                                         startTime: bloc.startTime,
// //                                         endTime: formattedTime,
// //                                       ));
// //                                     }
// //                                   },
// //                             child: Text(
// //                               bloc.endTime == '' ? 'End' : bloc.endTime,
// //                               style: const TextStyle(fontSize: 14),
// //                             ),
// //                           ),
// //                         ),
// //                       ],
// //                     ),
// //                   ],
// //                 ),

// //                 const SizedBox(height: 16),

// //                 // Add Notes
// //                 const Text(
// //                   'Notes',
// //                   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
// //                 ),
// //                 const SizedBox(height: 8),
// //                 TextField(
// //                   controller: noteController,
// //                   maxLines: 3,
// //                   decoration: const InputDecoration(
// //                     hintText: 'Add any additional notes',
// //                     border: OutlineInputBorder(),
// //                   ),
// //                   onChanged: (value) {
// //                     bloc.add(AddNotesEvent(value));
// //                   },
// //                 ),
// //                 const SizedBox(height: 16),

// //                 // Submit Button
// //                 Center(
// //                   child: ElevatedButton(
// //                     onPressed: state is! TimeBlockRequestSubmitting
// //                         ? () {
// //                             bloc.add(SubmitRequestEvent());
// //                           }
// //                         : null,
// //                     child: state is TimeBlockRequestSubmitting
// //                         ? const CircularProgressIndicator(color: Colors.white)
// //                         : const Text('Send The Request'),
// //                   ),
// //                 ),

// //                 const SizedBox(height: 16),

// //                 // Fetch Previous Requests
// //                 Center(
// //                   child: ElevatedButton(
// //                     onPressed: () {
// //                       bloc.add(FetchRequestsEvent());
// //                     },
// //                     child: const Text('Fetch Previous Requests'),
// //                   ),
// //                 ),

// //                 // Display Requests
// //                 if (state is TimeBlockRequestsLoaded)
// //                   Column(
// //                     crossAxisAlignment: CrossAxisAlignment.start,
// //                     children: [
// //                       const SizedBox(height: 16),
// //                       const Text(
// //                         'Previous Requests',
// //                         style: TextStyle(
// //                             fontWeight: FontWeight.bold, fontSize: 16),
// //                       ),
// //                       ...state.requests.map((request) => ListTile(
// //                             title: Text(request.note),
// //                             subtitle: Text(
// //                                 'Dates: ${request.selectedDates.map((date) => DateFormat.yMMMd().format(date)).join(', ')}'),
// //                           )),
// //                     ],
// //                   ),
// //               ],
// //             ),
// //           );
// //         },
// //       ),
// //     );
// //   }
// // }

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:intl/intl.dart';

// import '../../bloc/time_block_request_bloc.dart';

// class TimeBlockRequestScreen extends StatelessWidget {
//   TimeBlockRequestScreen({Key? key}) : super(key: key);

//   final TextEditingController noteController = TextEditingController();
//   final DateFormat timeFormat = DateFormat.jm();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Time Block Request'),
//         centerTitle: true,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back),
//           onPressed: () {
//             Navigator.pop(context); // Back action
//           },
//         ),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.menu), // Menu icon
//             onPressed: () {
//               // Add your menu action here
//             },
//           ),
//         ],
//       ),
//       body: BlocConsumer<TimeBlockRequestBloc, TimeBlockRequestState>(
//         listener: (context, state) {
//           if (state is TimeBlockRequestSuccess) {
//             ScaffoldMessenger.of(context).showSnackBar(
//               const SnackBar(content: Text('Request submitted successfully!')),
//             );
//           } else if (state is TimeBlockRequestFailure) {
//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(content: Text('Error: ${state.errorMessage}')),
//             );
//           }
//         },
//         builder: (context, state) {
//           final bloc = context.read<TimeBlockRequestBloc>();

//           return SingleChildScrollView(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 SizedBox(
//                   height: 30,
//                 ),
//                 // Select Dates
//                 const Text(
//                   'Pick Dates',
//                   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
//                 ),
//                 const SizedBox(height: 8),
//                 ElevatedButton(
//                   onPressed: () async {
//                     final selectedDates = await showDateRangePicker(
//                       context: context,
//                       firstDate: DateTime.now(),
//                       lastDate: DateTime.now().add(const Duration(days: 365)),
//                     );
//                     if (selectedDates != null) {
//                       bloc.add(SelectDatesEvent([
//                         selectedDates.start,
//                         selectedDates.end,
//                       ]));
//                     }
//                   },
//                   child: Row(
//                     mainAxisSize: MainAxisSize.min,
//                     children: const [
//                       Icon(Icons.calendar_today), // Calendar icon
//                       SizedBox(width: 8), // Spacer between icon and text
//                       Text('Time-Block Dates'),
//                     ],
//                   ),
//                 ),
//                 if (state is DatesSelectedState)
//                   Text(
//                     ' ${state.selectedDates.map((date) => DateFormat.yMMMd().format(date)).join(', ')}',
//                     style: const TextStyle(fontSize: 15),
//                   ),
//                 const SizedBox(height: 16),

//                 // Toggle All Day
//                 Row(
//                   children: [
//                     Checkbox(
//                       value: bloc.isAllDay,
//                       onChanged: (value) {
//                         bloc.add(ToggleAllDayEvent(value ?? false));
//                       },
//                     ),
//                     const Text(
//                       'All Day',
//                       style:
//                           TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
//                     ),
//                     SizedBox(width: 20),
//                     Row(
//                       children: [
//                         SizedBox(
//                           width: 110,
//                           child: ElevatedButton(
//                             onPressed: bloc.isAllDay
//                                 ? null
//                                 : () async {
//                                     final time = await showTimePicker(
//                                       context: context,
//                                       initialTime: TimeOfDay.now(),
//                                     );
//                                     if (time != null) {
//                                       final formattedTime =
//                                           time.format(context);
//                                       bloc.add(SetTimeRangeEvent(
//                                         startTime: formattedTime,
//                                         endTime: bloc.endTime,
//                                       ));
//                                     }
//                                   },
//                             child: Text(
//                               bloc.startTime == ''
//                                   ? 'Start'
//                                   : '${bloc.startTime}',
//                               style: const TextStyle(fontSize: 14),
//                             ),
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 8),
//                           child: const SizedBox(
//                             width: 8,
//                             child: Text(
//                               '-',
//                               style: TextStyle(
//                                   fontSize: 20, fontWeight: FontWeight.bold),
//                             ),
//                           ),
//                         ),
//                         SizedBox(
//                           width: 110, // Adjust the width as needed
//                           child: ElevatedButton(
//                             onPressed: bloc.isAllDay
//                                 ? null
//                                 : () async {
//                                     final time = await showTimePicker(
//                                       context: context,
//                                       initialTime: TimeOfDay.now(),
//                                     );
//                                     if (time != null) {
//                                       final formattedTime =
//                                           time.format(context);
//                                       bloc.add(SetTimeRangeEvent(
//                                         startTime: bloc.startTime,
//                                         endTime: formattedTime,
//                                       ));
//                                     }
//                                   },
//                             child: Text(
//                               bloc.endTime == '' ? 'End' : '${bloc.endTime}',
//                               style: const TextStyle(fontSize: 14),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),

//                 const SizedBox(height: 16),

//                 // Add Notes
//                 const Text(
//                   'Notes',
//                   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
//                 ),
//                 const SizedBox(height: 8),
//                 TextField(
//                   controller: noteController,
//                   maxLines: 3,
//                   decoration: const InputDecoration(
//                     hintText: 'Add any additional notes',
//                     border: OutlineInputBorder(),
//                   ),
//                   onChanged: (value) {
//                     bloc.add(AddNotesEvent(value));
//                   },
//                 ),
//                 const SizedBox(height: 16),

//                 // Fetch Previous Requests
//                 ElevatedButton(
//                   onPressed: () {
//                     bloc.add(FetchRequestsEvent());
//                   },
//                   child: Row(
//                     mainAxisSize: MainAxisSize.min,
//                     children: const [
//                       Icon(Icons.history), // History icon
//                       SizedBox(width: 8), // Spacer between icon and text
//                       Text('Fetch Previous Requests'),
//                     ],
//                   ),
//                 ),

//               // Display Requests
//                 if (state is TimeBlockRequestsLoaded)
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       const SizedBox(height: 16),
//                       const Text(
//                         'Previous Requests',
//                         style: TextStyle(
//                             fontWeight: FontWeight.bold, fontSize: 16),
//                       ),
//                       ...state.requests.map((request) => ListTile(
//                             title: Text(request.note),
//                             subtitle: Text(
//                                 'Dates: ${request.selectedDates.map((date) => DateFormat.yMMMd().format(date)).join(', ')}'),
//                           )),
//                     ],
//                   ),

//                 // Submit Button
//                 Center(
//                   child: ElevatedButton(
//                     onPressed: state is! TimeBlockRequestSubmitting
//                         ? () {
//                             bloc.add(SubmitRequestEvent());
//                           }
//                         : null,
//                     child: state is TimeBlockRequestSubmitting
//                         ? const CircularProgressIndicator(color: Colors.white)
//                         : const Text('Send The Request'),
//                   ),
//                 ),

//                 const SizedBox(height: 16),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

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
