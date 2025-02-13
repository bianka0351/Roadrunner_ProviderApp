import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:roadrunner_provider_app/core/app_colors.dart';
import 'package:roadrunner_provider_app/features/map/buisness_logic/bloc/map_bloc.dart';
import 'package:roadrunner_provider_app/features/map/buisness_logic/bloc/map_state.dart';

class MapWidget extends StatelessWidget {
  const MapWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MapBloc, MapState>(builder: (context, state) {
      // error state
      if (state is MapErrorState) {
        return Center(
          child: Text(state.message),
        );

        //loaded state
      } else if (state is MapLoadedState) {
        return FlutterMap(
          // map options
          options: MapOptions(
            initialCenter: state.orderLocations.first,
            initialZoom: 13.0,
          ),
          // map layers
          children: [
            // tile layer
            TileLayer(
              urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
              subdomains: ['a', 'b', 'c'],
            ),
            // polyline layer
            PolylineLayer(polylines: [
              Polyline(
                  points: state.routePath,
                  color: AppColors.primaryColor,
                  strokeWidth: 4.0.w)
            ]),
            // marker layer
            MarkerLayer(
              markers: state.orderLocations.map((location) {
                return Marker(
                    point: location,
                    width: 40.w,
                    height: 40.h,
                    child: const Icon(
                      Icons.location_pin,
                      color: AppColors.tertiaryColor,
                      size: 30,
                    ));
              }).toList(),
            )
          ],
        );
      }
      // default starting state
      return const Center(child: CircularProgressIndicator());
    });
  }
}
