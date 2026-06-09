import 'package:mushaf_mistake_marker/index/constants.dart';

extension IntExtension on int {
  bool get _isValidSurah => this >= 1 && this <= 114;

  String? get surahName => _isValidSurah ? surahs[this - 1].name : null;

  String? get surahEngName => _isValidSurah ? surahs[this - 1].engName : null;

  int? get surahTotalVrs => _isValidSurah ? surahs[this - 1].totalVrs : null;
}
