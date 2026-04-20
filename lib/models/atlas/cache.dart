import 'dart:typed_data';


class AtlasCache {
  const AtlasCache({
    required this.idToIndex,
    required this.rectList,
    required this.transformList,
    required this.elemColorList,
    required this.highlighColorList,
  });

  final Float32List rectList;
  final Float32List transformList;
  final Int32List elemColorList;
  final Int32List highlighColorList;
  final Map<String, int> idToIndex;
}
