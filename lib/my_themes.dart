import 'package:flutter/material.dart';
import 'package:mushaf_mistake_marker/enums.dart';

class MyThemes {
  static ThemeData lightTheme(AppTheme appTheme) => appTheme == .monochrome
      ? monochromeLight
      : ThemeData(
          colorScheme: .fromSeed(
            seedColor: appTheme.lightSeed,
            brightness: .light,
          ),
          brightness: .light,
          useMaterial3: true,
        );

  static ThemeData darkTheme(AppTheme appTheme) => appTheme == .monochrome
      ? monochromeDark
      : ThemeData(
          colorScheme: .fromSeed(
            seedColor: appTheme.darkSeed,
            brightness: .dark,
          ),
          brightness: .dark,
          useMaterial3: true,
        );

  static final monochromeLight = ThemeData(
    useMaterial3: true,
    brightness: .light,
    colorScheme: const ColorScheme(
      brightness: .light,
      primary: Color(0xFF3A3A3C),
      onPrimary: Color(0xFFFFFFFF),
      primaryContainer: Color(0xFFE5E5EA),
      onPrimaryContainer: Color(0xFF1C1C1E),
      secondary: Color(0xFF636366),
      onSecondary: Color(0xFFFFFFFF),
      secondaryContainer: Color(0xFFE5E5EA),
      onSecondaryContainer: Color(0xFF1C1C1E),
      tertiary: Color(0xFF8E8E93),
      onTertiary: Color(0xFFFFFFFF),
      tertiaryContainer: Color(0xFFF2F2F7),
      onTertiaryContainer: Color(0xFF3A3A3C),
      error: Color(0xFFFF3B30),
      onError: Color(0xFFFFFFFF),
      errorContainer: Color(0xFFFFDAD6),
      onErrorContainer: Color(0xFF410002),
      surface: Color(0xFFFFFFFF),
      onSurface: Color(0xFF000000),
      surfaceContainerHighest: Color(0xFFE5E5EA),
      onSurfaceVariant: Color(0xFF3C3C43),
      outline: Color(0xFFC6C6C8),
      outlineVariant: Color(0xFFE5E5EA),
      shadow: Color(0xFF000000),
      scrim: Color(0xFF000000),
      inverseSurface: Color(0xFF1C1C1E),
      onInverseSurface: Color(0xFFFFFFFF),
      inversePrimary: Color(0xFF8E8E93),
    ),
    scaffoldBackgroundColor: const Color(0xFFF2F2F7),
  );

  static final monochromeDark = ThemeData(
    useMaterial3: true,
    brightness: .dark,
    colorScheme: const ColorScheme(
      brightness: .dark,
      primary: Color(0xFFAEAEB2),
      onPrimary: Color(0xFF000000),
      primaryContainer: Color(0xFF2C2C2E),
      onPrimaryContainer: Color(0xFFE5E5EA),
      secondary: Color(0xFF8E8E93),
      onSecondary: Color(0xFF000000),
      secondaryContainer: Color(0xFF2C2C2E),
      onSecondaryContainer: Color(0xFFE5E5EA),
      tertiary: Color(0xFF636366),
      onTertiary: Color(0xFFFFFFFF),
      tertiaryContainer: Color(0xFF1C1C1E),
      onTertiaryContainer: Color(0xFFAEAEB2),
      error: Color(0xFFFF453A),
      onError: Color(0xFFFFFFFF),
      errorContainer: Color(0xFF410002),
      onErrorContainer: Color(0xFFFFDAD6),
      surface: Color(0xFF1C1C1E),
      onSurface: Color(0xFFFFFFFF),
      surfaceContainerHighest: Color(0xFF2C2C2E),
      onSurfaceVariant: Color(0xFFAEAEB2),
      outline: Color(0xFF38383A),
      outlineVariant: Color(0xFF2C2C2E),
      shadow: Color(0xFF000000),
      scrim: Color(0xFF000000),
      inverseSurface: Color(0xFFE5E5EA),
      onInverseSurface: Color(0xFF1C1C1E),
      inversePrimary: Color(0xFF636366),
    ),
    scaffoldBackgroundColor: const Color(0xFF000000),
  );
}
