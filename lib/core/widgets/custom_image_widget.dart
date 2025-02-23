import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/app_colors.dart';

class ProfileAvatar extends StatelessWidget {
  final double size;
  final String? imageUrl; // Nullable for network images
  final File? imageFile; // Nullable for local images
  final Color borderColor;
  final double borderWidth;
  final String defaultAssetImage;

  const ProfileAvatar({
    super.key,
    required this.size,
    required this.imageUrl,
    this.imageFile,
    this.borderColor = AppColors.primaryColor,
    this.borderWidth = 2,
    this.defaultAssetImage = 'assets/images/default_avatar.png',
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: size.r, // Outer circle size
      backgroundColor: borderColor, // Border color
      child: CircleAvatar(
        radius: (size - borderWidth).r, // Inner circle (adjusted for stroke)
        backgroundImage: _getImageProvider(), // Dynamically choose image source
      ),
    );
  }

  ImageProvider _getImageProvider() {
    if (imageFile != null) {
      return FileImage(imageFile!); // Load from local file
    } else if (imageUrl != null && imageUrl!.isNotEmpty) {
      return NetworkImage(imageUrl!); // Load from URL
    } else {
      return AssetImage(defaultAssetImage);
    }
  }
}
