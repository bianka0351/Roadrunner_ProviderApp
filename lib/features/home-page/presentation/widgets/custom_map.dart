import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:roadrunner_provider_app/core/constants/app_colors.dart';
import 'package:roadrunner_provider_app/core/constants/app_fonts.dart';
import 'package:roadrunner_provider_app/features/map/presentation/widget/map_widget2.dart';

// ignore: must_be_immutable
class CustomMap extends StatefulWidget {
  CustomMap(
      {super.key,
      required this.locations,
      required this.onRouteDetailsUpdated});
  List<String> locations;
  final void Function(List<Map<String, dynamic>>)? onRouteDetailsUpdated;

  @override
  State<CustomMap> createState() => _CustomMapState();
}

class _CustomMapState extends State<CustomMap> {
  final ValueNotifier<bool> _isShowRouteMap = ValueNotifier(false);
  List<Map<String, dynamic>> routeDetails = [];

  late final MapWidget mapWidget;

  @override
  void initState() {
    super.initState();
    mapWidget = MapWidget.ordersLocations(
      ordersLocations: widget.locations,
      onRouteDetailsUpdated: widget.onRouteDetailsUpdated,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: _isShowRouteMap,
      builder: (context, isShowRouteMap, child) {
        return Column(
          children: [
            TextButton(
              onPressed: () {
                _isShowRouteMap.value = !_isShowRouteMap.value;
              },
              child: Text(
                isShowRouteMap ? "Hide Map" : "Show Map",
                style: AppFonts.poppinsRegular(
                  fontSize: 16.sp,
                  color: isShowRouteMap
                      ? AppColors.tritiaryColor
                      : AppColors.primaryColor,
                ),
              ),
            ),
            Offstage(
              offstage: !isShowRouteMap,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15.r),
                child: Container(
                  height: 288.h,
                  width: 408.w,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(15.r),
                  ),
                  child: mapWidget,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
