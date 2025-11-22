import 'package:json_annotation/json_annotation.dart';

part 'sprite.g.dart';

@JsonSerializable(explicitToJson: true)
class Sprite {
  Sprite({
    required this.id,
    required this.eLTWH,
    required this.sprXY,
  });

  String id;
  List<double> eLTWH;
  List<double> sprXY;

  factory Sprite.fromJson(Map<String, dynamic> json) => _$SpriteFromJson(json);

  Map<String, dynamic> toJson() => _$SpriteToJson(this);
}