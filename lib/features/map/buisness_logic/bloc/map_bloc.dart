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
    on<LoadOrdersLocationsEvent>(_onLoadOrdersLocationsDate);
    on<LoadOrderDetailLocationEvent>(_onLoadOrderDetailLocationData);
  }

  Future<void> _onLoadOrdersLocationsDate(
      LoadOrdersLocationsEvent event, Emitter<MapState> emit) async {
    // empty data
    if (event.ordersAddresses.isEmpty) {
      emit(const MapErrorState('No order locations provided'));
      return;
    }
    // loading
    emit(MapLoadingState());

    final Either<Failure, List<LatLng>> addressToLatLngResult =
        await mapRepository.getOrdersAdressLocation(event.ordersAddresses);

    await addressToLatLngResult.fold((failure) async {
      emit(MapErrorState('Failed to convert addresses: ${failure.message}'));
    }, (latLngList) async {
      final Either<Failure, Map<String, dynamic>> routePathResult =
          await mapRepository.getLocationsRoutes(latLngList);

      routePathResult.fold((failure) {
        emit(MapErrorState('Failed to get route path: ${failure.message}'));
      }, (routeData) {
        emit(OrdersLocationsState(
          ordersLocations: latLngList,
          routePath: routeData['routePath'], // Route path for the map
          routeDetails:
              routeData['routeDetails'], // Distance & duration details
        ));
      });
    });
  }

  Future<void> _onLoadOrderDetailLocationData(
      LoadOrderDetailLocationEvent event, Emitter<MapState> emit) async {
    // empty data
    if (event.orderAddress.isEmpty) {
      emit(const MapErrorState('No order location provided'));
      return;
    }
    // loading
    final Either<Failure, List<LatLng>> addressToLatLngResult =
        await mapRepository.getOrderRunnerAddressLocations(
            event.runnerAddress, event.orderAddress);

    await addressToLatLngResult.fold((failure) async {
      emit(MapErrorState('Failed to convert addresses: ${failure.message}'));
    }, (latLngList) async {
      final Either<Failure, Map<String, dynamic>> routePathResult =
          await mapRepository.getLocationsRoutes(latLngList);

      routePathResult.fold((failure) {
        emit(MapErrorState('Failed to get route path: ${failure.message}'));
      }, (routeData) {
        emit(OrderDetailLocationState(
          runnerLocation: latLngList[0],
          orderLocation: latLngList[1],
          routePath: routeData['routePath'], // Route path for the map
          routeDetails:
              routeData['routeDetails'], // Distance & duration details
        ));
      });
    });
  }
}
