import 'package:flutter/material.dart';

class BuildMapSection extends StatelessWidget {
  const BuildMapSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 288,
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Center(child: Icon(Icons.map, size: 50, color: Colors.white)),
    );
  }
}
