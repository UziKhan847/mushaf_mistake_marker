import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mushaf_mistake_marker/sprite_models/sprite_ele_data.dart';

final sprPgDataProvider =
    AutoDisposeAsyncNotifierProviderFamily<
      SprPgDataNotifier,
      List<SpriteEleData>,
      int
    >(SprPgDataNotifier.new);

class SprPgDataNotifier
    extends AutoDisposeFamilyAsyncNotifier<List<SpriteEleData>, int> {
  @override
  Future<List<SpriteEleData>> build(int index) async {
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
