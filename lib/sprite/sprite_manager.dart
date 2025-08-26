import 'dart:convert';
import 'dart:ui' as ui;
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:mushaf_mistake_marker/sprite/sprite.dart';
import 'package:mushaf_mistake_marker/variables.dart';

class SpriteManager {
  static Future<void> fetchSprite(int index, int pageNumber) async {
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

  static Future<void> fetchImg(int index, int pageNumber) async {
    try {
      final imgFile = await rootBundle.load(
        'assets/sprite_sheets_webp/$pageNumber.webp',
      );

      final codec = await ui.instantiateImageCodec(
        imgFile.buffer.asUint8List(),
      );

      final frame = await codec.getNextFrame();

      spriteSheets[index].image = frame.image;
    } catch (e) {
      throw Exception('Exception. Error message: $e');
    }
  }

  static Future<void> fetchSpriteSheet(int index) async {
    final spriteSheet = spriteSheets[index];

    if (spriteSheet.sprites.isEmpty) {
      await fetchSprite(index, index + 1);
      //print('Succesfully fetched Sprite Data of Page ${index + 1}');
    }

    if (spriteSheet.image == null) {
      await fetchImg(index, index + 1);
      //print('Succesfully fetched Image of Page ${index + 1}');
    }
  }

  static void clearImg(int index) {
    final spriteSheet = spriteSheets[index];
    spriteSheet.image = null;
    //print('Cleared Page: ${index + 1}');
  }

  static Future<int> preFetchPages(bool isDualPageMode, int initPage) async {
    //final isDualPageMode = ref.read(pageModeProvider) && !widget.isPortrait;
    final offsets = [0, 1, -1, 2, -2, 3, 4];
    final List<Future> futures = [];
    final List<int> pageNumbers = [];

    final actualPage = isDualPageMode ? initPage * 2 : initPage;

    for (final e in offsets) {
      if (actualPage + e >= 0 && actualPage + e <= 603) {
        futures.add(SpriteManager.fetchSpriteSheet(actualPage + e));
        pageNumbers.add(actualPage + e);
      }
    }

    await Future.wait(futures);
    print(
      'Prefetched the following pages and their images: ${pageNumbers.join(',')}',
    );

    return initPage;
  }
}
