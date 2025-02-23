// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import '../../cubit/client_addresses_cubit.dart';
// import '../../data/model/client.dart';

// class AddressPopup extends StatelessWidget {
//   final Function(Address) onAddressSelected;

//   const AddressPopup({required this.onAddressSelected, super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<ClientAddressesCubit, ClientAddressesState>(
//       builder: (context, state) {
//         return Dialog(
//           child: Padding(
//             padding: EdgeInsets.all(16.w),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 TextField(
//                   decoration: InputDecoration(
//                     hintText: 'Search for an address',
//                     prefixIcon: Icon(Icons.search),
//                   ),
//                 ),
//                 SizedBox(height: 16.h),
//                 _buildAddressOption('Home', () {
//                   // Navigate to Address Map Page
//                   Navigator.pop(context);
//                   onAddressSelected(Address(
//                     streetAddress: 'Home Address',
//                     city: 'City',
//                     stateCode: 'State',
//                     zipCode: 'Zip',
//                     countryCode: 'Country',
//                   ));
//                 }),
//                 _buildAddressOption('Work', () {
//                   // Navigate to Address Map Page
//                   Navigator.pop(context);
//                   onAddressSelected(Address(
//                     streetAddress: 'Work Address',
//                     city: 'City',
//                     stateCode: 'State',
//                     zipCode: 'Zip',
//                     countryCode: 'Country',
//                   ));
//                 }),
//                 _buildAddressOption('+ Add location', () {
//                   // Navigate to Address Map Page
//                   Navigator.pop(context);
//                   onAddressSelected(Address(
//                     streetAddress: 'New Address',
//                     city: 'City',
//                     stateCode: 'State',
//                     zipCode: 'Zip',
//                     countryCode: 'Country',
//                   ));
//                 }),
//                 SizedBox(height: 16.h),
//                 Text('Saved Addresses'),
//                 if (state is ClientAddressesLoaded)
//                   ...state.addresses.map((address) => ListTile(
//                         title: Text(address.streetAddress),
//                         trailing: IconButton(
//                           icon: Icon(Icons.edit),
//                           onPressed: () {
//                             // Navigate to Address Map Page
//                             Navigator.pop(context);
//                             onAddressSelected(address);
//                           },
//                         ),
//                       )),
//                 SizedBox(height: 16.h),
//                 TextButton(
//                   onPressed: () => Navigator.pop(context),
//                   child: Text('Cancel'),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }

//   Widget _buildAddressOption(String label, VoidCallback onTap) {
//     return ListTile(
//       title: Text(label),
//       onTap: onTap,
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:roadrunner_provider_app/core/constants/app_colors.dart';
import '../../data/model/client.dart';
import '../screen/location_screen.dart';
import 'build_address_option.dart';

class AddressPopup extends StatelessWidget {
  final Function(Address) onAddressSelected;
  final List<Address> savedAddresses;

  const AddressPopup({
    required this.onAddressSelected,
    required this.savedAddresses,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Choose an address:',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.h),

            // Search Bar
            TextField(
              decoration: InputDecoration(
                hintText: 'Search for an address',
                    hintStyle: TextStyle(color: AppColors.tertiaryColor),

                prefixIcon: Icon(Icons.search,color: AppColors.tertiaryColor),
                border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15.r),
      borderSide: BorderSide(color: AppColors.tertiaryColor), // Default border color
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15.r),
      borderSide: BorderSide(color: AppColors.tertiaryColor), // Unfocused border color
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15.r),
      borderSide: BorderSide(color: AppColors.tertiaryColor, width: 2), // Focused border color
    ),
  ),
),
            SizedBox(height: 16.h),

            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                buildAddressOption(
                  icon: Icons.home,
                  label: 'Home',
                  subLabel: 'Get Address',
                  onTap: () {
                    final address = Address(
                      streetAddress: 'Home Address',
                      city: 'City',
                      stateCode: 'State',
                      zipCode: 'Zip',
                      countryCode: 'Country',
                    );
                    onAddressSelected(address);
                  },
                ),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.w),
                  child: Container(width: 1, height: 40, color: Colors.grey),
                ), // Vertical Divider

                buildAddressOption(
                  icon: Icons.work,
                  label: 'Work',
                  subLabel: 'Get Address',
                  onTap: () {
                    final address = Address(
                      streetAddress: 'Work Address',
                      city: 'City',
                      stateCode: 'State',
                      zipCode: 'Zip',
                      countryCode: 'Country',
                    );
                    onAddressSelected(address);
                  },
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.w),
                  child: Container(width: 1, height: 40, color: Colors.grey),
                ),
                buildAddressOption(
                  icon: Icons.add,
                  label: 'Add location',
                  subLabel: '',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LocationScreen(),
                      ),
                    );
                  },
                ),
              ],
            ),
            Divider(),
            //  SizedBox(height: 16.h),

            // Explore Nearby
            Text(
              'Explore Nearby',
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
            ),

            // Use Current Location
            ListTile(
              leading: Icon(Icons.location_on),
              title: Text(
                'Use current location',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text('Enable location services'),
              trailing: Icon(
                Icons.arrow_forward_ios,
                size: 20.h,
              ),
              onTap: () {
                // Handle "Use current location" action
              },
            ),
            SizedBox(height: 16.h),

            // Saved Addresses
            Text(
              'Saved Addresses',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.h),
            ...savedAddresses.asMap().entries.map((entry) {
              int index = entry.key + 1; // Start from 1 instead of 0
              var address = entry.value;
              return ListTile(
                leading: Icon(Icons.location_on),
                title: Text(
                  'Address $index',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(address.streetAddress),
                trailing: IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    // Navigate to edit address page
                    Navigator.pop(context); // Close the popup first
                    _navigateToEditAddressPage(context, address);
                  },
                ),
              );
            }),
            SizedBox(height: 16.h),
            // Cancel Button
            Padding(
              padding: EdgeInsets.only(left: 220.w),
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      WidgetStateProperty.all(AppColors.tertiaryColor),
                      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r), // Adjust the radius as needed
        ),
      ),
                ),
                onPressed: () => Navigator.pop(context),
                child: Text(
                  'Cancel',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget _buildAddressOption(String label, VoidCallback onTap) {
  //   return ListTile(
  //     title: Text(label),
  //     onTap: onTap,
  //   );
  // }

  void _navigateToEditAddressPage(BuildContext context, Address address) {
    // Navigate to a page where the user can edit the address
    // Pass the address to the edit page
  }
}
