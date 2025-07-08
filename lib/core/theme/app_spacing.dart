/// A utility class for predefined spacing values based on an 8.0 base unit.
///
/// Using these constants for padding, margins, and `SizedBox` dimensions
/// helps maintain a consistent visual rhythm in the UI.
///
/// ---
/// ### Example:
/// ```dart
/// Padding(
///   padding: const EdgeInsets.symmetric(
///     horizontal: AppSpacing.md, // 16.0
///     vertical: AppSpacing.sm,   // 8.0
///   ),
///   child: Column(
///     children: [
///       const Text('Title'),
///       const SizedBox(height: AppSpacing.lg), // 24.0
///       const Text('Subtitle'),
///     ],
///   ),
/// )
/// ```
/// {@category Core}
class AppSpacing {
  AppSpacing._();

  /// The base unit for all spacing values (8.0).
  static const double _base = 8.0;

  /// 2.0
  static const double xxs = _base * 0.25;

  /// 4.0
  static const double xs = _base * 0.5;

  /// 8.0
  static const double sm = _base * 1.0;

  /// 12.0
  static const double smd = _base * 1.5;

  /// 16.0
  static const double md = _base * 2.0;

  /// 24.0
  static const double lg = _base * 3.0;

  /// 32.0
  static const double xl = _base * 4.0;

  /// 48.0
  static const double xxl = _base * 6.0;

  /// 64.0
  static const double xxxl = _base * 8.0;
}
