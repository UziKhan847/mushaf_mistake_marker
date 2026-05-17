import 'package:flutter/material.dart';
import 'package:mushaf_mistake_marker/constants.dart';

enum HighlightType {
  unknown(0, null, null, null, null),
  mistake(
    1,
    highlightRed,
    highlightDarkRed,
    annotateMistake,
    annotateMistakeDark,
  ),
  oldMistake(
    2,
    highlightBlue,
    highlightDarkBlue,
    annotateOldMistake,
    annotateOldMistakeDark,
  ),
  doubt(
    3,
    highlightPurple,
    highlightDarkPurple,
    annotateDoubt,
    annotateDoubtDark,
  ),
  tajwid(
    4,
    highlightGreen,
    highlightDarkGreen,
    annotateTajwid,
    annotateTajwidDark,
  );

  const HighlightType(
    this.id,
    this.color,
    this.darkColor,
    this.annotColor,
    this.annotDarkColor,
  );
  final int id;
  final int? color;
  final int? darkColor;
  final int? annotColor;
  final int? annotDarkColor;

  static HighlightType fromId(int? id) =>
      .values.firstWhere((e) => e.id == id, orElse: () => .unknown);
}

enum AnnotationMode {
  highlight(0),
  eraser(1),
  audio(2),
  annotate(3);

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
  manzil('Manzil', Icons.bolt),
  sajdah('Sajdah', Icons.south_east_outlined);

  const IndexTab(this.label, this.icon);
  final String label;
  final IconData icon;
}
