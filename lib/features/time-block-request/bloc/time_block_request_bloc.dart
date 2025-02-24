// // import 'package:flutter_bloc/flutter_bloc.dart';
// // import '../data/models/time-block-request-model.dart';
// // import '../data/repositories/time-block-request-repository.dart';
// // import 'time_block_request_event.dart';
// // import 'time_block_request_state.dart';

// // /// Bloc
// // class TimeBlockRequestBloc
// //     extends Bloc<TimeBlockRequestEvent, TimeBlockRequestState> {
// //   final TimeBlockRequestRepository repository;

// //   // State variables to keep track of intermediate data
// //   List<DateTime> selectedDates = [];
// //   bool isAllDay = false;
// //   String startTime = '';
// //   String endTime = '';
// //   String notes = '';

// //   TimeBlockRequestBloc({required this.repository})
// //       : super(TimeBlockRequestInitial()) {
// //     on<SelectDatesEvent>((event, emit) {
// //       selectedDates = event.selectedDates;
// //       emit(DatesSelectedState(selectedDates));
// //     });

// //     on<ToggleAllDayEvent>((event, emit) {
// //       isAllDay = event.isAllDay;

// //       // Emit a new state that includes both the updated `isAllDay` and the current `selectedDates`
// //       emit(AllDayToggledState(isAllDay, selectedDates: selectedDates));
// //     });

// //     on<SetTimeRangeEvent>((event, emit) {
// //       startTime = event.startTime;
// //       endTime = event.endTime;
// //       emit(TimeRangeSetState(startTime: startTime, endTime: endTime));
// //     });

// //     on<AddNotesEvent>((event, emit) {
// //       notes = event.notes;
// //       emit(NotesAddedState(notes));
// //     });

// //     // on<SubmitRequestEvent>((event, emit) async {
// //     //   emit(TimeBlockRequestSubmitting());
// //     //   final requestModel = TimeBlockRequestModel(
// //     //     selectedDates: selectedDates,
// //     //     isAllDay: isAllDay,
// //     //     startTime: startTime,
// //     //     endTime: endTime,
// //     //     note: notes,
// //     //   );

// //     //   try {
// //     //     await repository.submitRequest(requestModel);
// //     //     emit(TimeBlockRequestSuccess());
// //     //   } catch (error) {
// //     //     emit(TimeBlockRequestFailure(error.toString()));
// //     //   }
// //     // });
// //     on<SubmitRequestEvent>((event, emit) async {
// //       // Check if the required fields are filled
// //       if (selectedDates.isEmpty) {
// //         emit(TimeBlockRequestFailure('Please select the time block dates.'));
// //         return;
// //       }

// //       if (!isAllDay && (startTime.isEmpty || endTime.isEmpty)) {
// //         emit(TimeBlockRequestFailure('Please select the start and end time.'));
// //         return;
// //       }

// //       emit(TimeBlockRequestSubmitting());
// //       final requestModel = TimeBlockRequestModel(
// //         selectedDates: selectedDates,
// //         isAllDay: isAllDay,
// //         startTime: startTime,
// //         endTime: endTime,
// //         note: notes,
// //       );

// //       try {
// //         await repository.submitRequest(requestModel);
// //         emit(TimeBlockRequestSuccess());
// //       } catch (error) {
// //         emit(TimeBlockRequestFailure(error.toString()));
// //       }
// //     });
// //     on<FetchRequestsEvent>((event, emit) async {
// //       try {
// //         final requests =
// //             await repository.getAllRequests(userId: '', organizationId: '');
// //         emit(TimeBlockRequestsLoaded(requests.cast<TimeBlockRequestModel>()));
// //       } catch (error) {
// //         emit(TimeBlockRequestFailure(error.toString()));
// //       }
// //     });
// //   }
// // }

// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../data/models/time-block-request-model.dart';
// import '../data/repositories/time-block-request-repository.dart';
// import 'time_block_request_event.dart';
// import 'time_block_request_state.dart';

// class TimeBlockRequestBloc extends Bloc<TimeBlockRequestEvent, TimeBlockRequestState> {
//   final TimeBlockRequestRepository repository;

//   List<DateTime> selectedDates = [];
//   bool isAllDay = false;
//   String startTime = '';
//   String endTime = '';
//   String notes = '';

//   TimeBlockRequestBloc({required this.repository}) : super(TimeBlockRequestInitial()) {
//      on<FetchRequestsEvent>((event, emit) async {
//       emit(TimeBlockRequestLoading()); // Emit a loading state

//       try {
//         final requests = await repository.getAllRequests(userId: event.userId, organizationId: event.organizationId);
//         if (requests.isEmpty) {
//           emit(TimeBlockRequestEmpty());
//         } else {
//           emit(TimeBlockRequestsLoaded(requests));
//         }
//       } catch (error) {
//         emit(TimeBlockRequestFailure(error.toString()));
//       }
//     });

//     on<SelectDatesEvent>((event, emit) {
//       selectedDates = event.selectedDates;
//       emit(DatesSelectedState(selectedDates));
//     });

//     on<ToggleAllDayEvent>((event, emit) {
//       isAllDay = event.isAllDay;
//       emit(AllDayToggledState(isAllDay, selectedDates: selectedDates));
//     });

//     on<SetTimeRangeEvent>((event, emit) {
//       startTime = event.startTime;
//       endTime = event.endTime;
//       emit(TimeRangeSetState(startTime: startTime, endTime: endTime));
//     });

//     on<AddNotesEvent>((event, emit) {
//       notes = event.notes;
//       emit(NotesAddedState(notes));
//     });

