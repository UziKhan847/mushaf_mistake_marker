import 'dart:ui' as ui;

import 'package:mushaf_mistake_marker/sprite/sprite.dart';

class SpriteSheet {
  SpriteSheet({required this.sprites, this.image});

  List<Sprite> sprites;
  ui.Image? image;
}
