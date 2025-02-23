// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:roadrunner_provider_app/features/client/presentaion/widget/custom_text_field.dart';
// import 'dart:io';
// import '../../../menu/presentation/menu_widget.dart';
// import '../widget/client_profile_picture_widget.dart';
// import '../widget/create_button_widget.dart';

// class CreateClientScreen extends StatefulWidget {
//   const CreateClientScreen({super.key});

//   @override
//   // ignore: library_private_types_in_public_api
//   _CreateClientScreenState createState() => _CreateClientScreenState();
// }

// class _CreateClientScreenState extends State<CreateClientScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final _firstNameController = TextEditingController();
//   final _lastNameController = TextEditingController();
//   final _emailController = TextEditingController();
//   final _phoneNumberController = TextEditingController();
//   final _paymentMethodController = TextEditingController();
//   final _addressController = TextEditingController();

//   // Use ValueNotifier for the profile image
//   final ValueNotifier<File?> _profileImageNotifier = ValueNotifier(null);

//   // Use ValueNotifier to track if all fields are filled
//   final ValueNotifier<bool> _allFieldsFilledNotifier = ValueNotifier(false);

//   Future<void> _pickImage() async {
//     final picker = ImagePicker();
//     final pickedFile = await picker.pickImage(source: ImageSource.gallery);

//     if (pickedFile != null) {
//       // Update the ValueNotifier with the new image
//       _profileImageNotifier.value = File(pickedFile.path);
//     }
//   }

//   void _checkIfAllFieldsAreFilled() {
//     final allFieldsFilled = _firstNameController.text.isNotEmpty &&
//         _lastNameController.text.isNotEmpty &&
//         _emailController.text.isNotEmpty &&
//         _phoneNumberController.text.isNotEmpty &&
//         _paymentMethodController.text.isNotEmpty &&
//         _addressController.text.isNotEmpty;

//     // Update the ValueNotifier
//     _allFieldsFilledNotifier.value = allFieldsFilled;
//   }

//   @override
//   void initState() {
//     super.initState();

//     // Add listeners to all text controllers
//     _firstNameController.addListener(_checkIfAllFieldsAreFilled);
//     _lastNameController.addListener(_checkIfAllFieldsAreFilled);
//     _emailController.addListener(_checkIfAllFieldsAreFilled);
//     _phoneNumberController.addListener(_checkIfAllFieldsAreFilled);
//     _paymentMethodController.addListener(_checkIfAllFieldsAreFilled);
//     _addressController.addListener(_checkIfAllFieldsAreFilled);
//   }

//   @override
//   void dispose() {
//     // Dispose the ValueNotifiers and text controllers
//     _profileImageNotifier.dispose();
//     _allFieldsFilledNotifier.dispose();
//     _firstNameController.dispose();
//     _lastNameController.dispose();
//     _emailController.dispose();
//     _phoneNumberController.dispose();
//     _paymentMethodController.dispose();
//     _addressController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//           centerTitle: true,

