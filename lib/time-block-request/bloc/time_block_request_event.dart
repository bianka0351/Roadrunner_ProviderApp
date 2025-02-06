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