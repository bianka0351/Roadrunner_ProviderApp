
class TimeBlockRequestModel {
  final List<DateTime> selectedDates; // List of selected dates
  final bool isAllDay; // Whether the request is for the whole day
  final String startTime; // Start time in 'hh:mm AM/P M' format
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
