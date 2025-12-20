import 'package:json_annotation/json_annotation.dart';

part 'sprite_ele_data.g.dart';

@JsonSerializable(explicitToJson: true)
class SpriteEleData {
  SpriteEleData({required this.id, required this.eLTWH, required this.sprXY});

  String id;
  List<double> eLTWH;
  List<double> sprXY;

  factory SpriteEleData.fromJson(Map<String, dynamic> json) =>
      _$SpriteEleDataFromJson(json);

  Map<String, dynamic> toJson() => _$SpriteEleDataToJson(this);
}
