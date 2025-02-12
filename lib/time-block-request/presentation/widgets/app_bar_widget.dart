import 'package:flutter/material.dart';
import 'package:roadrunner_provider_app/core/constants/app_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onBackPressed;
  final VoidCallback onMenuPressed;

  const CustomAppBar({
    super.key,
    required this.onBackPressed,
    required this.onMenuPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Text(
        'Time Block Request',
        style: TextStyle(
          fontFamily: AppFonts.poppinsFontFamily,
          fontSize: 25.sp,
        //  fontWeight: AppFonts.,
        ),
      ),
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: onBackPressed,
      ),   
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}