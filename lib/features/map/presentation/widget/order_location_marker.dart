import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:roadrunner_provider_app/core/app_colors.dart';

class OrderLocationMarker extends StatelessWidget {
  final String index;

  const OrderLocationMarker({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Icon
        SvgPicture.asset(
          'assets/icons/location.svg',
          semanticsLabel: 'location pin icon',
          colorFilter:
              ColorFilter.mode(AppColors.tertiaryColor, BlendMode.srcIn),
        ),
        // Index
        Padding(
            padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 8.0.h),
            child: Text(
              index,
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: AppColors.tertiaryColor),
            ))
      ],
    );
  }
}
