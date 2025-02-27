import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:latlong2/latlong.dart';
import 'package:roadrunner_provider_app/core/constants/app_colors.dart';
import 'package:roadrunner_provider_app/features/map/buisness_logic/bloc/map_bloc2.dart';
import 'package:roadrunner_provider_app/features/map/buisness_logic/bloc/map_event2.dart';
import 'package:roadrunner_provider_app/features/map/buisness_logic/bloc/map_state2.dart';
import 'package:roadrunner_provider_app/features/map/data/model/map_data_type.dart';
import 'package:roadrunner_provider_app/features/map/presentation/widget/order_runner_locations_map.dart';
import 'package:roadrunner_provider_app/features/map/presentation/widget/orders_locations_map.dart';

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
  final MapController _mapController = MapController();
  double _currentZoom = 12.0;
  LatLng _initialLocation = LatLng(0.0, 0.0);

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
        context.read<MapBloc>().add(LoadOrderDetailLocationEvent(
            runnerAddress: widget.runnerAddress!,
            orderAddress: widget.orderDetailAddress!));
        break;
    }
  }

  void _zoomOut() {
    setState(() {
      _currentZoom = (_currentZoom - 0.5).clamp(1.0, 18.0);
      _mapController.move(_mapController.camera.center, _currentZoom);
    });
  }

  void _zoomIn() {
    setState(() {
      _currentZoom = (_currentZoom + 0.5).clamp(1.0, 18.0);
      _mapController.move(_mapController.camera.center, _currentZoom);
    });
  }

  void _resetLocation() {
    _mapController.move(_initialLocation, _currentZoom);
    _mapController.rotate(0);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      // The map
      BlocBuilder<MapBloc, MapState>(builder: (context, state) {
        // error state
        if (state is MapErrorState) {
          return Center(
            child: Text(state.message),
          );

          //orders locations state
        } else if (state is OrdersLocationsState) {
          _initialLocation = state.ordersLocations.first;
          if (widget.onRouteDetailsUpdated != null) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              widget.onRouteDetailsUpdated!(state.routeDetails);
            });
          }
          return OrdersLocationsMap(
              mapController: _mapController,
              initialZoom: _currentZoom,
              routePath: state.routePath,
              ordersLocations: state.ordersLocations);
        }

        // order detail location state
        else if (state is OrderDetailLocationState) {
          _initialLocation = state.runnerLocation;
          if (widget.onRouteDetailsUpdated != null) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              widget.onRouteDetailsUpdated!(state.routeDetails);
            });
          }
          return OrderRunnerLocationsMap(
            mapController: _mapController,
            initialZoom: _currentZoom,
            routePath: state.routePath,
            runnerLocation: state.runnerLocation,
            orderLocation: state.orderLocation,
          );
        }

        // indicator
        return const Center(child: CircularProgressIndicator());
      }),

      // location button
      Positioned(
        bottom: 10.h,
        right: 5.w,
        child: ElevatedButton(
          onPressed: () {
            _resetLocation();
          },
          style: ElevatedButton.styleFrom(
            shape: CircleBorder(
              side: BorderSide(color: AppColors.secondaryColor, width: 1.w),
            ),
            padding: EdgeInsets.all(10.r),
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            elevation: 0,
          ),
          child: Icon(
            Icons.my_location,
            size: 24,
            color: AppColors.secondaryColor,
          ),
        ),
      ),

      // zoom in out buttons
      Positioned(
        bottom: 65.h,
        left: 5.w,
        child: ElevatedButton(
          onPressed: () {
            _zoomIn();
          },
          style: ElevatedButton.styleFrom(
            shape: CircleBorder(
              side: BorderSide(color: AppColors.secondaryColor, width: 1.w),
            ),
            padding: EdgeInsets.all(10.r),
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            elevation: 0,
          ),
          child: Icon(
            Icons.add,
            size: 24,
            color: AppColors.secondaryColor,
          ),
        ),
      ),

      // Zoom Out Button
      Positioned(
        bottom: 10.h,
        left: 5.w,
        child: ElevatedButton(
          onPressed: () {
            _zoomOut();
          },
          style: ElevatedButton.styleFrom(
            shape: CircleBorder(
              side: BorderSide(color: AppColors.secondaryColor, width: 1.w),
            ),
            padding: EdgeInsets.all(10.r),
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            elevation: 0,
          ),
          child: Icon(
            Icons.remove,
            size: 24,
            color: AppColors.secondaryColor,
          ),
        ),
      ),
    ]);
  }
}
