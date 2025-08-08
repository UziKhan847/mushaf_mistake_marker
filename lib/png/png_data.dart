import 'dart:ui';

class PngData {
  PngData({
    required this.id,
    required this.offset,
    required this.origSize,
    required this.outSize,
  });

  String id;
  Offset offset;
  Size origSize;
  Size outSize;

  static PngData fromJson(Map<String, dynamic> json) => PngData(
    id: json['id'] as String,
    offset: Offset(json['offset'][0] as double, json['offset'][1] as double),
    origSize: Size(
      json['origSize'][0] as double,
      json['origSize'][1] as double,
    ),
    outSize: Size(
      (json['outSize'][0] as int).toDouble(),
      (json['outSize'][1] as int).toDouble(),
    ),
  );
}