//         title: Text(
//           'Client Info',
//           style: TextStyle(
//             fontSize: 24.sp,
//             fontWeight: FontWeight.w600,
//             color: Colors.black,
//             fontFamily: 'Poppins',
//           ),
//         ),
//        actions: [
//   Builder(
//     builder: (context) => IconButton(
//       icon: Icon(Icons.menu),
//       onPressed: () {
//         Scaffold.of(context).openEndDrawer();
//       },
//     ),
//   ),
// ],
//       ),
//       endDrawer: MenuWidget(
//         onItemSelected: (route) {
//           Navigator.pushNamed(context, route);
//         },
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: EdgeInsets.symmetric(horizontal: 24.w),
//           child: Form(
//             key: _formKey,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // SizedBox(height: 56.h),
//                 // Center(
//                 //   child: Text(
//                 //     'Client Info',
//                 //     style: TextStyle(
//                 //       fontSize: 32.sp,
//                 //       fontWeight: FontWeight.w600,
//                 //       color: Colors.black,
//                 //       fontFamily: 'Poppins',
//                 //     ),
//                 //   ),
//                 // ),
//                 SizedBox(height: 40.h),
//                 ClientProfilePictureWidget(
//                   profileImageNotifier: _profileImageNotifier,
//                   onTap: _pickImage,
//                 ),
//                 SizedBox(height: 40.h),
//                 CustomTextField(
//                   controller: _firstNameController,
//                   label: 'First Name',
//                   hint: 'Enter First Name',
//                 ),
//                 SizedBox(height: 16.h),
//                 CustomTextField(
//                   controller: _lastNameController,
//                   label: 'Last Name',
//                   hint: 'Enter Last Name',
//                 ),
//                 SizedBox(height: 16.h),
//                 CustomTextField(
//                   controller: _emailController,
//                   label: 'Email',
//                   hint: 'Enter Email',
//                   keyboardType: TextInputType.emailAddress,
//                 ),
//                 SizedBox(height: 16.h),
//                 CustomTextField(
//                   controller: _phoneNumberController,
//                   label: 'Phone Number',
//                   hint: 'Enter Phone Number',
//                   keyboardType: TextInputType.phone,
//                 ),
//                 SizedBox(height: 16.h),
//                 //             AddressTextField(
//                 //               controller: _addressController,
//                 //               onAddressSelected: (Address ) async*{
//                 //                  final address = await showDialog<Address>(
//                 //   context: context,
//                 //   builder: (context) => AddressPopup(
//                 //     onAddressSelected: (address) {
//                 //       // Handle the selected address
//                 //       print('Selected Address: ${address.streetAddress}');
//                 //     },
//                 //     savedAddresses: [
//                 //       Address,
//                 //       Address,
//                 //     ],
//                 //   ),
//                 // );

//                 // if (address != null) {
//                 //   // Do something with the selected address
//                 // }

//                 //                },
//                 //             ),
//                 SizedBox(height: 16.h),
//                 CustomTextField(
//                   controller: _paymentMethodController,
//                   label: 'Payment Method',
//                   hint: 'Enter Payment Method',
//                 ),
//                 SizedBox(height: 40.h),
//                 CreateButtonWidget(
//                   formKey: _formKey,
//                   allFieldsFilledNotifier: _allFieldsFilledNotifier,
//                   firstNameController: _firstNameController,
//                   lastNameController: _lastNameController,
//                   emailController: _emailController,
//                   phoneNumberController: _phoneNumberController,
//                   paymentMethodController: _paymentMethodController,
//                 ),
//                 SizedBox(height: 40.h),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:roadrunner_provider_app/core/shared_widgets/custom_button.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../menu/presentation/menu_widget.dart';
import '../../data/model/client.dart';
import '../widget/address_text_field.dart';
import '../widget/client_profile_picture_widget.dart';
import '../widget/create_button_widget.dart';
import '../widget/custom_text_field.dart';

class CreateClientScreen extends StatefulWidget {
  const CreateClientScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CreateClientScreenState createState() => _CreateClientScreenState();
}

