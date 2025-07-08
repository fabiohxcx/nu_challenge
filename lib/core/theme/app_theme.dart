import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

/// A utility class responsible for defining the application's visual theme.
///
/// It centralizes the configuration for colors, typography, and component
/// styles, ensuring a consistent look and feel across the app.
///
/// ---
/// ### Example of Usage:
///
/// In your main `MaterialApp` widget, assign the `lightTheme` to the `theme` property:
///
/// ```dart
/// MaterialApp(
///   title: 'My App',
///   theme: AppTheme.lightTheme, // Use the predefined theme
///   home: const HomePage(),
/// );
/// ```
/// {@category Core}
class AppTheme {
  AppTheme._();

  static const String _primaryFont = 'Poppins';

  /// A basic theme configuration using the Poppins font.
  ///
  /// This is a simpler theme, primarily setting the `TextTheme` and `AppBarTheme`.
  static ThemeData get theme {
    final ThemeData base = ThemeData.light();
    final textTheme = GoogleFonts.poppinsTextTheme(base.textTheme);

    return base.copyWith(
      textTheme: textTheme,
      appBarTheme: const AppBarTheme(
        titleTextStyle: TextStyle(fontFamily: _primaryFont, fontWeight: FontWeight.w600, fontSize: 20),
      ),
    );
  }

  /// The main light theme for the application.
  ///
  /// This theme is fully configured with a custom `ColorScheme`, `TextTheme`,
  /// `scaffoldBackgroundColor`, and `AppBarTheme`, all using the
  /// predefined values from `AppColors`.
  static ThemeData get lightTheme {
    final base = ThemeData.light();

    return base.copyWith(
      textTheme: _buildTextTheme(base.textTheme, AppColors.neutral900, AppColors.neutral700),
      // The ColorScheme defines the set of colors for the theme.
      colorScheme: const ColorScheme(
        brightness: Brightness.light,
        primary: AppColors.primary,
        onPrimary: AppColors.neutral0, // Text/icon color on top of primary color
        secondary: AppColors.secondary,
        onSecondary: AppColors.neutral900,
        error: AppColors.error,
        onError: AppColors.neutral0,
        surface: AppColors.neutral0, // Background color for Cards, Dialogs, etc.
        onSurface: AppColors.neutral900, // Text color on top of surface color
      ),
      scaffoldBackgroundColor: AppColors.neutral100,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.neutral0, // Title and icon color in the AppBar
        titleTextStyle: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: AppColors.neutral0,
        ),
      ),
    );
  }

  /// A private helper to build and color a `TextTheme` using the Poppins font.
  ///
  /// It takes a base `TextTheme` and applies specific colors for display
  /// styles (like headlines) and body styles (like paragraphs).
  static TextTheme _buildTextTheme(TextTheme base, Color displayColor, Color bodyColor) {
    final poppinsTheme = GoogleFonts.poppinsTextTheme(base);

    // Apply custom colors to the Poppins text styles
    return poppinsTheme.copyWith(
      displayLarge: poppinsTheme.displayLarge?.copyWith(color: displayColor),
      displayMedium: poppinsTheme.displayMedium?.copyWith(color: displayColor),
      displaySmall: poppinsTheme.displaySmall?.copyWith(color: displayColor),
      headlineLarge: poppinsTheme.headlineLarge?.copyWith(color: displayColor),
      headlineMedium: poppinsTheme.headlineMedium?.copyWith(color: displayColor),
      headlineSmall: poppinsTheme.headlineSmall?.copyWith(color: displayColor),
      titleLarge: poppinsTheme.titleLarge?.copyWith(color: bodyColor),
      titleMedium: poppinsTheme.titleMedium?.copyWith(color: bodyColor),
      titleSmall: poppinsTheme.titleSmall?.copyWith(color: bodyColor),
      bodyLarge: poppinsTheme.bodyLarge?.copyWith(color: bodyColor),
      bodyMedium: poppinsTheme.bodyMedium?.copyWith(color: bodyColor),
      bodySmall: poppinsTheme.bodySmall?.copyWith(color: bodyColor),
      labelLarge: poppinsTheme.labelLarge?.copyWith(color: bodyColor),
      labelMedium: poppinsTheme.labelMedium?.copyWith(color: bodyColor),
      labelSmall: poppinsTheme.labelSmall?.copyWith(color: bodyColor),
    );
  }
}
