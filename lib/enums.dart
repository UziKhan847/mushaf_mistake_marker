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

enum AnnotationMode {
  highlight(0),
  earser(1),
  audio(2);

  const AnnotationMode(this.id);
  final int id;

  static AnnotationMode fromId(int? id) =>
      .values.firstWhere((e) => e.id == id, orElse: () => .highlight);
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
  monochrome(5);

  const AppTheme(this.id);
  final int id;

  static AppTheme fromThemeIndex(int id) =>
      .values.firstWhere((e) => e.id == id, orElse: () => .gold);

  Color get lightSeed => switch (this) {
    .gold => const Color(0xFF7b580c),
    .blue => const Color(0xFF35618e),
    .red => const Color(0xFF904a45),
    .green => const Color(0xFF34693f),
    .purple => const Color(0xFF735187),
    .monochrome => const Color(0xFF3A3A3C),
  };

  Color get darkSeed => switch (this) {
    .gold => const Color(0xFFeebf6d),
    .blue => const Color(0xFFa0cafd),
    .red => const Color(0xFFffb3b0),
    .green => const Color(0xFF9ad4a1),
    .purple => const Color(0xFFe2b7f4),
    .monochrome => const Color(0xFFAEAEB2),
  };
}
