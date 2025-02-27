import 'package:equatable/equatable.dart';

abstract class MapState extends Equatable {
  const MapState();

  @override
  List<Object?> get props => [];
}

// Initial state
class MapInitialState extends MapState {}

// Loading state
class MapLoadingState extends MapState {}

// orders locations state
class OrdersLocationsState extends MapState {
  final List<Map<String, dynamic>> ordersLocations;

  const OrdersLocationsState({required this.ordersLocations});

  @override
  List<Object?> get props => [ordersLocations];
}

// Error state
class MapErrorState extends MapState {
  final String message;

  const MapErrorState(this.message);

  @override
  List<Object?> get props => [message];
}
