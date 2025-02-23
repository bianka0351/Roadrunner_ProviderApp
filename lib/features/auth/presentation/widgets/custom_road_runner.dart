import 'package:flutter/material.dart';

class CustomRoadRunner extends StatelessWidget {
  const CustomRoadRunner(
      {super.key,
      required this.color,
      required this.text,
      required this.fontSize});
  final Color color;
  final String text;
  final double fontSize;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Text(
          text,
          style: TextStyle(
            fontSize: fontSize,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w700,
            foreground: Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = 1
              ..color = color,
          ),
        ),
        Text(
          text,
          style: TextStyle(
            fontSize: fontSize,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w700,
            color: color,
          ),
        ),
      ],
    );
  }
}
