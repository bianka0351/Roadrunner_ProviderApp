import 'package:equatable/equatable.dart';

abstract class MapEvent extends Equatable {
  const MapEvent();

  @override
  List<Object?> get props => [];
}

// load map data with a list of order locations
class LoadOrdersLocationsEvent extends MapEvent {
  final List<String> ordersAddresses;

  const LoadOrdersLocationsEvent({required this.ordersAddresses});

  @override
  List<Object?> get props => [ordersAddresses];
}
