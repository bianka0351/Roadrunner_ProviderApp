import 'package:flutter/material.dart';

class TextScaleUtil {
  /// Wraps a widget with a constant text scale factor.
  static Widget constantTextScale({required Widget child}) {
    return MediaQuery(
      data: MediaQueryData(
        textScaler: const TextScaler.linear(1.0), // Set text scale factor to 1.0
      ),
      child: child,
    );
  }
}