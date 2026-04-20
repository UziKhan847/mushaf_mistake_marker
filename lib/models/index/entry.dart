import 'package:mushaf_mistake_marker/models/index/stats.dart';

class IndexEntry {
  final String title;
  final String subtitle;
  final int page;
  final IndexStats stats;
 
  const IndexEntry({
    required this.title,
    required this.subtitle,
    required this.page,
    this.stats = const IndexStats(),
  });
}