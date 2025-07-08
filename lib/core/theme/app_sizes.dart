import 'package:flutter/material.dart';

/// A utility class that holds predefined sizes for UI elements.
///
/// This class centralizes dimensions like border radii, icon sizes, and
/// component heights to ensure consistency across the application.
///
/// ---
/// ### Example:
/// ```dart
/// Container(
///   height: AppSizes.buttonHeight,
///   decoration: BoxDecoration(
///     color: Colors.blue,
///     borderRadius: AppSizes.circularMd, // 8.0 radius
///   ),
///   child: Icon(
///     Icons.favorite,
///     size: AppSizes.iconSizeMd, // 24.0 size
///   ),
/// )
/// ```
/// {@category Core}
class AppSizes {
  AppSizes._();
  // Raw radius values
  static const double radiusSm = 4.0;
  static const double radiusMd = 8.0;
  static const double radiusLg = 16.0;
  static const double radiusXl = 24.0;
  static const double radiusFull = 1000.0;

  // Pre-built BorderRadius objects for convenience
  static final BorderRadius circularSm = BorderRadius.circular(radiusSm);
  static final BorderRadius circularMd = BorderRadius.circular(radiusMd);
  static final BorderRadius circularLg = BorderRadius.circular(radiusLg);
  static final BorderRadius circularXl = BorderRadius.circular(radiusXl);
  static final BorderRadius circularFull = BorderRadius.circular(radiusFull);

  // Consistent icon sizes
  static const double iconSizeSm = 16.0;
  static const double iconSizeMd = 24.0;
  static const double iconSizeLg = 32.0;

  // Standard component heights
  static const double buttonHeight = 48.0;
  static const double inputHeight = 56.0;
  static const double appBarHeight = 56.0;
}
