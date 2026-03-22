import 'dart:ui';

enum HighlightType {
  unknown(0),
  mistake(1),
  oldMistake(2),
  doubt(3),
  tajwid(4);

  const HighlightType(this.id);
  final int id;

  static HighlightType fromId(int? id) =>
      .values.firstWhere((e) => e.id == id, orElse: () => .unknown);
}

enum Phase { initial, submitting, success, error }

enum PageLayout { singlePage, dualPage }

enum PageSide { rightSide, leftSide, none }

enum PageChangeOrigin { modeChange, swipe }

enum GradientEdge { start, end }

enum TrianglePosition {
  bottomLeft,
  bottomCenter,
  bottomRight,
  topLeft,
  topCenter,
  topRight,
}

enum AppTheme {
  gold(0),
  blue(1),
  red(2),
  green(3),
  purple(4),
  grey(5),
  monochrome(6),
  ios(7);

  const AppTheme(this.themeIndex);
  final int themeIndex;

  static AppTheme fromThemeIndex(int themeIndex) => .values.firstWhere(
    (e) => e.themeIndex == themeIndex,
    orElse: () => .gold,
  );

  Color get lightSeed => switch (this) {
    .gold => const Color(0xFFAE8B4F),
    .blue => const Color(0xFF007AFF),
    .red => const Color(0xFFFF3B30),
    .green => const Color(0xFF34C759),
    .purple => const Color(0xFFAF52DE),
    .grey => const Color(0xFF8E8E93),
    .monochrome => const Color(0xFF000000),
    .ios => const Color(0xFF007AFF),
  };

  Color get darkSeed => switch (this) {
    .gold => const Color(0xFFAE8B4F),
    .blue => const Color(0xFF0A84FF),
    .red => const Color(0xFFFF453A),
    .green => const Color(0xFF30D158),
    .purple => const Color(0xFFBF5AF2),
    .grey => const Color(0xFF636366),
    .monochrome => const Color(0xFFFFFFFF),
    .ios => const Color(0xFF0A84FF),
  };
}
