import 'dart:ui' as ui;

import 'package:mushaf_mistake_marker/sprite_models/sprite_ele_data.dart';

class SpriteSheet {
  SpriteSheet({required this.sprMnfst, this.image});

  List<SpriteEleData> sprMnfst;
  ui.Image? image;

  SpriteSheet copyWith({List<SpriteEleData>? sprMnfst, ui.Image? image}) {
    return SpriteSheet(
      sprMnfst: sprMnfst ?? List.from(this.sprMnfst),
      image: image ?? this.image,
    );
  }
}
