// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sprite.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Sprite _$SpriteFromJson(Map<String, dynamic> json) => Sprite(
  id: json['id'] as String,
  origSize: OrigSize.fromJson(json['origSize'] as Map<String, dynamic>),
  rectOffset: RectOffset.fromJson(json['rectOffset'] as Map<String, dynamic>),
  rstOffset: RstOffset.fromJson(json['rstOffset'] as Map<String, dynamic>),
);

Map<String, dynamic> _$SpriteToJson(Sprite instance) => <String, dynamic>{
  'id': instance.id,
  'origSize': instance.origSize.toJson(),
  'rectOffset': instance.rectOffset.toJson(),
  'rstOffset': instance.rstOffset.toJson(),
};
