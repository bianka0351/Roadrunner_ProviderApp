// import 'package:flutter/material.dart';
// import '../../data/model/client.dart';
// import 'addresses_popup.dart';

// class AddressTextField extends StatelessWidget {
//   final TextEditingController controller;
//   final Function(Address) onAddressSelected;

//   const AddressTextField({
//     required this.controller,
//     required this.onAddressSelected,
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return TextFormField(
//       controller: controller,
//       readOnly: true,
//       decoration: InputDecoration(
//         labelText: 'Address',
//         suffixIcon: IconButton(
//           icon: Icon(Icons.edit),
//           onPressed: () async {
//             final address = await showDialog<Address>(
//               context: context,
//               builder: (context) => AddressPopup(
//                 onAddressSelected: onAddressSelected, savedAddresses: [],
//               ),
//             );
//             if (address != null) {
//               controller.text = address.streetAddress;
//             }
//           },
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import '../../data/model/client.dart';
import 'addresses_popup.dart';

class AddressTextField extends StatelessWidget {
  final TextEditingController controller;
  final Function(Address) onAddressSelected;
  final List<Address> savedAddresses;

  const AddressTextField({
    required this.controller,
    required this.onAddressSelected,
    required this.savedAddresses,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // Set the initial value to the first address if available
    if (savedAddresses.isNotEmpty && controller.text.isEmpty) {
      controller.text = savedAddresses.first.toString();
    }

    return TextFormField(
      controller: controller,
      readOnly: true, // Make the field non-editable
      decoration: InputDecoration(
        labelText: 'Address',
        suffixIcon: IconButton(
          icon: const Icon(Icons.edit),
          onPressed: () async {
            // Open the AddressPopup when the edit icon is clicked
            final address = await showDialog<Address>(
              context: context,
              builder: (context) => AddressPopup(
                onAddressSelected: onAddressSelected,
                savedAddresses: savedAddresses,
              ),
            );

            // Update the controller with the selected address
            if (address != null) {
              controller.text = address.toString();
            }
          },
        ),
      ),
    );
  }
}