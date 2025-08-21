import 'dart:convert';
import 'dart:ui' as ui;
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mushaf_mistake_marker/sprite/sprite.dart';
import 'package:mushaf_mistake_marker/variables.dart';
import 'package:riverpod/riverpod.dart';

final spriteManagerProvider = ChangeNotifierProvider<SpriteManager>((ref) {
  return SpriteManager();
});

class SpriteManager extends ChangeNotifier {
  Future<void> fetchSprite(int index, int pageNumber) async {
    try {
      final spriteManifest = await rootBundle.loadString(
        'assets/sprite_manifests/$pageNumber.json',
      );

      final json =
          await compute(jsonDecode, spriteManifest) as Map<String, dynamic>;

      for (final e in json['sprites'] as List<dynamic>) {
        final sprite = Sprite.fromJson(e);

        spriteSheets[index].sprites.add(sprite);
      }
    } catch (e) {
      throw Exception('Exception. Error message: $e');
    }
  }

  Future<void> fetchImg(int index, int pageNumber) async {
    try {
      final imgFile = await rootBundle.load(
        'assets/sprite_sheets_webp/$pageNumber.webp',
      );

      final codec = await ui.instantiateImageCodec(
        imgFile.buffer.asUint8List(),
      );

      final frame = await codec.getNextFrame();

      spriteSheets[index].image = frame.image;

      //return frame.image;
    } catch (e) {
      throw Exception('Exception. Error message: $e');
    }
  }

  Future<void> fetchSpriteSheet(int index) async {
    final spriteSheet = spriteSheets[index];

    if (spriteSheet.sprites.isEmpty) {
      await fetchSprite(index, index + 1);
      print('Succesfully fetched Sprite Data of Page ${index + 1}');
    }

    if (spriteSheet.image == null) {
      await fetchImg(index, index + 1);
      print('Succesfully fetched Image of Page ${index + 1}');
    }
    notifyListeners();
  }

  void clearImg(int index) {
    final spriteSheet = spriteSheets[index];
    spriteSheet.image = null;
    print('Cleared Page: ${index + 1}');
  }

  void preFetchPage(int initPage) {
    fetchSpriteSheet(initPage);

    final offsets = [-2, -1, 1, 2];

    for (final e in offsets) {
      if (initPage + e >= 0 && initPage + e <= 603) {
        fetchSpriteSheet(initPage + e);
      }
    }
  }
}
