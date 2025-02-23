// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:roadrunner_provider_app/features/map/uisness_logic/bloc/map_bloc.dart';
// import 'package:roadrunner_provider_app/features/map/data/model/map_data_type.dart';
// import 'package:roadrunner_provider_app/features/map/presentation/widget/map_widget.dart';

// class MapScreen extends StatefulWidget {
//   @override
//   _MapScreenState createState() => _MapScreenState();
// }

// class _MapScreenState extends State<MapScreen> {
//   List<Map<String, dynamic>> routeDetails = [];

//   void handleRouteDetailsUpdate(List<Map<String, dynamic>> details) {
//     setState(() {
//       routeDetails = details;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     // locations
//     List<String> usaOrders = [
//       '1011 Lincoln Blvd, San Francisco, CA 94129, USA',
//       'Beach St, San Francisco, CA 94133, USA',
//       '1 Dr Carlton B Goodlett Pl, San Francisco, CA 94102, USA',
//       '333 Post St, San Francisco, CA 94108, USA',
//     ];

//     return BlocProvider(
//       create: (context) => MapBloc(),
//       child: Scaffold(
//         appBar: AppBar(title: const Text('Order Locations')),
//         body: Center(
//           child: Column(
//             children: [
//               // Display map here
//               ClipRRect(
//                 borderRadius: BorderRadius.circular(15.r),
//                 child: Container(
//                   height: 288.h,
//                   width: 368.w,
//                   decoration: BoxDecoration(
//                     color: Colors.grey.shade300,
//                     borderRadius: BorderRadius.circular(15.r),
//                   ),
//                   child: MapWidget(
//                     locations: usaOrders,
//                     mapDataType: MapDataType.orders,
//                     onRouteDetailsUpdated: handleRouteDetailsUpdate,
//                   ),
//                 ),
//               ),
//               // Display distance and duration here
//               if (routeDetails.isNotEmpty)
//                 ...routeDetails.map((detail) {
//                   return ListTile(
//                     title: Text("........."),
//                     subtitle: Text(
//                         "Distance: ${detail['distance']}, Duration: ${detail['duration']}"),
//                   );
//                 }),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
