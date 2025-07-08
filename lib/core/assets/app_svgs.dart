/// A utility class that holds constants for SVG asset paths.
///
/// This class centralizes all SVG asset strings, preventing typos and making it
/// easy to manage and reuse assets throughout the application. The private
/// constructor `_()` prevents the class from being instantiated.
///
/// ### Example of Usage:
///
/// To display an SVG, you can use the `flutter_svg` package and pass the
/// constant directly to the `SvgPicture.asset` widget.
///
/// ```dart
/// SvgPicture.asset(
///   AppSvgs.openLink,
///   semanticsLabel: 'Open Link Icon',
///   colorFilter: ColorFilter.mode(Colors.blue, BlendMode.srcIn),
///   width: 24,
/// )
/// ```
///
/// {@category Core}
class AppSvgs {
  AppSvgs._();

  static const String _basePath = 'assets/svgs';

  /// The path for the 'open link' icon.
  static const String openLink = '$_basePath/open.svg';
}
