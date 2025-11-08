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


// import 'package:json_annotation/json_annotation.dart';
// import 'package:mushaf_mistake_marker/sprite/orig_size.dart';
// import 'package:mushaf_mistake_marker/sprite/rect_offset.dart';
// import 'package:mushaf_mistake_marker/sprite/rst_offset.dart';

// part 'sprite.g.dart';

// @JsonSerializable(explicitToJson: true)
// class Sprite {
//   Sprite({
//     required this.id,
//     required this.origSize,
//     required this.rectOffset,
//     required this.rstOffset,
//   });

//   String id;
//   OrigSize origSize;
//   RectOffset rectOffset;
//   RstOffset rstOffset;

//   factory Sprite.fromJson(Map<String, dynamic> json) => _$SpriteFromJson(json);

//   Map<String, dynamic> toJson() => _$SpriteToJson(this);
// }
