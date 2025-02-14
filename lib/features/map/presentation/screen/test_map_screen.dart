import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latlong2/latlong.dart';
import 'package:roadrunner_provider_app/features/map/buisness_logic/bloc/map_bloc.dart';
import 'package:roadrunner_provider_app/features/map/presentation/widget/map_widget.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<LatLng> orderLocations = [
      LatLng(37.044829, 41.230214), // Example order locations
      LatLng(37.050211, 41.218235),
      LatLng(37.040620, 41.211015),
      LatLng(37.042470, 41.229350),
    ];

    return BlocProvider(
      create: (context) => MapBloc(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Order Locations')),
        body: MapWidget(orderLocations: orderLocations),
      ),
    );
  }
}
