import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latlong2/latlong.dart';
import 'package:roadrunner_provider_app/features/map/buisness_logic/bloc/map_bloc.dart';
import 'package:roadrunner_provider_app/features/map/buisness_logic/bloc/map_event.dart';
import 'package:roadrunner_provider_app/features/map/presentation/widget/map_widget.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MapBloc()
        ..add(LoadMapDataEvent([
          LatLng(37.7749, -122.4194), // Example order locations
          LatLng(37.7849, -122.4094),
          LatLng(37.7949, -122.3994),
        ])),
      child: Scaffold(
        appBar: AppBar(title: const Text('Order Locations')),
        body: const MapWidget(),
      ),
    );
  }
}
