// class TimeBlockRequestModel {
//   final List<DateTime> selectedDates; // Format: ['2023-01-01', '2023-01-02']
//   final bool isAllDay;
//   final String startTime; // Format: '12:00 AM'
//   final String endTime;   // Format: '05:00 PM'
//   final String note;

//   // Updated constructor to remove the redundant 'dates' parameter
//   TimeBlockRequestModel({
//     required this.selectedDates,
//     required this.isAllDay,
//     required this.startTime,
//     required this.endTime,
//     required this.note,
//   });

//   // Convert model to JSON for sending to the API
//   Map<String, dynamic> toJson() {
//     return {
//       'dates': selectedDates,
//       'isAllDay': isAllDay,
//       'startTime': startTime,
//       'endTime': endTime,
//       'note': note,
//     };
//   }

//   // Create model from JSON (useful for receiving API responses)
//   factory TimeBlockRequestModel.fromJson(Map<String, dynamic> json) {
//     return TimeBlockRequestModel(
//       selectedDates: List<DateTime>.from(json['dates']),
//       isAllDay: json['isAllDay'],
//       startTime: json['startTime'],
//       endTime: json['endTime'],
//       note: json['note'],
//     );
//   }
// }

class TimeBlockRequestModel {
  final List<DateTime> selectedDates; // List of selected dates
  final bool isAllDay; // Whether the request is for the whole day
  final String startTime; // Start time in 'hh:mm AM/PM' format
  final String endTime; // End time in 'hh:mm AM/PM' format
  final String note; // Optional note

  // Constructor
  TimeBlockRequestModel({
    required this.selectedDates,
    required this.isAllDay,
    required this.startTime,
    required this.endTime,
    required this.note,
  });

  // Convert model to JSON for sending to the API
  Map<String, dynamic> toJson() {
    return {
      'dates': selectedDates.map((date) => date.toIso8601String()).toList(),
      'isAllDay': isAllDay,
      'startTime': startTime,
      'endTime': endTime,
      'note': note,
    };
  }

  // Create model from JSON (useful for receiving API responses)
  factory TimeBlockRequestModel.fromJson(Map<String, dynamic> json) {
    return TimeBlockRequestModel(
      selectedDates: (json['dates'] as List<dynamic>)
          .map((date) => DateTime.parse(date))
          .toList(),
      isAllDay: json['isAllDay'],
      startTime: json['startTime'],
      endTime: json['endTime'],
      note: json['note'],
    );
  }
}
