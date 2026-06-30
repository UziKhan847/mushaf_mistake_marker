import 'package:mushaf_mistake_marker/enums.dart';
import 'package:mushaf_mistake_marker/extensions/int_extension.dart';
import 'package:mushaf_mistake_marker/index/helpers.dart';

typedef IndexLabel = ({
  String title,
  String? subtitle,
  String big,
  bool isHizbStart,
});

// Everything a (non-pages) tile needs to render, derived from (tab, index).
IndexLabel indexLabel(IndexTab tab, int index) {
  final n = index + 1;
  switch (tab) {
    case .surahs:
      return (
        title: 'Surah ${n.surahEngName}',
        subtitle: '${n.surahName} · ${n.surahTotalVrs} verses',
        big: '$n',
        isHizbStart: false,
      );
    case .juz:
      return (title: 'Juzʾ $n', subtitle: null, big: '$n', isHizbStart: false);
    case .rubu:
      final hizb = ((n - 1) ~/ 4) + 1;
      final hizbStart = (index % 4) == 0;
      return (
        title: hizbStart ? 'Ḥizb $hizb' : 'Rubʿ ${rubuQuarterIcon(n)}',
        subtitle: hizbStart ? null : 'Ḥizb $hizb',
        big: hizbStart ? '$hizb' : rubuQuarterIcon(n),
        isHizbStart: hizbStart,
      );
    case .manzil:
      return (
        title: 'Manzil $n',
        subtitle: null,
        big: '$n',
        isHizbStart: false,
      );
    case .sajdah:
      return (
        title: 'Sajdah $n',
        subtitle: null,
        big: '$n',
        isHizbStart: false,
      );
    case .hizb:
    case .pages:
      return (title: '$n', subtitle: null, big: '$n', isHizbStart: false);
  }
}