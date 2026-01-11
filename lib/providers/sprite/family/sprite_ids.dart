import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mushaf_mistake_marker/providers/sprite/sprite.dart';

final spriteIdsProvider = AutoDisposeProviderFamily<List<String>?, int>((
  ref,
  userId,
) {
  // ref
  //       .watch(sprPgDataProvider(userId))
  //       .valueOrNull
  //       ?.map((e) => e.id)
  //       .toList()

  final sprites = ref.watch(
    spriteProvider.select((state) => state[userId].sprMnfst),
  );

  return sprites.isEmpty ? null : sprites.map((e) => e.id).toList();
});
