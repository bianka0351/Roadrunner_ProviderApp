import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:roadrunner_provider_app/core/unified_api/failures.dart';
import 'package:roadrunner_provider_app/features/map/buisness_logic/bloc/map_event.dart';
import 'package:roadrunner_provider_app/features/map/buisness_logic/bloc/map_state.dart';
import 'package:roadrunner_provider_app/features/map/data/repository/map_repository.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  final MapRepository mapRepository = MapRepository();

  MapBloc() : super(MapInitialState()) {
    on<LoadOrdersLocationsEvent>(_onLoadOrdersLocationsDate);
  }

  Future<void> _onLoadOrdersLocationsDate(
      LoadOrdersLocationsEvent event, Emitter<MapState> emit) async {
    List<String> addresses = [];
    // empty data
    if (event.ordersAddresses.isEmpty) {
      emit(const MapErrorState('No order locations provided'));
      return;
    }
    // loading
    emit(MapLoadingState());

    for (String address in event.ordersAddresses) {
      addresses.add(address);
    }

    final Either<Failure, List<Map<String, dynamic>>> addressToLatLngResult =
        await mapRepository.getLocationsCoordinates(event.ordersAddresses);

    addressToLatLngResult.fold((failure) async {
      emit(MapErrorState('Failed to convert addresses: ${failure.message}'));
    }, (latLngList) async {
      emit(OrdersLocationsState(ordersLocations: latLngList));
    });
  }
}
