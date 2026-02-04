import 'package:mushaf_mistake_marker/atlas_models/page_mark_atlas.dart';

class AtlasCache {
  const AtlasCache({required this.idToIndex, required this.pageMarkAtlas});

  final PageMarksAtlas pageMarkAtlas;
  final Map<String, int> idToIndex;
}
