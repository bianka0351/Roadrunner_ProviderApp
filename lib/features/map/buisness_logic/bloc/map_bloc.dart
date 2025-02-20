import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latlong2/latlong.dart';
import 'package:roadrunner_provider_app/core/unified_api/failures.dart';
import 'package:roadrunner_provider_app/features/map/buisness_logic/bloc/map_event.dart';
import 'package:roadrunner_provider_app/features/map/buisness_logic/bloc/map_state.dart';
import 'package:roadrunner_provider_app/features/map/data/repository/map_repository.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  final MapRepository mapRepository = MapRepository();

  MapBloc() : super(MapInitialState()) {
    on<LoadOrdersLocationEvent>(_onLoadOrdersLocationDate);
  }

  Future<void> _onLoadOrdersLocationDate(
      LoadOrdersLocationEvent event, Emitter<MapState> emit) async {
    if (event.orderLocations.isEmpty) {
      emit(const MapErrorState('No order locations provided'));
      return;
    }

    emit(MapLoadingState());

    final Either<Failure, List<LatLng>> addressToLatLngResult =
        await mapRepository.getOrdersAdressLocation(event.orderLocations);

    await addressToLatLngResult.fold((failure) async {
      emit(MapErrorState('Failed to convert addresses: ${failure.message}'));
    }, (latLngList) async {
      final Either<Failure, Map<String, dynamic>> routePathResult =
          await mapRepository.getOrdersLocationRoute(latLngList);

      routePathResult.fold((failure) {
        emit(MapErrorState('Failed to get route path: ${failure.message}'));
      }, (routeData) {
        emit(OrdersLocationState(
          orderLocations: latLngList,
          routePath: routeData['routePath'], // Route path for the map
          routeDetails:
              routeData['routeDetails'], // Distance & duration details
        ));
      });
    });
  }
}
