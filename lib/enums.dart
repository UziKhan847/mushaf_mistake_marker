import 'package:flutter/material.dart';

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
  gold(lightSeed: Color(0xFF7b580c), darkSeed: Color(0xFFeebf6d)),
  blue(lightSeed: Color(0xFF35618e), darkSeed: Color(0xFFa0cafd)),
  red(lightSeed: Color(0xFF904a45), darkSeed: Color(0xFFffb3b0)),
  green(lightSeed: Color(0xFF34693f), darkSeed: Color(0xFF9ad4a1)),
  purple(lightSeed: Color(0xFF735187), darkSeed: Color(0xFFe2b7f4)),
  monochrome(lightSeed: Color(0xFF3A3A3C), darkSeed: Color(0xFFAEAEB2));

  const AppTheme({required this.lightSeed, required this.darkSeed});

  final Color lightSeed;
  final Color darkSeed;

  static AppTheme fromThemeIndex(int index) =>
      .values.firstWhere((e) => e.index == index, orElse: () => .gold);
}

enum IndexTab {
  pages('Pages', Icons.auto_stories_outlined),
  surahs('Surahs', Icons.format_list_numbered_outlined),
  juz('Juz', Icons.segment_outlined),
  hizb('Hizb', Icons.grid_view_outlined),
  rubu('Rubʿ', Icons.grid_on_outlined),
  sajdah('Sajdah', Icons.south_east_outlined);

  final String label;
  final IconData icon;
  const IndexTab(this.label, this.icon);
}
