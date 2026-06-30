sealed class IndexRow {}

class JuzHeader extends IndexRow {
  JuzHeader(this.juz, this.page);
  final int juz, page;
}

class SurahHeader extends IndexRow {
  SurahHeader(this.surah, this.page);
  final int surah, page;
}

class PageRow extends IndexRow {
  PageRow(this.page, this.startSurah, this.startVerse, {this.sajdah});
  final int page, startSurah, startVerse;
  final int? sajdah;
}
