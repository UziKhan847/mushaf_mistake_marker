import 'package:mushaf_mistake_marker/models/index/entry.dart';

class IndexLists {
  const IndexLists({
    required this.pages,
    required this.surahs,
    required this.juz,
    required this.hizb,
    required this.rubu,
    required this.manzil,
    required this.sajdah,
  });

  final List<IndexEntry> pages;
  final List<IndexEntry> surahs;
  final List<IndexEntry> juz;
  final List<IndexEntry> hizb;
  final List<IndexEntry> rubu;
  final List<IndexEntry> manzil;
  final List<IndexEntry> sajdah;
}