import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/models/time-block-request-model.dart';
import '../data/repositories/time-block-request-repository.dart';
import 'time_block_request_event.dart';
import 'time_block_request_state.dart';

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

      // Emit a new state that includes both the updated `isAllDay` and the current `selectedDates`
      emit(AllDayToggledState(isAllDay, selectedDates: selectedDates));
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
