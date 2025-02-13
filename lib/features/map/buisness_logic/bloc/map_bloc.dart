import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latlong2/latlong.dart';
import 'package:roadrunner_provider_app/features/map/buisness_logic/bloc/map_event.dart';
import 'package:roadrunner_provider_app/features/map/buisness_logic/bloc/map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  MapBloc() : super(MapInitialState()) {
    on<LoadMapDataEvent>(_onLoadMapDate);
  }

  void _onLoadMapDate(LoadMapDataEvent event, Emitter<MapState> emit) {
    // empty order locations
    if (event.orderLocations.isEmpty) {
      emit(const MapErrorState('No order locations provided'));
      return;
    }

    // Generate route path
    final List<LatLng> routePath = _generateRoute(event.orderLocations);

    emit(MapLoadedState(
        orderLocations: event.orderLocations, routePath: routePath));
  }

  List<LatLng> _generateRoute(List<LatLng> locations) {
    return locations; // just connecting points now
  }
}
