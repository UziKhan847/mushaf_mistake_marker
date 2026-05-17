import 'package:mushaf_mistake_marker/enums.dart';

const purpleInt = 0xFF800080;
const redInt = 0xFFFF0000;
const blueInt = 0xFF0000FF;
const greenInt = 0xFF00FF00;
const greyInt = 0xFF808080;
const blackInt = 0xFF000000;
const whiteInt = 0xFFFFFFFF;

const transparentColor = 0x00000000;

const highlightPurple = 0xFFE6CCFF;
const highlightRed = 0xFFFFCCCC;
const highlightBlue = 0xFFCCE5FF;
const highlightGreen = 0xFFCCFFCC;

const highlightDarkPurple = 0xFF5A2D82;
const highlightDarkRed = 0xFF8B2C2C;
const highlightDarkBlue = 0xFF1F4F8B;
const highlightDarkGreen = 0xFF1F6B3A;

const annotateDefault = 0xFFdfd59b;
const annotateDefaultDark = 0xFF8a7d2c;

const annotateMistake = 0xFF800000;
const annotateOldMistake = 0xFF000080;
const annotateDoubt = 0xFF800080;
const annotateTajwid = 0xFF008000;

const annotateMistakeDark = 0xFFff0000;
const annotateOldMistakeDark = 0xFF00ffff;
const annotateDoubtDark = 0xFFff00ff;
const annotateTajwidDark = 0xFF00ff00;

const lightDoubtInt32Purple = -1651457;
const lightMistakeInt32Red = -13108;
const lightOldMistakeInt32Blue = -3348993;
const lightTajwidInt32Green = -3342388;

const darkDoubtInt32Purple = -10867326;
const darkMistakeInt32Red = -7656404;
const darkOldMistakeInt32Blue = -14725237;
const darkTajwidInt32Green = -14718150;

const highlightColors = [
  highlightPurple,
  highlightRed,
  highlightBlue,
  highlightGreen,
  transparentColor,
];

const highlightDarkColors = [
  highlightDarkPurple,
  highlightDarkRed,
  highlightDarkBlue,
  highlightDarkGreen,
  transparentColor,
];

const List<String> annotateLabels = [
  'Doubt',
  'Mistake',
  'Old\nMistake',
  'Tajwid',
  'None',
];

const List<HighlightType> highlightTypes = [
  .doubt,
  .mistake,
  .oldMistake,
  .tajwid,
  .unknown,
];

const annotateBubbleWidth = 250.0;
const annotateBtnWidth = annotateBubbleWidth / 5;
const bubbleEdgePadding = 2.0;
const bottomSideSheetHeaderSize = 28.0;
