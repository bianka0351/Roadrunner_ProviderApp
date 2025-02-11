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
import 'package:flutter/material.dart';

import '../../../core/constants/app_enums.dart';
import '../../bloc/time_block_request_state.dart';

class TimeBlockRequestsDialog extends StatelessWidget {
  final TimeBlockRequestState state;

  const TimeBlockRequestsDialog({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Your Time Block Requests'),
      content: SizedBox(
        width: double.maxFinite,
        child: _buildContent(context),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Close'),
        ),
      ],
    );
  }

  Widget _buildContent(BuildContext context) {
    if (state is TimeBlockRequestLoading) {
      return const Center(child: CircularProgressIndicator());
    } else if (state is TimeBlockRequestEmpty) {
      return const Center(child: Text('Still no time-block requests'));
    } else if (state is TimeBlockRequestsLoaded) {
      final requests = (state as TimeBlockRequestsLoaded).requests;
      return ListView.builder(
        shrinkWrap: true,
        itemCount: requests.length,
        itemBuilder: (context, index) {
          final request = requests[index];
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    request.note ?? 'No note',
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    request.date.toString().split(' ')[0], // Display date without time
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      request.status.toString().split('.').last,
                      style: TextStyle(
                        fontSize: 14,
                        color: request.status == TimeBlockStatus.approved ? Colors.green : Colors.red,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    } else if (state is TimeBlockRequestFailure) {
      return Center(child: Text('Error: ${(state as TimeBlockRequestFailure).errorMessage}'));
    } else {
      return const Center(child: Text('Unexpected state'));
    }
  }
}