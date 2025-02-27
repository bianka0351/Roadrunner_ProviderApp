import 'dart:developer';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:roadrunner_provider_app/features/map/buisness_logic/bloc/map_bloc.dart';
import 'package:roadrunner_provider_app/features/map/buisness_logic/bloc/map_event.dart';
import 'package:roadrunner_provider_app/features/map/buisness_logic/bloc/map_state.dart';
import 'package:roadrunner_provider_app/features/map/data/model/map_data_type.dart';
import 'package:roadrunner_provider_app/features/map/presentation/widget/order_location_marker.dart';

class MapWidget extends StatefulWidget {
  final MapDataType mapDataType;
  final List<String>? ordersAddresses;
  final String? orderDetailAddress;
  final String? runnerAddress;
  final void Function(List<Map<String, dynamic>>)? onRouteDetailsUpdated;

  const MapWidget._(
      {super.key,
      this.ordersAddresses,
      required this.mapDataType,
      this.orderDetailAddress,
      this.runnerAddress,
      this.onRouteDetailsUpdated});

  // call map for orders locations
  factory MapWidget.ordersLocations(
      {required List<String> ordersLocations,
      Key? key,
      void Function(List<Map<String, dynamic>>)? onRouteDetailsUpdated}) {
    return MapWidget._(
        key: key,
        mapDataType: MapDataType.orders,
        ordersAddresses: ordersLocations,
        onRouteDetailsUpdated: onRouteDetailsUpdated);
  }

  // call map for order detail location
  factory MapWidget.orderDetailLocation(
      {required String orderDetailAddress,
      required String runnerAddress,
      Key? key,
      void Function(List<Map<String, dynamic>>)? onRouteDetailsUpdated}) {
    return MapWidget._(
        key: key,
        mapDataType: MapDataType.orderDetail,
        orderDetailAddress: orderDetailAddress,
        runnerAddress: runnerAddress,
        onRouteDetailsUpdated: onRouteDetailsUpdated);
  }

  @override
  State<StatefulWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  @override
  void initState() {
    super.initState();
    switch (widget.mapDataType) {
      // orders
      case MapDataType.orders:
        context.read<MapBloc>().add(
            LoadOrdersLocationsEvent(ordersAddresses: widget.ordersAddresses!));
        break;
      // order detail
      case MapDataType.orderDetail:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      BlocBuilder<MapBloc, MapState>(builder: (context, state) {
        // error state
        if (state is MapErrorState) {
          return Center(
            child: Text(state.message),
          );

          //orders locations state
        } else if (state is OrdersLocationsState) {
          log('${state.ordersLocations}');
          return GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(state.ordersLocations[0]['lat'],
                    state.ordersLocations[0]['lng']),
                zoom: 10,
              ),
              markers: Set<Marker>.of(state.ordersLocations.map(
                (location) => Marker(
                    markerId: MarkerId(location['lat'].toString()),
                    position: LatLng(location['lat'], location['lng']),
                    icon: BitmapDescriptor.defaultMarker),
              )));
        }
        // indicator
        return const Center(child: CircularProgressIndicator());
      })
    ]);
  }
}
