import 'dart:convert';
import 'dart:ui' as ui;
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mushaf_mistake_marker/sprite/sprite.dart';
import 'package:mushaf_mistake_marker/sprite/sprite_sheet.dart';

final spriteProvider = NotifierProvider<SpriteNotifier, List<SpriteSheet>>(
  SpriteNotifier.new,
);

class SpriteNotifier extends Notifier<List<SpriteSheet>> {
  @override
  List<SpriteSheet> build() =>
      List.generate(604, (_) => SpriteSheet(sprites: []));

  Future<List<Sprite>> fetchSprite(int index, int pageNumber) async {
    try {
      final List<Sprite> sprites = [];

      final spriteManifest = await rootBundle.loadString(
        'assets/sprite_manifests/$pageNumber.json',
      );

      final json =
          await compute(jsonDecode, spriteManifest) as Map<String, dynamic>;

      for (final e in json['sprites'] as List<dynamic>) {
        final sprite = Sprite.fromJson(e);

        sprites.add(sprite);
      }

      return sprites;
    } catch (e) {
      throw Exception('Exception. Error message: $e');
    }
  }

  Future<ui.Image> fetchImg(int index, int pageNumber) async {
    try {
      final imgFile = await rootBundle.load(
        'assets/sprite_sheets_webp/$pageNumber.webp',
      );

      final codec = await ui.instantiateImageCodec(
        imgFile.buffer.asUint8List(),
      );

      final frame = await codec.getNextFrame();

      return frame.image;
    } catch (e) {
      throw Exception('Exception. Error message: $e');
    }
  }

  Future<void> fetchSpriteSheet(int index) async {
    final oldSheet = state[index];

    if (oldSheet.sprites.isNotEmpty && oldSheet.image != null) {
      state = [...state];
      return;
    }

    final sprites = oldSheet.sprites.isEmpty
        ? await fetchSprite(index, index + 1)
        : oldSheet.sprites;

    final image = oldSheet.image == null
        ? await fetchImg(index, index + 1)
        : oldSheet.image!;

    final updated = oldSheet.copyWith(sprites: sprites, image: image);
    final newState = [...state];
    newState[index] = updated;
    state = newState;
  }

  void clearImg(int index) {
    final oldSheet = state[index];

    final updated = oldSheet.copyWith(image: null);
    final newState = [...state];
    newState[index] = updated;
    state = newState;

    //oldSheet.image?.dispose();
  }
}
