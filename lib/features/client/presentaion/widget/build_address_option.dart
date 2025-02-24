import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget buildAddressOption({
  required IconData icon,
  required String label,
  required String subLabel,
  required VoidCallback onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Icon(icon, size: 30.h, color: Colors.black),
         SizedBox(width: 5.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            if (subLabel.isNotEmpty) ...[
              Text(
                subLabel,
                style: TextStyle(fontSize: 10, color: Colors.black54),
              ),
            ],
          ],
        ),
      ],
    ),
  );
}
