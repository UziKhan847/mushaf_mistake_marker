import 'package:flutter/material.dart';
import 'package:mushaf_mistake_marker/enums.dart';

class MyThemes {
  static ThemeData lightTheme(AppTheme appTheme) => appTheme == .ios
      ? iosLight
      : ThemeData(
          colorScheme: .fromSeed(
            seedColor: appTheme.lightSeed,
            brightness: .light,
          ),
          brightness: .light,
          useMaterial3: true,
        );

  static ThemeData darkTheme(AppTheme appTheme) => appTheme == .ios
      ? iosDark
      : ThemeData(
          colorScheme: .fromSeed(
            seedColor: appTheme.darkSeed,
            brightness: .dark,
          ),
          brightness: .dark,
          useMaterial3: true,
        );

  static final iosLight = ThemeData(
    useMaterial3: true,
    brightness: .light,
    colorScheme: const ColorScheme(
      brightness: .light,
      primary: Color(0xFF1C5288),
      onPrimary: Color(0xFFFFFFFF),
      primaryContainer: Color(0xFFD6E8F9),
      onPrimaryContainer: Color(0xFF003260),
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
      inversePrimary: Color(0xFF3B8FEA),
    ),
    scaffoldBackgroundColor: const Color(0xFFF2F2F7),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFFF2F2F7),
      foregroundColor: Color(0xFF2B7FD4),
      elevation: 0,
      scrolledUnderElevation: 0.5,
      titleTextStyle: TextStyle(
        color: Color(0xFF000000),
        fontSize: 17,
        fontWeight: .w600,
        letterSpacing: -0.4,
      ),
    ),
    listTileTheme: const ListTileThemeData(
      tileColor: Color(0xFFFFFFFF),
      shape: RoundedRectangleBorder(borderRadius: .all(.circular(10))),
    ),
    cardTheme: const CardThemeData(
      color: Color(0xFFFFFFFF),
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: .all(.circular(10))),
      margin: .symmetric(horizontal: 16, vertical: 4),
    ),
    dividerTheme: const DividerThemeData(
      color: Color(0xFFC6C6C8),
      thickness: 0.5,
      indent: 16,
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontSize: 34,
        fontWeight: .w700,
        letterSpacing: -0.5,
      ),
      titleLarge: TextStyle(
        fontSize: 22,
        fontWeight: .w700,
        letterSpacing: -0.4,
      ),
      titleMedium: TextStyle(
        fontSize: 17,
        fontWeight: .w600,
        letterSpacing: -0.4,
      ),
      bodyLarge: TextStyle(
        fontSize: 17,
        fontWeight: .w400,
        letterSpacing: -0.4,
      ),
      bodyMedium: TextStyle(
        fontSize: 15,
        fontWeight: .w400,
        letterSpacing: -0.2,
      ),
      labelLarge: TextStyle(
        fontSize: 17,
        fontWeight: .w400,
        letterSpacing: -0.4,
      ),
      labelSmall: TextStyle(
        fontSize: 11,
        fontWeight: .w400,
        letterSpacing: 0.06,
      ),
    ),
  );

  static final iosDark = ThemeData(
    useMaterial3: true,
    brightness: .dark,
    colorScheme: const ColorScheme(
      brightness: .dark,
      primary: Color(0xFF4896EA),
      onPrimary: Color(0xFFFFFFFF),
      primaryContainer: Color(0xFF003260),
      onPrimaryContainer: Color(0xFFD6E8F9),
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
      inversePrimary: Color(0xFF2B7FD4),
    ),
    scaffoldBackgroundColor: const Color(0xFF000000),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF1C1C1E),
      foregroundColor: Color(0xFF3B8FEA),
      elevation: 0,
      scrolledUnderElevation: 0.5,
      titleTextStyle: TextStyle(
        color: Color(0xFFFFFFFF),
        fontSize: 17,
        fontWeight: .w600,
        letterSpacing: -0.4,
      ),
    ),
    listTileTheme: const ListTileThemeData(
      tileColor: Color(0xFF1C1C1E),
      shape: RoundedRectangleBorder(borderRadius: .all(.circular(10))),
    ),
    cardTheme: const CardThemeData(
      color: Color(0xFF1C1C1E),
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: .all(.circular(10))),
      margin: .symmetric(horizontal: 16, vertical: 4),
    ),
    dividerTheme: const DividerThemeData(
      color: Color(0xFF38383A),
      thickness: 0.5,
      indent: 16,
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontSize: 34,
        fontWeight: .w700,
        letterSpacing: -0.5,
      ),
      titleLarge: TextStyle(
        fontSize: 22,
        fontWeight: .w700,
        letterSpacing: -0.4,
      ),
      titleMedium: TextStyle(
        fontSize: 17,
        fontWeight: .w600,
        letterSpacing: -0.4,
      ),
      bodyLarge: TextStyle(
        fontSize: 17,
        fontWeight: .w400,
        letterSpacing: -0.4,
      ),
      bodyMedium: TextStyle(
        fontSize: 15,
        fontWeight: .w400,
        letterSpacing: -0.2,
      ),
      labelLarge: TextStyle(
        fontSize: 17,
        fontWeight: .w400,
        letterSpacing: -0.4,
      ),
      labelSmall: TextStyle(
        fontSize: 11,
        fontWeight: .w400,
        letterSpacing: 0.06,
      ),
    ),
  );
}
