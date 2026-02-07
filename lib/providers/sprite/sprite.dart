import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mushaf_mistake_marker/providers/page_mode.dart';
import 'package:mushaf_mistake_marker/providers/sprite/family/img.dart';
import 'package:mushaf_mistake_marker/providers/sprite/family/page/data.dart';
import 'package:mushaf_mistake_marker/sprite_models/sprite_sheet.dart';
import 'package:flutter/material.dart';

final spriteProvider = NotifierProvider<SpriteNotifier, List<SpriteSheet>>(
  SpriteNotifier.new,
);

class SpriteNotifier extends Notifier<List<SpriteSheet>> {
  final Set<int> fetching = {};

  @override
  List<SpriteSheet> build() =>
      List.generate(604, (_) => SpriteSheet(sprMnfst: []));

  Future<void> fetchSpriteSheet(int index) async {
    if (fetching.contains(index)) {
      return;
    }

    fetching.add(index);

    try {
      final oldSheet = state[index];

      if (oldSheet.sprMnfst.isNotEmpty && oldSheet.image != null) {
        return;
      }

      final sprMnfst = oldSheet.sprMnfst.isEmpty
          ? await ref.read(sprPgDataProvider(index).future)
          : oldSheet.sprMnfst;

      final image = oldSheet.image == null
          ? await ref.read(sprImgProvider(index).future)
          : oldSheet.image!;

      final updated = oldSheet.copyWith(sprMnfst: sprMnfst, image: image);
      final newState = [...state];
      newState[index] = updated;
      state = newState;
    } catch (e, st) {
      debugPrint('fetchSpriteSheet ERROR for index $index: $e');
      debugPrintStack(stackTrace: st);
    } finally {
      fetching.remove(index);
    }
  }

  void clearImg(int index) {
    final oldSheet = state[index];

    final updated = oldSheet.copyWith(image: null);
    final newState = [...state];
    newState[index] = updated;
    state = newState;
  }

  void clearSprite(int index) {
    final newState = [...state];
    newState[index] = SpriteSheet(sprMnfst: []);
    state = newState;
  }

  void clearAll() {
    state = List.generate(604, (_) => SpriteSheet(sprMnfst: []));
  }

  Future<void> preFetchPages(int initPage) async {
    final dualPgMode = ref.read(pageModeProvider);

    final offsets = [0, 1, -1, 2, -2, 3, 4];
    final List<Future> futures = [];
    final List<int> pageNumbers = [];

    final actualPage = dualPgMode ? initPage * 2 : initPage;

    for (final e in offsets) {
      if (actualPage + e >= 0 && actualPage + e <= 603) {
        final newPage = actualPage + e;
        futures.add(fetchSpriteSheet(newPage));
        pageNumbers.add(newPage);
      }
    }

    await Future.wait(futures);
  }
}
