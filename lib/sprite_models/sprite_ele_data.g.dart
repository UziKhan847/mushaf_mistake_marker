// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sprite_ele_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SpriteEleData _$SpriteEleDataFromJson(Map<String, dynamic> json) =>
    SpriteEleData(
      id: json['id'] as String,
      eLTWH: (json['eLTWH'] as List<dynamic>)
          .map((e) => (e as num).toDouble())
          .toList(),
      sprXY: (json['sprXY'] as List<dynamic>)
          .map((e) => (e as num).toDouble())
          .toList(),
    );

Map<String, dynamic> _$SpriteEleDataToJson(SpriteEleData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'eLTWH': instance.eLTWH,
      'sprXY': instance.sprXY,
    };
