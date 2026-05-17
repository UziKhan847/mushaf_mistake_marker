import 'dart:typed_data';


class AtlasCache {
  const AtlasCache({
    required this.idToIndex,
    required this.rectList,
    required this.transformList,
    required this.colorList,
    required this.highlightColorList,
  });

  final Float32List rectList;
  final Float32List transformList;
  final Int32List colorList;
  final Int32List highlightColorList;
  final Map<String, int> idToIndex;
}
