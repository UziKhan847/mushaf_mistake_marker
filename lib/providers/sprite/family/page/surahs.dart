import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mushaf_mistake_marker/providers/sprite/family/sprite_ids.dart';
import 'package:mushaf_mistake_marker/surah/surah.dart';
import 'package:mushaf_mistake_marker/surah/surah_names_data.dart';

final surahRegExp = RegExp(r's(\d{1,3})');

final pageSurahsProvider = Provider.autoDispose.family<List<Surah>?, int>((
  ref,
  pageIndex,
) {
  final pageElementIds = ref.watch(spriteIdsProvider(pageIndex));
  if (pageElementIds == null) return null;

  final surahNums = <int>{};
  for (final e in pageElementIds) {
    final match = surahRegExp.matchAsPrefix(e);
    if (match != null) {
      surahNums.add(int.parse(match.group(1)!));
    }
  }
  if (surahNums.isEmpty) return null;

  final surahs = surahNums
      .map((n) => Surah.fromJson(surahsData[n - 1]))
      .toList();
  if (surahs.isEmpty) return null;

  return surahs;
});
