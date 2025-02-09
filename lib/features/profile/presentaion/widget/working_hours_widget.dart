import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WorkingHoursWidget extends StatelessWidget {
  final Map<String, String> workingHours;

  const WorkingHoursWidget({Key? key, required this.workingHours})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: Colors.black),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              spreadRadius: 1,
            )
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Working Hours:',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 6.h,
          ),
          ...workingHours.entries.map((entry) => Padding(
                padding: EdgeInsets.symmetric(vertical: 4.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      entry.key,
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
                    Text(
                      entry.value,
                      style: const TextStyle(color: Colors.black54),
                    )
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
