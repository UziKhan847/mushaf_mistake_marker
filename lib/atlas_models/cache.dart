import 'package:mushaf_mistake_marker/atlas_models/page_annotations_atlas.dart';
import 'package:mushaf_mistake_marker/atlas_models/page_highlights_atlas.dart';
import 'package:mushaf_mistake_marker/atlas_models/page_marks_atlas.dart';

class AtlasCache {
  const AtlasCache({
    required this.idToIndex,
    required this.pageMarkAtlas,
    required this.pageHighlightsAtlas,
    required this.pageAnnotatiosnAtlas,
  });

  final PageMarksAtlas pageMarkAtlas;
  final PageHighlightsAtlas pageHighlightsAtlas;
  final PageAnnotationsAtlas pageAnnotatiosnAtlas;
  final Map<String, int> idToIndex;
}
