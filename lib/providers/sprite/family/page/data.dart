import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mushaf_mistake_marker/sprite_models/sprite_ele_data.dart';

final sprPgDataProvider = AsyncNotifierProvider.autoDispose
    .family<SprPgDataNotifier, List<SpriteEleData>, int>(SprPgDataNotifier.new);

class SprPgDataNotifier extends AsyncNotifier<List<SpriteEleData>> {
  SprPgDataNotifier(this.index);
  final int index;

  @override
  Future<List<SpriteEleData>> build() async {
    try {
      final pgNum = index + 1;

      final List<SpriteEleData> sprMnfst = [];

      final spriteManifest = await rootBundle.loadString(
        'assets/sprite_manifests/$pgNum.json',
      );

      final json =
          await compute(jsonDecode, spriteManifest) as Map<String, dynamic>;

      for (final e in json['spritesData'] as List<dynamic>) {
        final spriteEleData = SpriteEleData.fromJson(e);

        sprMnfst.add(spriteEleData);
      }

      return sprMnfst;
    } catch (e) {
      throw Exception('Exception. Error message: $e');
    }
  }
}
