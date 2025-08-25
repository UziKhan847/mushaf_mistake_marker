import 'dart:ui' as ui;

import 'package:mushaf_mistake_marker/sprite/sprite.dart';

class SpriteSheet {
  SpriteSheet({required this.sprites, this.image});

  List<Sprite> sprites;
  ui.Image? image;

  SpriteSheet copyWith({List<Sprite>? sprites, ui.Image? image}) {
    return SpriteSheet(
      sprites: sprites ?? List.from(this.sprites),
      image: image ?? this.image,
    );
  }
}
