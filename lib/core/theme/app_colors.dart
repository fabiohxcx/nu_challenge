import 'package:flutter/material.dart';

/// Defines the color palette for the application.
///
/// This class contains static `Color` constants for primary, neutral,
/// and functional colors.
class AppColors {
  AppColors._();

  // --- Primary and Secondary Colors ---
  static const Color primary = Color(0xFF6A00F4);
  static const Color primaryDark = Color(0xFF5000B5);
  static const Color secondary = Color(0xFF00F4C8);

  // --- Neutral Shades (Gray/Black/White) ---
  static const Color neutral900 = Color(0xFF121212); // Almost black
  static const Color neutral800 = Color(0xFF222222);
  static const Color neutral700 = Color(0xFF333333);
  static const Color neutral200 = Color(0xFFE0E0E0);
  static const Color neutral100 = Color(0xFFF5F5F5); // Almost white
  static const Color neutral0 = Color(0xFFFFFFFF); // Pure white

  // --- Functional Colors ---
  static const Color error = Color(0xFFD32F2F);
  static const Color success = Color(0xFF388E3C);
  static const Color warning = Color(0xFFFFA000);
}

/// Provides easy access to the `ColorScheme` from the current theme.
///
/// This extension on `BuildContext` allows you to access theme-aware colors
/// like `primary`, `onPrimary`, `surface`, etc., without boilerplate code.
///
/// ---
/// ### Example:
/// ```dart
/// // Accessing a fixed color from AppColors
/// Icon(Icons.check_circle, color: AppColors.success)
///
/// // Accessing a theme-aware color via the context extension
/// Container(
///   color: context.colors.primary,
///   child: Text(
///     'Hello World',
///     style: TextStyle(color: context.colors.onPrimary),
///   ),
/// )
/// ```
/// {@category Core}
extension AppThemeColors on BuildContext {
  /// Returns the `ColorScheme` from the nearest `Theme`.
  ColorScheme get colors => Theme.of(this).colorScheme;
}
