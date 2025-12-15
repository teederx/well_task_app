import 'package:flutter/services.dart';

/// Centralized haptic feedback service for consistent tactile responses
class HapticService {
  // Prevent instantiation
  HapticService._();

  /// Light impact feedback - for subtle interactions
  /// Use for: button taps, switches, minor UI changes
  static Future<void> lightImpact() async {
    await HapticFeedback.lightImpact();
  }

  /// Medium impact feedback - for moderate interactions
  /// Use for: task completion, deletion confirmations, significant state changes
  static Future<void> mediumImpact() async {
    await HapticFeedback.mediumImpact();
  }

  /// Heavy impact feedback - for major interactions
  /// Use for: errors, warnings, critical actions
  static Future<void> heavyImpact() async {
    await HapticFeedback.heavyImpact();
  }

  /// Selection feedback - for picker/scrolling interactions
  /// Use for: list scrolling, picker changes, swipe gestures
  static Future<void> selectionClick() async {
    await HapticFeedback.selectionClick();
  }

  /// Vibrate feedback - device vibration
  /// Use for: alerts, notifications
  static Future<void> vibrate() async {
    await HapticFeedback.vibrate();
  }

  /// Success feedback - positive action completed
  /// Combines medium impact with a short delay for success feeling
  static Future<void> success() async {
    await HapticFeedback.lightImpact();
    await Future.delayed(const Duration(milliseconds: 50));
    await HapticFeedback.lightImpact();
  }

  /// Error feedback - negative action or error occurred
  /// Uses heavy impact for emphasis
  static Future<void> error() async {
    await HapticFeedback.heavyImpact();
  }

  /// Warning feedback - caution needed
  static Future<void> warning() async {
    await HapticFeedback.mediumImpact();
  }
}


