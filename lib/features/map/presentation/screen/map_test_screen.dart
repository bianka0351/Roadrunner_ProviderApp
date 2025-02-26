import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:roadrunner_provider_app/features/map/presentation/widget/map_widget.dart';

class MapTestScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MapTestScreenState();
  }
}

class _MapTestScreenState extends State<MapTestScreen> {
  final String runnerAddress =
      '6801 Hollywood Blvd, Los Angeles, CA 90028, USA';
  final String orderAddress = '800 N Alameda St, Los Angeles, CA 90012, USA';

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15.r),
        child: Container(
          height: 288.h,
          width: 408.w,
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(15.r),
          ),
          child: MapWidget.orderDetailLocation(
            orderDetailAddress: orderAddress,
            runnerAddress: runnerAddress,
          ),
        ),
      ),
    );
  }
}
