import 'package:flutter/material.dart';
import '../constants/jarvis_colors.dart';

enum JarvisStatus {
  idle,
  listening,
  thinking,
  speaking,
  error,
}

extension JarvisStatusExtension on JarvisStatus {
  String get label {
    switch (this) {
      case JarvisStatus.idle:
        return 'READY';
      case JarvisStatus.listening:
        return 'LISTENING';
      case JarvisStatus.thinking:
        return 'THINKING';
      case JarvisStatus.speaking:
        return 'SPEAKING';
      case JarvisStatus.error:
        return 'ERROR';
    }
  }

  String get description {
    switch (this) {
      case JarvisStatus.idle:
        return 'Standing by for instructions, sir.';
      case JarvisStatus.listening:
        return 'Capturing voice input...';
      case JarvisStatus.thinking:
        return 'Neural network evaluating response...';
      case JarvisStatus.speaking:
        return 'Transmitting audio response...';
      case JarvisStatus.error:
        return 'Subsystem encountered an anomaly.';
    }
  }

  Color get color {
    switch (this) {
      case JarvisStatus.idle:
        return JarvisColors.cyan;
      case JarvisStatus.listening:
        return JarvisColors.green;
      case JarvisStatus.thinking:
        return JarvisColors.amber;
      case JarvisStatus.speaking:
        return JarvisColors.electricBlue;
      case JarvisStatus.error:
        return JarvisColors.red;
    }
  }
}
