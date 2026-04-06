import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mushaf_mistake_marker/providers/sprite/sprite.dart';

final spriteIdsProvider = Provider.autoDispose.family<List<String>?, int>((
  ref,
  userId,
) {
  final sprites = ref.watch(
    spriteProvider.select((state) => state[userId].sprMnfst),
  );

  return sprites.isEmpty ? null : sprites.map((e) => e.id).toList();
});
