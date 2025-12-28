import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mushaf_mistake_marker/providers/sprite/sprite.dart';

final spriteIdsProvider = AutoDisposeProviderFamily<List<String>, int>(
  (ref, index) =>
      ref.read(spriteProvider)[index].sprMnfst.map((e) => e.id).toList(),
);
