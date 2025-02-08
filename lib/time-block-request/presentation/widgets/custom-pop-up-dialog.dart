// import 'package:flutter/material.dart';
// import '../../data/models/time-block-request-model.dart';

// class TimeBlockRequestsDialog extends StatelessWidget {
//   final List<TimeBlockRequestModel> requests;

//   const TimeBlockRequestsDialog({super.key, required this.requests});

//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       title: const Text('Your Time Block Requests'),
//       content: SizedBox(
//         width: double.maxFinite,
//         child: ListView.builder(
//           shrinkWrap: true,
//           itemCount: requests.length,
//           itemBuilder: (context, index) {
//             final request = requests[index];
//             return Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // Display note if it exists
//                 Text(
//                   request.note,
//                   style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                 ),
//                 Text(
//                   request.fullDate.toString().split(' ')[0], // Display date without time
//                   style: const TextStyle(fontSize: 14, color: Colors.grey),
//                 ),
//                 Align(
//                   alignment: Alignment.centerRight,
//                   child: Text(
//                     request.status,
//                     style: TextStyle(
//                       fontSize: 14,
//                       color: request.status == 'Approved' ? Colors.green : Colors.red,
//                     ),
//                   ),
//                 ),
//                 const Divider(), // Add a divider between requests
//               ],
//             );
//           },
//         ),
//       ),
//       actions: [
//         TextButton(
//           onPressed: () {
//             Navigator.of(context).pop();
//           },
//           child: const Text('Close'),
//         ),
//       ],
//     );
//   }
// }