//     on<SubmitRequestEvent>((event, emit) async {
//       if (selectedDates.isEmpty) {
//         emit(TimeBlockRequestFailure('Please select the time block dates.'));
//         return;
//       }

//       if (!isAllDay && (startTime.isEmpty || endTime.isEmpty)) {
//         emit(TimeBlockRequestFailure('Please select the start and end time.'));
//         return;
//       }

//       emit(TimeBlockRequestSubmitting());

//       final requestModel = TimeBlockRequestModel(
//         selectedDates: selectedDates,
//         isAllDay: isAllDay,
//         startTime: startTime,
//         endTime: endTime,
//         note: notes,
//       );

//       try {
//         await repository.submitRequest(requestModel);
//         emit(TimeBlockRequestSuccess());
//         add(ResetFormEvent()); // Reset all values after successful submission
//       } catch (error) {
//         emit(TimeBlockRequestFailure(error.toString()));
//       }
//     });

//   //   on<FetchRequestsEvent>((event, emit) async {
//   //     try {
//   //       final requests = await repository.getAllRequests(userId: '', organizationId: '');
//   //       emit(TimeBlockRequestsLoaded(requests.cast<PreviousTimeBlockRequestModel>()));
//   //     } catch (error) {
//   //       emit(TimeBlockRequestFailure(error.toString()));
//   //     }
//   //   });

//   //   on<ResetFormEvent>((event, emit) {
//   //     selectedDates = [];
//   //     isAllDay = false;
//   //     startTime = '';
//   //     endTime = '';
//   //     notes = '';
//   //     emit(TimeBlockRequestInitial()); // Reset to the initial state
//   //   });
//    }
// }
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/models/time-block-request-model.dart';
import '../data/repositories/time-block-request-repository.dart';
import 'time_block_request_event.dart';
import 'time_block_request_state.dart';

class TimeBlockRequestBloc
    extends Bloc<TimeBlockRequestEvent, TimeBlockRequestState> {
  final TimeBlockRequestRepository repository;

  List<DateTime> selectedDates = [];
  bool isAllDay = false;
  String startTime = '';
  String endTime = '';
  String notes = '';

  TimeBlockRequestBloc({required this.repository})
      : super(TimeBlockRequestInitial()) {
    // Register event handlers
    on<FetchRequestsEvent>(_onFetchRequestsEvent);
    on<SelectDatesEvent>(_onSelectDatesEvent);
    on<ToggleAllDayEvent>(_onToggleAllDayEvent);
    on<SetTimeRangeEvent>(_onSetTimeRangeEvent);
    on<AddNotesEvent>(_onAddNotesEvent);
    on<SubmitRequestEvent>(_onSubmitRequestEvent);
    on<ResetFormEvent>(_onResetFormEvent);
  }

  // Handler for FetchRequestsEvent
  Future<void> _onFetchRequestsEvent(
    FetchRequestsEvent event,
    Emitter<TimeBlockRequestState> emit,
  ) async {
    emit(TimeBlockRequestLoading()); // Emit loading state

    try {
      final requests = await repository.getAllRequests(
        userId: event.userId,
        organizationId: event.organizationId,
      );

      if (requests.isEmpty) {
        emit(TimeBlockRequestEmpty()); // Emit empty state if no requests
      } else {
        emit(TimeBlockRequestsLoaded(
            requests)); // Emit loaded state with requests
      }
    } catch (error) {
      emit(TimeBlockRequestFailure(error.toString())); // Emit error state
    }
  }

  // Handler for SelectDatesEvent
  void _onSelectDatesEvent(
    SelectDatesEvent event,
    Emitter<TimeBlockRequestState> emit,
  ) {
    selectedDates = event.selectedDates;
    emit(DatesSelectedState(selectedDates));
  }

  // Handler for ToggleAllDayEvent
  void _onToggleAllDayEvent(
    ToggleAllDayEvent event,
    Emitter<TimeBlockRequestState> emit,
  ) {
    isAllDay = event.isAllDay;
    emit(AllDayToggledState(isAllDay, selectedDates: selectedDates));
  }

  // Handler for SetTimeRangeEvent
  void _onSetTimeRangeEvent(
    SetTimeRangeEvent event,
    Emitter<TimeBlockRequestState> emit,
  ) {
    startTime = event.startTime;
    endTime = event.endTime;
    emit(TimeRangeSetState(startTime: startTime, endTime: endTime));
  }

  // Handler for AddNotesEvent
  void _onAddNotesEvent(
    AddNotesEvent event,
    Emitter<TimeBlockRequestState> emit,
  ) {
    notes = event.notes;
    emit(NotesAddedState(notes));
  }

  // Handler for SubmitRequestEvent
  Future<void> _onSubmitRequestEvent(
    SubmitRequestEvent event,
    Emitter<TimeBlockRequestState> emit,
  ) async {
    if (selectedDates.isEmpty) {
      emit(TimeBlockRequestFailure('Please select the time block dates.'));
      return;
    }

    if (!isAllDay && (startTime.isEmpty || endTime.isEmpty)) {
      emit(TimeBlockRequestFailure('Please select the start and end time.'));
      return;
    }

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
      add(ResetFormEvent()); // Reset all values after successful submission
    } catch (error) {
      emit(TimeBlockRequestFailure(error.toString()));
    }
  }

  // Handler for ResetFormEvent
  void _onResetFormEvent(
    ResetFormEvent event,
    Emitter<TimeBlockRequestState> emit,
  ) {
    selectedDates = [];
    isAllDay = false;
    startTime = '';
    endTime = '';
    notes = '';
    emit(TimeBlockRequestInitial()); // Reset to the initial state
  }
}
