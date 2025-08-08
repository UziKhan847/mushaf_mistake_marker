import 'package:json_annotation/json_annotation.dart';

part 'page_data.g.dart';

@JsonSerializable()
class PageData {
  PageData({
    required this.hizbNumber,
    required this.juzNumber,
    required this.manzilNumber,
    required this.rubElHizbNumber,
    required this.rukuNumber,
    required this.sajdahNumber,
    required this.surahNumber,
    required this.pageNumber,
    required this.width,
    required this.height,
  });

  int pageNumber;
  Set<int> hizbNumber;
  Set<int> rubElHizbNumber;
  Set<int> rukuNumber;
  Set<int> manzilNumber;
  int? sajdahNumber;
  Set<int> juzNumber;
  Set<Map<int, int>> surahNumber;
  double width;
  double height;

  factory PageData.fromJson(Map<String, dynamic> json) =>
      _$PageDataFromJson(json);
  Map<String, dynamic> toJson() => _$PageDataToJson(this);
}
