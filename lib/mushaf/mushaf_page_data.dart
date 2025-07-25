import 'package:json_annotation/json_annotation.dart';
import 'package:mushaf_mistake_marker/drawable_path/drawable_path.dart';

part 'mushaf_page_data.g.dart';

@JsonSerializable(explicitToJson: true)
class MushafPageData {
  MushafPageData({
    required this.paths,
    required this.hizbNumber,
    required this.juzNumber,
    required this.manzilNumber,
    required this.rubElHizbNumber,
    required this.rukuNumber,
    required this.sajdahNumber,
    required this.surahNumber,
    required this.id,
    required this.pageNumber,
    required this.height,
    required this.width,
  });

  String id;
  int pageNumber;
  double width;
  double height;
  Set<int> hizbNumber;
  Set<int> rubElHizbNumber;
  Set<int> rukuNumber;
  Set<int> manzilNumber;
  Set<int?> sajdahNumber;
  Set<int> juzNumber;
  Set<Map<int, int>> surahNumber;
  List<DrawablePath> paths;

  factory MushafPageData.fromJson(Map<String, dynamic> json) =>
      _$MushafPageDataFromJson(json);
  Map<String, dynamic> toJson() => _$MushafPageDataToJson(this);
}

// // GENERATED CODE - DO NOT MODIFY BY HAND

// part of 'mushaf_page_data.dart';

// // **************************************************************************
// // JsonSerializableGenerator
// // **************************************************************************

// MushafPageData _$MushafPageDataFromJson(Map<String, dynamic> json) => MushafPageData(
//   paths:
//       (json['paths'] as List<dynamic>)
//           .map((e) => DrawablePath.fromJson(e))
//           .toList(),
//   hizbNumber:
//       (json['hizbNumber'] as List<dynamic>)
//           .map((e) => (e as num).toInt())
//           .toSet(),
//   juzNumber:
//       (json['juzNumber'] as List<dynamic>)
//           .map((e) => (e as num).toInt())
//           .toSet(),
//   manzilNumber:
//       (json['manzilNumber'] as List<dynamic>)
//           .map((e) => (e as num).toInt())
//           .toSet(),
//   rubElHizbNumber:
//       (json['rubElHizbNumber'] as List<dynamic>)
//           .map((e) => (e as num).toInt())
//           .toSet(),
//   rukuNumber:
//       (json['rukuNumber'] as List<dynamic>)
//           .map((e) => (e as num).toInt())
//           .toSet(),
//   sajdahNumber:
//       (json['sajdahNumber'] as List<dynamic>)
//           .map((e) => (e as num?)?.toInt())
//           .toSet(),
//   surahNumber:
//       (json['surahNumber'] as List<dynamic>)
//           .map(
//             (e) => (e as Map<String, dynamic>).map(
//               (k, e) => MapEntry(int.parse(k), (e as num).toInt()),
//             ),
//           )
//           .toSet(),
//   id: json['id'] as String,
//   pageNumber: (json['pageNumber'] as num).toInt(),
// );

// Map<String, dynamic> _$MushafPageDataToJson(MushafPageData instance) =>
//     <String, dynamic>{
//       'paths': instance.paths.map((e) => e.toJson()).toList(),
//       'id': instance.id,
//       'pageNumber': instance.pageNumber,
//       'hizbNumber': instance.hizbNumber.toList(),
//       'rubElHizbNumber': instance.rubElHizbNumber.toList(),
//       'rukuNumber': instance.rukuNumber.toList(),
//       'manzilNumber': instance.manzilNumber.toList(),
//       'sajdahNumber': instance.sajdahNumber.toList(),
//       'juzNumber': instance.juzNumber.toList(),
//       'surahNumber':
//           instance.surahNumber
//               .map((e) => e.map((k, e) => MapEntry(k.toString(), e)))
//               .toList(),
//     };
