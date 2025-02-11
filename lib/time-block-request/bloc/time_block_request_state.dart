import 'package:equatable/equatable.dart';
import '../data/models/previous_time_block_requests_model.dart';

/// States
abstract class TimeBlockRequestState extends Equatable {
  const TimeBlockRequestState();

  @override
  List<Object?> get props => [];
}

class TimeBlockRequestLoading extends TimeBlockRequestState {}

class TimeBlockRequestEmpty extends TimeBlockRequestState {}

class TimeBlockRequestsLoaded extends TimeBlockRequestState {
  final List<PreviousTimeBlockRequestModel> requests;

  const TimeBlockRequestsLoaded(this.requests);

  @override
  List<Object?> get props => [requests];
}

class TimeBlockRequestInitial extends TimeBlockRequestState {}

class DatesSelectedState extends TimeBlockRequestState {
  final List<DateTime> selectedDates;

  const DatesSelectedState(this.selectedDates);

  @override
  List<Object?> get props => [selectedDates];
}

class AllDayToggledState extends TimeBlockRequestState {
  final bool isAllDay;
  final List<DateTime> selectedDates;

  const AllDayToggledState(this.isAllDay, {required this.selectedDates});

  @override
  List<Object?> get props => [isAllDay, selectedDates];
}

class TimeRangeSetState extends TimeBlockRequestState {
  final String startTime;
  final String endTime;

  const TimeRangeSetState({
    required this.startTime,
    required this.endTime,
  });

  @override
  List<Object?> get props => [startTime, endTime];
}

class NotesAddedState extends TimeBlockRequestState {
  final String notes;

  const NotesAddedState(this.notes);

  @override
  List<Object?> get props => [notes];
}

class TimeBlockRequestSubmitting extends TimeBlockRequestState {}

class TimeBlockRequestSuccess extends TimeBlockRequestState {}

class TimeBlockRequestFailure extends TimeBlockRequestState {
  final String errorMessage;

  const TimeBlockRequestFailure(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}

// class TimeBlockRequestsLoaded extends TimeBlockRequestState {
//   final List<TimeBlockRequestModel> requests;

//   const TimeBlockRequestsLoaded(this.requests);

//   @override
//   List<Object?> get props => [requests];
// }
