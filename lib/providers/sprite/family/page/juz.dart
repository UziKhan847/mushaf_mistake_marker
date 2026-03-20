import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mushaf_mistake_marker/providers/sprite/family/sprite_ids.dart';

final juzRegExp = RegExp(r'j(\d{1,2})');

final juzProvider = Provider.autoDispose.family<Set<int>?, int>((
  ref,
  pageIndex,
) {
  final pageElementIds = ref.watch(spriteIdsProvider(pageIndex));
  if (pageElementIds == null) return null;

  final juzNums = <int>{};
  for (final e in pageElementIds) {
    final match = juzRegExp.firstMatch(e);
    if (match != null) {
      juzNums.add(int.parse(match.group(1)!));
    }
  }
  if (juzNums.isEmpty) return null;

  return juzNums;
});
