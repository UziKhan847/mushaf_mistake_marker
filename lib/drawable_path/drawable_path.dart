import 'package:flutter/widgets.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mushaf_mistake_marker/extensions/path_extension.dart';

part 'drawable_path.g.dart';

@JsonSerializable()
class DrawablePath {
  DrawablePath({required this.path, required this.id});

  //final List<Map<String, dynamic>> pathList;
  final Path path;
  final String id;

  factory DrawablePath.fromJson(Map<String, dynamic> json) =>
      _$DrawablePathFromJson(json);
  Map<String, dynamic> toJson() => _$DrawablePathToJson(this);
}

// // GENERATED CODE - DO NOT MODIFY BY HAND

// part of 'drawable_path.dart';

// // **************************************************************************
// // JsonSerializableGenerator
// // **************************************************************************

// DrawablePath _$DrawablePathFromJson(Map<String, dynamic> json) {

//   final pathList = json['pathList'] as List<dynamic>;

//   return DrawablePath(
//     path: Path().fromJson(pathList),
//     id: json['id'] as String,
//   );
// }

// Map<String, dynamic> _$DrawablePathToJson(DrawablePath instance) =>
//     <String, dynamic>{'pathList': instance.path, 'id': instance.id};
