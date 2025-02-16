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

  void _onLoadOrdersLocationDate(
      LoadOrdersLocationEvent event, Emitter<MapState> emit) async {
    if (event.orderLocations.isEmpty) {
      emit(const MapErrorState('No order locations provided'));
      return;
    }

    emit(MapLoadingState());

    final Either<Failure, List<LatLng>> result =
        await mapRepository.getRoute(event.orderLocations);

    result.fold(
      (failure) => emit(MapErrorState(failure.message)),
      (routePath) => emit(OrdersLocationState(
          orderLocations: event.orderLocations, routePath: routePath)),
    );
  }
}
