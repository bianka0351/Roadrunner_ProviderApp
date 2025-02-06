// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:roadrunner_provider_app/time-block-request/data/datasources/time_block_request_api_service.dart';

// import 'time_block_request_event.dart';
// import 'time_block_request_state.dart';

// class TimeBlockRequestBloc extends Bloc<TimeBlockRequestEvent, TimeBlockRequestState> {
//   TimeBlockRequestBloc({required TimeBlockRequestApiService apiService})
//       : super(TimeBlockRequestUpdatedState(
//           currentMonth: DateTime.now(),
//           selectedDates: [],
//         )) {
//     on<NavigateDaysEvent>(_onNavigateDays);
//     on<UpdateMonthEvent>(_onUpdateMonth);
//     on<ToggleDateSelectionEvent>(_onToggleDateSelection);
//   }

//   void _onNavigateDays(
//       NavigateDaysEvent event, Emitter<TimeBlockRequestState> emit) {
//     final currentState = state as TimeBlockRequestUpdatedState;
//     final newDate = currentState.selectedDates.isNotEmpty
//         ? currentState.selectedDates.last.add(Duration(days: event.isNext ? 1 : -1))
//         : DateTime.now();

//     final newMonth = DateTime(newDate.year, newDate.month);

//     emit(TimeBlockRequestUpdatedState(
//       currentMonth: newMonth,
//       selectedDates: [...currentState.selectedDates],
//     ));
//   }

//   void _onUpdateMonth(
//       UpdateMonthEvent event, Emitter<TimeBlockRequestState> emit) {
//     final currentState = state as TimeBlockRequestUpdatedState;

//     emit(TimeBlockRequestUpdatedState(
//       currentMonth: event.newMonth,
//       selectedDates: currentState.selectedDates,
//     ));
//   }

//   void _onToggleDateSelection(
//       ToggleDateSelectionEvent event, Emitter<TimeBlockRequestState> emit) {
//     final currentState = state as TimeBlockRequestUpdatedState;
//     final selectedDates = List<DateTime>.from(currentState.selectedDates);

//     if (selectedDates.contains(event.date)) {
//       selectedDates.remove(event.date);
//     } else {
//       selectedDates.add(event.date);
//     }

//     emit(TimeBlockRequestUpdatedState(
//       currentMonth: currentState.currentMonth,
//       selectedDates: selectedDates,
//     ));
//   }
// }

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../data/models/time-block-request-model.dart';
import '../data/repositories/time-block-request-repository.dart';

/// Events
abstract class TimeBlockRequestEvent extends Equatable {
  const TimeBlockRequestEvent();

  @override
  List<Object?> get props => [];
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

class FetchRequestsEvent extends TimeBlockRequestEvent {}

/// States
abstract class TimeBlockRequestState extends Equatable {
  const TimeBlockRequestState();

  @override
  List<Object?> get props => [];
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

  const AllDayToggledState(this.isAllDay);

  @override
  List<Object?> get props => [isAllDay];
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

class TimeBlockRequestsLoaded extends TimeBlockRequestState {
  final List<TimeBlockRequestModel> requests;

  const TimeBlockRequestsLoaded(this.requests);

  @override
  List<Object?> get props => [requests];
}

/// Bloc
class TimeBlockRequestBloc
    extends Bloc<TimeBlockRequestEvent, TimeBlockRequestState> {
  final TimeBlockRequestRepository repository;

  // State variables to keep track of intermediate data
  List<DateTime> selectedDates = [];
  bool isAllDay = false;
  String startTime = '';
  String endTime = '';
  String notes = '';

  TimeBlockRequestBloc({required this.repository})
      : super(TimeBlockRequestInitial()) {
    on<SelectDatesEvent>((event, emit) {
      selectedDates = event.selectedDates;
      emit(DatesSelectedState(selectedDates));
    });

    on<ToggleAllDayEvent>((event, emit) {
      isAllDay = event.isAllDay;
      emit(AllDayToggledState(isAllDay));
    });

    on<SetTimeRangeEvent>((event, emit) {
      startTime = event.startTime;
      endTime = event.endTime;
      emit(TimeRangeSetState(startTime: startTime, endTime: endTime));
    });

    on<AddNotesEvent>((event, emit) {
      notes = event.notes;
      emit(NotesAddedState(notes));
    });

    on<SubmitRequestEvent>((event, emit) async {
      emit(TimeBlockRequestSubmitting());
      final requestModel = TimeBlockRequestModel(
        selectedDates: selectedDates,
        isAllDay: isAllDay,
        startTime: startTime,
        endTime: endTime,
        note: notes,
      );

      try {
        await repository.submitRequest(requestModel);
        emit(TimeBlockRequestSuccess());
      } catch (error) {
        emit(TimeBlockRequestFailure(error.toString()));
      }
    });

    on<FetchRequestsEvent>((event, emit) async {
      try {
        final requests = await repository.getAllRequests();
        emit(TimeBlockRequestsLoaded(requests));
      } catch (error) {
        emit(TimeBlockRequestFailure(error.toString()));
      }
    });
  }
}
