import 'package:equatable/equatable.dart';

/// Events
abstract class TimeBlockRequestEvent extends Equatable {
  const TimeBlockRequestEvent();

  @override
  List<Object?> get props => [];
}
class FetchRequestsEvent extends TimeBlockRequestEvent {
  final String userId;
  final String organizationId;

  const FetchRequestsEvent({required this.userId, required this.organizationId});

  @override
  List<Object?> get props => [userId, organizationId];
}
class SelectDatesEvent extends TimeBlockRequestEvent {
  final List<DateTime> selectedDates;

  const SelectDatesEvent(this.selectedDates);

  @override
  List<Object?> get props => [selectedDates];
}

class ToggleAllDayEvent extends TimeBlockRequestEvent {
  final bool isAllDay;

  const ToggleAllDayEvent(this.isAllDay);

  @override
  List<Object?> get props => [isAllDay];
}

class SetTimeRangeEvent extends TimeBlockRequestEvent {
  final String startTime;
  final String endTime;

  const SetTimeRangeEvent({
    required this.startTime,
    required this.endTime,
  });

  @override
  List<Object?> get props => [startTime, endTime];
}

class AddNotesEvent extends TimeBlockRequestEvent {
  final String notes;

  const AddNotesEvent(this.notes);

  @override
  List<Object?> get props => [notes];
}

class SubmitRequestEvent extends TimeBlockRequestEvent {}

//class FetchRequestsEvent extends TimeBlockRequestEvent {}

class ResetFormEvent extends TimeBlockRequestEvent {}
