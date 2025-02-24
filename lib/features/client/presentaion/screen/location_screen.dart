// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:roadrunner_provider_app/features/client/data/model/client.dart';

// import '../../cubit/client_addresses_cubit.dart';

// class LocationScreen extends StatelessWidget {
//   final TextEditingController _addressController = TextEditingController();
//   final TextEditingController _phoneNumberController = TextEditingController();
//   final TextEditingController _specialInstructionsController =
//       TextEditingController();

//   LocationScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Location Page'),
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(16.w),
//         child: Column(
//           children: [
//             TextField(
//               controller: _addressController,
//               decoration: InputDecoration(labelText: 'Address'),
//             ),
//             SizedBox(height: 16.h),
//             TextField(
//               controller: _phoneNumberController,
//               decoration: InputDecoration(labelText: 'Phone Number'),
//             ),
//             SizedBox(height: 16.h),
//             TextField(
//               controller: _specialInstructionsController,
//               decoration: InputDecoration(labelText: 'Special Instructions'),
//             ),
//             SizedBox(height: 32.h),
//             ElevatedButton(
//               onPressed: () {
//                 final address = Address(
//                   streetAddress: _addressController.text,
//                   city: '', // Add city if needed
//                   stateCode: '', // Add state if needed
//                   zipCode: '', // Add zip code if needed
//                   countryCode: '', // Add country code if needed
//                 );
//                 context.read<ClientAddressesCubit>().addAddress(address);
//                 Navigator.pop(context); // Navigate back after adding
//               },
//               child: Text('ADD'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LocationScreen extends StatelessWidget {
  const LocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Location Page'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child:  Text('ADD'),
      )
    );
  }
}