class _CreateClientScreenState extends State<CreateClientScreen> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _paymentMethodController = TextEditingController();
  final _addressController = TextEditingController();

  final ValueNotifier<File?> _profileImageNotifier = ValueNotifier(null);
  final ValueNotifier<bool> _allFieldsFilledNotifier = ValueNotifier(false);

  // List of saved addresses
  final List<Address> savedAddresses = [
    Address(
      streetAddress: '123 Main St',
      city: 'New York',
      stateCode: '10',
      zipCode: '10001',
      countryCode: 'US',
    ),
    Address(
      streetAddress: '456 Elm St',
      city: 'Los Angeles',
      stateCode: '1',
      zipCode: '90001',
      countryCode: 'US',
    ),
  ];

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      _profileImageNotifier.value = File(pickedFile.path);
    }
  }

  void _checkIfAllFieldsAreFilled() {
    final allFieldsFilled = _firstNameController.text.isNotEmpty &&
        _lastNameController.text.isNotEmpty &&
        _emailController.text.isNotEmpty &&
        _phoneNumberController.text.isNotEmpty &&
        _paymentMethodController.text.isNotEmpty &&
        _addressController.text.isNotEmpty;

    _allFieldsFilledNotifier.value = allFieldsFilled;
  }

  @override
  void initState() {
    super.initState();
    _firstNameController.addListener(_checkIfAllFieldsAreFilled);
    _lastNameController.addListener(_checkIfAllFieldsAreFilled);
    _emailController.addListener(_checkIfAllFieldsAreFilled);
    _phoneNumberController.addListener(_checkIfAllFieldsAreFilled);
    _paymentMethodController.addListener(_checkIfAllFieldsAreFilled);
    _addressController.addListener(_checkIfAllFieldsAreFilled);
  }

  @override
  void dispose() {
    _profileImageNotifier.dispose();
    _allFieldsFilledNotifier.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneNumberController.dispose();
    _paymentMethodController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              // Open the endDrawer when the leading icon is tapped
              Scaffold.of(context).openDrawer();
            },
          ),
        ),

        //leading: IconButton(

        // icon: Icon(Icons.arrow_back),
        // onPressed: () => Navigator.pop(context),
        //),
        centerTitle: true,
        title: Text(
          'Client Info',
          style: TextStyle(
            fontSize: 24.sp,
            fontWeight: FontWeight.w600,
            color: Colors.black,
            fontFamily: 'Poppins',
          ),
        ),
        // actions: [
        //   Builder(
        //     builder: (context) => IconButton(
        //       icon: Icon(Icons.menu),
        //       onPressed: () {
        //         Scaffold.of(context).openEndDrawer();
        //       },
        //     ),
        //   ),
        // ],
      ),
      drawer: MenuWidget(
        onItemSelected: (route) {
          Navigator.pushNamed(context, route);
        },
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // SizedBox(height: 56.h),
                // Center(
                //   child: Text(
                //     'Client Info',
                //     style: TextStyle(
                //       fontSize: 32.sp,
                //       fontWeight: FontWeight.w600,
                //       color: Colors.black,
                //       fontFamily: 'Poppins',
                //     ),
                //   ),
                // ),
                SizedBox(height: 40.h),
                ClientProfilePictureWidget(
                  profileImageNotifier: _profileImageNotifier,
                  onTap: _pickImage,
                ),
                SizedBox(height: 40.h),
                CustomTextField(
                  controller: _firstNameController,
                  label: 'First Name',
                  hint: 'Enter First Name',
                ),
                SizedBox(height: 16.h),
                CustomTextField(
                  controller: _lastNameController,
                  label: 'Last Name',
                  hint: 'Enter Last Name',
                ),
                SizedBox(height: 16.h),
                CustomTextField(
                  controller: _emailController,
                  label: 'Email',
                  hint: 'Enter Email',
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(height: 16.h),
                CustomTextField(
                  controller: _phoneNumberController,
                  label: 'Phone Number',
                  hint: 'Enter Phone Number',
                  keyboardType: TextInputType.phone,
                ),
                SizedBox(height: 16.h),
                // AddressTextField(
                //   controller: _addressController,
                //   onAddressSelected: (Address address) {
                //     // Update the address field with the selected address
                //     _addressController.text = address.toString();
                //   },
                //   savedAddresses: savedAddresses, // Pass the saved addresses
                // ),
                CustomButton(
                  text: 'Payment Method ',
                  onPressed: () {},
                  buttonColor: AppColors.secondaryColor,
                  textColor: Colors.white,
                  textSize: 14,
                  buttonWidth: 180,
                  buttonHeight: 50,
                ),
                SizedBox(height: 16.h),
                CustomButton(
                  text: 'Manage Addresses ',
                  onPressed: () {},
                  buttonColor: AppColors.secondaryColor,
                  textColor: Colors.white,
                  textSize: 14,
                  buttonWidth: 200,
                  buttonHeight: 50,
                ),

                SizedBox(height: 40.h),
                CreateButtonWidget(
                  formKey: _formKey,
                  allFieldsFilledNotifier: _allFieldsFilledNotifier,
                  firstNameController: _firstNameController,
                  lastNameController: _lastNameController,
                  emailController: _emailController,
                  phoneNumberController: _phoneNumberController,
                  paymentMethodController: _paymentMethodController,
                ),
                SizedBox(height: 40.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
