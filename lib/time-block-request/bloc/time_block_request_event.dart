// import 'package:equatable/equatable.dart';
// import 'package:flutter/material.dart';
// import '../data/models/time-block-request-model.dart';

// // Abstract Event Class
// abstract class TimeBlockRequestEvent extends Equatable {
//   const TimeBlockRequestEvent();

//   @override
//   List<Object?> get props => [];
// }

// // Event for Selecting Dates
// class SelectDatesEvent extends TimeBlockRequestEvent {
//   final List<DateTime> selectedDates; // List of dates selected by the runner

//   const SelectDatesEvent(this.selectedDates);

//   @override
//   List<Object?> get props => [selectedDates];
// }

// // Event for Toggling All-Day Checkbox
// class ToggleAllDayEvent extends TimeBlockRequestEvent {
//   final bool isAllDay;

//   const ToggleAllDayEvent(this.isAllDay);

//   @override
//   List<Object?> get props => [isAllDay];
// }

// // Event for Setting Time Range
// class SetTimeRangeEvent extends TimeBlockRequestEvent {
//   final TimeOfDay startTime;
//   final TimeOfDay endTime;

//   const SetTimeRangeEvent({
//     required this.startTime,
//     required this.endTime,
//   });

//   @override
//   List<Object?> get props => [startTime, endTime];
// }

// // Event for Adding Notes
// class AddNotesEvent extends TimeBlockRequestEvent {
//   final String notes;

//   const AddNotesEvent(this.notes);

//   @override
//   List<Object?> get props => [notes];
// }

// // Event for Sending the Request
// class SendTimeBlockRequestEvent extends TimeBlockRequestEvent {
//   final TimeBlockRequestModel requestModel; // Pass the model

//   const SendTimeBlockRequestEvent({required this.requestModel});

//   @override
//   List<Object?> get props => [requestModel];
// }

// class NavigateDaysEvent extends TimeBlockRequestEvent {
//   final bool isNext;

//   const NavigateDaysEvent(this.isNext);

//   @override
//   List<Object?> get props => [isNext];
// }

// class UpdateMonthEvent extends TimeBlockRequestEvent {
//   final DateTime newMonth;

//   const UpdateMonthEvent(this.newMonth);

//   @override
//   List<Object?> get props => [newMonth];
// }

// class ToggleDateSelectionEvent extends TimeBlockRequestEvent {
//   final DateTime date;

//   const ToggleDateSelectionEvent(this.date);

//   @override
//   List<Object?> get props => [date];
// }

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

// Event Class
abstract class TimeBlockRequestEvent extends Equatable {
  const TimeBlockRequestEvent();

  @override
  List<Object?> get props => [];
}

class InitializeTimeBlockRequest extends TimeBlockRequestEvent {}

class UpdateSelectedDate extends TimeBlockRequestEvent {
  final DateTime selectedDate;

  const UpdateSelectedDate(this.selectedDate);

  @override
  List<Object?> get props => [selectedDate];
}

class UpdateSelectedDays extends TimeBlockRequestEvent {
  final List<DateTime> selectedDays;

  const UpdateSelectedDays(this.selectedDays);

  @override
  List<Object?> get props => [selectedDays];
}

class ToggleAllDayCheckbox extends TimeBlockRequestEvent {
  final bool isAllDay;

  const ToggleAllDayCheckbox(this.isAllDay);

  @override
  List<Object?> get props => [isAllDay];
}

class UpdateStartTime extends TimeBlockRequestEvent {
  final TimeOfDay startTime;

  const UpdateStartTime(this.startTime);

  @override
  List<Object?> get props => [startTime];
}

class UpdateEndTime extends TimeBlockRequestEvent {
  final TimeOfDay endTime;

  const UpdateEndTime(this.endTime);

  @override
  List<Object?> get props => [endTime];
}

class UpdateNote extends TimeBlockRequestEvent {
  final String note;

  const UpdateNote(this.note);

  @override
  List<Object?> get props => [note];
}

class SubmitTimeBlockRequest extends TimeBlockRequestEvent {}