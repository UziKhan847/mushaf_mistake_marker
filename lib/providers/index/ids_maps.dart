import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mushaf_mistake_marker/helpers/index.dart';
import 'package:mushaf_mistake_marker/providers/index/page_ids.dart';
import 'package:mushaf_mistake_marker/providers/pages_provider.dart';

class IndexIdsMaps {
  const IndexIdsMaps({
    required this.bySurah,
    required this.byJuz,
    required this.byHizb,
    required this.byRubu,
    required this.byManzil,
    required this.bySajdah,
  });

  final Map<int, List<String>> bySurah;
  final Map<int, List<String>> byJuz;
  final Map<int, List<String>> byHizb;
  final Map<int, List<String>> byRubu;
  final Map<int, List<String>> byManzil;
  final Map<int, List<String>> bySajdah;
}

final indexIdsMapsProvider =
    AsyncNotifierProvider<IndexIdsMapsNotifier, IndexIdsMaps>(
      IndexIdsMapsNotifier.new,
    );

class IndexIdsMapsNotifier extends AsyncNotifier<IndexIdsMaps> {
  @override
  Future<IndexIdsMaps> build() async {
    final pagesData = (await ref.watch(pagesProvider.future)).pagesData;

    final Map<int, List<String>> bySurah = {},
        byJuz = {},
        byHizb = {},
        byRubu = {},
        byManzil = {},
        bySajdah = {};

    for (final p in pagesData) {
      final ids = await ref.watch(pageIdsProvider(p.pNum).future);

      for (final sr in p.srNum) {
        final surahIds = ids.where((id) => id.startsWith('s$sr')).toList();
        bySurah.putIfAbsent(sr, () => []).addAll(surahIds);
      }
      for (final jz in p.jzNum) {
        byJuz.putIfAbsent(jz, () => []).addAll(ids);
      }
      for (final hz in p.hzNum) {
        byHizb.putIfAbsent(hz, () => []).addAll(ids);
      }
      for (final rh in p.rHzbNum) {
        byRubu.putIfAbsent(rh, () => []).addAll(ids);
      }
      for (final mn in p.mnzlNum) {
        byManzil.putIfAbsent(mn, () => []).addAll(ids);
      }
      if (p.sjdNum != null) {
        final (sr, vr) = sajdahLocations[p.sjdNum! - 1];
        bySajdah[p.sjdNum!] = ids
            .where((id) => id.startsWith('s${sr}v$vr'))
            .toList();
      }
    }

    return IndexIdsMaps(
      bySurah: bySurah,
      byJuz: byJuz,
      byHizb: byHizb,
      byRubu: byRubu,
      byManzil: byManzil,
      bySajdah: bySajdah,
    );
  }
}
