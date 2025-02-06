import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

/// Abstract base class for all states
abstract class TimeBlockRequestState extends Equatable {
  const TimeBlockRequestState();

  @override
  List<Object?> get props => [];
}

/// Initial state when no action has been performed
class TimeBlockRequestInitial extends TimeBlockRequestState {}

/// State when dates are selected
class DatesSelectedState extends TimeBlockRequestState {
  final List<DateTime> selectedDates;

  const DatesSelectedState(this.selectedDates);

  @override
  List<Object?> get props => [selectedDates];
}

/// State when the "All Day" checkbox is toggled
class AllDayToggledState extends TimeBlockRequestState {
  final bool isAllDay;

  const AllDayToggledState(this.isAllDay);

  @override
  List<Object?> get props => [isAllDay];
}

/// State when a time range is set
class TimeRangeSetState extends TimeBlockRequestState {
  final TimeOfDay startTime;
  final TimeOfDay endTime;

  const TimeRangeSetState({
    required this.startTime,
    required this.endTime,
  });

  @override
  List<Object?> get props => [startTime, endTime];
}

/// State when notes are added
class NotesAddedState extends TimeBlockRequestState {
  final String notes;

  const NotesAddedState(this.notes);

  @override
  List<Object?> get props => [notes];
}

/// State when the request is being submitted (Loading)
class TimeBlockRequestSubmitting extends TimeBlockRequestState {
  const TimeBlockRequestSubmitting();

  @override
  List<Object?> get props => [];
}

/// State when the request is successfully submitted
class TimeBlockRequestSuccess extends TimeBlockRequestState {
  final String successMessage;

  const TimeBlockRequestSuccess(this.successMessage);

  @override
  List<Object?> get props => [successMessage];
}

/// State when the request submission fails
class TimeBlockRequestFailure extends TimeBlockRequestState {
  final String errorMessage;

  const TimeBlockRequestFailure(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}

/// State when the month or week is updated
class TimeBlockRequestUpdatedState extends TimeBlockRequestState {
  final DateTime currentMonth;
  final List<DateTime> selectedDates;
  final List<String> weekDays;

  const TimeBlockRequestUpdatedState({
    required this.currentMonth,
    required this.selectedDates,
    required this.weekDays,
  });

  @override
  List<Object?> get props => [currentMonth, selectedDates, weekDays];
}
