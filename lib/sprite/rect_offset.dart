import 'package:json_annotation/json_annotation.dart';

part 'rect_offset.g.dart';

@JsonSerializable()
class RectOffset {
  RectOffset({required this.x, required this.y});

  int x;
  int y;

  factory RectOffset.fromJson(Map<String, dynamic> json) =>
      _$RectOffsetFromJson(json);

  Map<String, dynamic> toJson() => _$RectOffsetToJson(this);
}
