import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:latlong2/latlong.dart';
import 'package:roadrunner_provider_app/core/app_colors.dart';
import 'package:roadrunner_provider_app/features/home-page/data/model/order_model.dart';
import 'package:roadrunner_provider_app/features/map/buisness_logic/bloc/map_bloc.dart';
import 'package:roadrunner_provider_app/features/map/buisness_logic/bloc/map_event.dart';
import 'package:roadrunner_provider_app/features/map/buisness_logic/bloc/map_state.dart';
import 'package:roadrunner_provider_app/features/map/presentation/widget/order_location_marker.dart';

class MapWidget extends StatefulWidget {
  final List<String> orders;

  const MapWidget({
    super.key,
    required this.orders,
  });

  @override
  State<StatefulWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  final MapController _mapController = MapController();

  @override
  void initState() {
    super.initState();
    // Dispatch the event when the widget initializes
    context.read<MapBloc>().add(LoadOrdersLocationEvent(widget.orders));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MapBloc, MapState>(builder: (context, state) {
      // error state
      if (state is MapErrorState) {
        return Center(
          child: Text(state.message),
        );

        //loaded state
      } else if (state is OrdersLocationState) {
        return FlutterMap(
          // map controller
          mapController: _mapController,
          // map options
          options: MapOptions(
            initialCenter: state.orderLocations.isNotEmpty
                ? state.orderLocations.first
                : LatLng(0, 0),
            initialZoom: 15.0,
          ),
          // map layers
          children: [
            // tile layer
            TileLayer(
              urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            ),
            // polyline layer
            PolylineLayer(polylines: [
              Polyline(
                  points: state.routePath,
                  color: AppColors.tertiaryColor,
                  strokeWidth: 5.0.w)
            ]),
            // marker layer
            MarkerLayer(
              alignment: Alignment.topCenter,
              markers: List.generate(state.orderLocations.length, (index) {
                return Marker(
                    point: state.orderLocations[index],
                    width: 40.w,
                    height: 40.h,
                    child: OrderLocationMarker(index: (index + 1).toString()));
              }).toList(),
            )
          ],
        );
      }
      // indicator
      return const Center(child: CircularProgressIndicator());
    });
  }
}

List<String> ordersAddresses(OrderResponseModel? orders) {
  List<String> ordersList = [];
  // ignore: unused_local_variable
  // for (Order order in orders!.orders) {}

  return ordersList;
}
