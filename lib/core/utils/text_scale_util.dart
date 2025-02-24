import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextScaleUtil {
  /// Wraps a widget with a constant text scale factor.
  static Widget constantTextScale({required Widget child}) {
    // Ensure the status bar is visible
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

    return SafeArea(
      child: MediaQuery(
        data: MediaQueryData(
          textScaler:
              const TextScaler.linear(1.0), // Set text scale factor to 1.0
        ),
        child: child,
      ),
    );
  }
}
