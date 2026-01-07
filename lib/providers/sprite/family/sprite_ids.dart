import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mushaf_mistake_marker/providers/sprite/family/page_data.dart';

final spriteIdsProvider = AutoDisposeProviderFamily<List<String>?, int>(
  (ref, userId) => ref
      .watch(sprPgDataProvider(userId))
      .valueOrNull
      ?.map((e) => e.id)
      .toList(),
);
