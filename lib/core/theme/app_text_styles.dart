import 'package:flutter/material.dart';

/// An extension on `BuildContext` to provide convenient access to `TextStyle`
/// objects from the current theme's `TextTheme`.
///
/// This avoids repeatedly writing `Theme.of(context).textTheme` and allows
/// for cleaner and more readable widget code.
///
/// ---
/// ### Example:
/// ```dart
/// Column(
///   crossAxisAlignment: CrossAxisAlignment.start,
///   children: [
///     Text(
///       "Page Title",
///       // Easily access the 'titleLarge' text style
///       style: context.titleLarge?.copyWith(
///         fontWeight: FontWeight.bold,
///       ),
///     ),
///     Text(
///       "This is a paragraph of text.",
///       // Access 'bodyMedium'
///       style: context.bodyMedium,
///     ),
///   ],
/// )
/// ```
///{@category Core}
extension AppTextStyles on BuildContext {
  /// Returns the `TextTheme` from the nearest `Theme`.
  TextTheme get textStyles => Theme.of(this).textTheme;

  TextStyle? get displayLarge => textStyles.displayLarge;
  TextStyle? get displayMedium => textStyles.displayMedium;
  TextStyle? get displaySmall => textStyles.displaySmall;

  TextStyle? get headlineLarge => textStyles.headlineLarge;
  TextStyle? get headlineMedium => textStyles.headlineMedium;
  TextStyle? get headlineSmall => textStyles.headlineSmall;

  TextStyle? get titleLarge => textStyles.titleLarge;
  TextStyle? get titleMedium => textStyles.titleMedium;
  TextStyle? get titleSmall => textStyles.titleSmall;

  TextStyle? get bodyLarge => textStyles.bodyLarge;
  TextStyle? get bodyMedium => textStyles.bodyMedium;
  TextStyle? get bodySmall => textStyles.bodySmall;

  TextStyle? get labelLarge => textStyles.labelLarge;
  TextStyle? get labelMedium => textStyles.labelMedium;
  TextStyle? get labelSmall => textStyles.labelSmall;
}
