// THE PART MOST LIKELY TO NEED YOUR TASTE. It walks pagesData once and injects:
//   - a shaded Juzʾ header the first time a juz appears,
//   - a lighter Surah header the first time a surah appears,
//   - a Sajdah / Manzil badge on the page that starts one,
// then a normal page row (big page number on the left, stats from statsProvider).
// Header ordering within a single page is "juz, then surah" — swap if you prefer.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mushaf_mistake_marker/extensions/int_extension.dart';
import 'package:mushaf_mistake_marker/providers/index/stats.dart';
import 'package:mushaf_mistake_marker/providers/pages_provider.dart';
import 'package:mushaf_mistake_marker/widgets/index/index_labels.dart';
import 'package:mushaf_mistake_marker/widgets/index/index_row.dart';
import 'package:mushaf_mistake_marker/widgets/index/mini_stat_row.dart';



class PagesTabView extends ConsumerWidget {
  const PagesTabView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    final pages = ref.watch(pagesProvider).value!.pagesData;

    final rows = <IndexRow>[];
    final seenJuz = <int>{}, seenSurah = <int>{};
    for (final p in pages) {
      for (final j in (p.jzNum.toList()..sort())) {
        if (seenJuz.add(j)) rows.add(JuzHeader(j, p.pNum));
      }
      for (final s in (p.srNum.toList()..sort())) {
        if (seenSurah.add(s)) rows.add(SurahHeader(s, p.pNum));
      }
      rows.add(PageRow(p.pNum, sajdah: p.sjdNum));
    }

    return ListView.builder(
      padding: const .only(bottom: 8),
      itemCount: rows.length,
      itemBuilder: (context, i) {
        final row = rows[i];
        switch (row) {
          case JuzHeader(:final juz, :final page):
            return Container(
              color: cs.surfaceContainerHighest,
              padding: const .symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisAlignment: .spaceBetween,
                children: [
                  Text(
                    "Juzʾ $juz",
                    style: tt.titleSmall?.copyWith(
                      color: cs.onSurfaceVariant,
                      fontWeight: .w700,
                    ),
                  ),
                  Text(
                    '$page',
                    style: tt.titleSmall?.copyWith(color: cs.onSurfaceVariant),
                  ),
                ],
              ),
            );
          case SurahHeader(:final surah, :final page):
            return Container(
              color: cs.surfaceContainerHigh.withValues(alpha: 0.5),
              padding: const .fromLTRB(24, 6, 16, 6),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'Surah ${surah.surahEngName}',
                      style: tt.labelLarge?.copyWith(color: cs.primary),
                    ),
                  ),
                  Text(
                    '$page',
                    style: tt.labelMedium?.copyWith(color: cs.onSurfaceVariant),
                  ),
                ],
              ),
            );
          case PageRow(:final page, :final sajdah):
            final stats = statsFromMap(
              ref.watch(statsProvider(.pages))[page - 1],
            );
            return InkWell(
              onTap: () {}, // TODO: jump to page
              child: Padding(
                padding: const .fromLTRB(12, 10, 16, 10),
                child: Row(
                  children: [
                    SizedBox(
                      width: 52,
                      child: Text(
                        '$page',
                        textAlign: .center,
                        style: tt.titleMedium?.copyWith(color: cs.onSurface),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Row(
                        children: [
                          if (sajdah != null) ...[
                            Icon(
                              Icons.south_east_outlined,
                              size: 14,
                              color: cs.tertiary,
                            ),
                            const SizedBox(width: 6),
                          ],
                          MiniStatRow(stats: stats),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
        }
      },
    );
  }
}
