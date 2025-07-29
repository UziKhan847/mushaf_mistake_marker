import 'package:mushaf_mistake_marker/mushaf/mushaf_page_data.dart';

final List<MushafPageData?> mushafPages = List.generate(
  604,
  (_) => null,
  growable: false,
);

//final Map<String, MarkType> markedPaths = {};

enum MarkType {
mistake,
oldMistake,
doubt,
tajwid;
}