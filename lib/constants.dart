import 'dart:ui';

import 'package:mushaf_mistake_marker/enums.dart';

const purpleInt = 0xFF800080;
const redInt = 0xFFFF0000;
const blueInt = 0xFF0000FF;
const greenInt = 0xFF00FF00;
const blackInt = 0xFF000000;
const whiteInt = 0xFFFFFFFF;
const transparentColor = 0x00000000;

const highlightColors = [
  0xFFE6CCFF,
  0xFFFFCCCC,
  0xFFCCE5FF,
  0xFFCCFFCC,
  transparentColor,
];
const highlightDarkColors = [
  0xFF5A2D82,
  0xFF8B2C2C,
  0xFF1F4F8B,
  0xFF1F6B3A,
  transparentColor,
];

const List<Color> annotateLightColors = [
  Color(0xFFE7C4FF),
  Color(0xFFFFC4C4),
  Color(0xFFC4FFFA),
  Color(0xFFC4FFC4),
  Color(0xFFE2E2E2),
];

const List<Color> annotateDarkColors = [
  Color(0xFF9B5FC0),
  Color(0xFFC05F5F),
  Color(0xFF5FA8A4),
  Color(0xFF5FA85F),
  Color(0xFF8A8A8A),
];

const List<String> annotateLabels = [
  'Doubt',
  'Mistake',
  'Old\nMistake',
  'Tajwid',
  'None',
];

const List<HighlightType> hightlightTypes = [
  .doubt,
  .mistake,
  .oldMistake,
  .tajwid,
  .unknown,
];
