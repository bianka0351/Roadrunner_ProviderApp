import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latlong2/latlong.dart';
import 'package:roadrunner_provider_app/features/home-page/data/model/order_model.dart';
import 'package:roadrunner_provider_app/features/map/buisness_logic/bloc/map_bloc.dart';
import 'package:roadrunner_provider_app/features/map/presentation/widget/map_widget.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<LatLng> orderLocations = [
      LatLng(37.808233, -122.415805),
      LatLng(37.804503, -122.415075),
      LatLng(37.804172, -122.409958),
      LatLng(37.803376, -122.416577),
    ];

    OrderResponseModel orders = OrderResponseModel(orders: []);

    Order order_01 = Order(clientAddress: '');
    Order order_02 = Order(clientAddress: '');
    Order order_03 = Order(clientAddress: '');
    Order order_04 = Order(clientAddress: '');

    orders.orders?.add(order_01);
    orders.orders?.add(order_02);
    orders.orders?.add(order_03);
    orders.orders?.add(order_04);

    List<String> usaOrders = [
      '1011 Lincoln Blvd, San Francisco, CA 94129, USA',
      'Beach St, San Francisco, CA 94133, USA',
      '1 Dr Carlton B Goodlett Pl, San Francisco, CA 94102, USA',
      '333 Post St, San Francisco, CA 94108, USA'
    ];

    return BlocProvider(
      create: (context) => MapBloc(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Order Locations')),
        body: MapWidget(
          orders: usaOrders,
        ),
      ),
    );
  }
}
