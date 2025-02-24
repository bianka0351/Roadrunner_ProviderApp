// import '../../../core/constants/app_enums.dart';

// class PreviousTimeBlockRequestModel {
//   final String note;
//   final TimeBlockStatus status;
//   final DateTime date;

//   PreviousTimeBlockRequestModel({
//     required this.note,
//     required this.status,
//     required this.date,
//   });

//   factory PreviousTimeBlockRequestModel.fromJson(Map<String, dynamic> json) {
//     return PreviousTimeBlockRequestModel(
//       note: json['note'] as String,
//       status: TimeBlockStatus.values[json['status']],
//       date: DateTime.parse(json['date']),
//     );
//   }
// }

import '../../../../core/constants/app_enums.dart';

class PreviousTimeBlockRequestModel {
  final String? note;
  final TimeBlockStatus status;
  final DateTime date;

  PreviousTimeBlockRequestModel({
    this.note,
    required this.status,
    required this.date,
  });

  factory PreviousTimeBlockRequestModel.fromJson(Map<String, dynamic> json) {
    return PreviousTimeBlockRequestModel(
      note: json['note'] as String?,
      status: TimeBlockStatus.values[json['status']],
      date: DateTime.parse(json['date']),
    );
  }
}