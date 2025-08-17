import 'package:json_annotation/json_annotation.dart';

part 'rst_offset.g.dart';

@JsonSerializable()
class RstOffset {
  RstOffset({required this.x, required this.y});

  double x;
  double y;

      factory RstOffset.fromJson(Map<String, dynamic> json) =>
      _$RstOffsetFromJson(json);

  Map<String, dynamic> toJson() => _$RstOffsetToJson(this);
}
