class IndexEntry {
  final String title;
  final String subtitle;
  final int page;

  const IndexEntry({
    required this.title,
    required this.subtitle,
    required this.page,
  });

  @override
  String toString() =>
      '{"title": "$title", "subtitle": "$subtitle", "pNum": $page}';
}
