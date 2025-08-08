import 'package:json_annotation/json_annotation.dart';
import 'package:mushaf_mistake_marker/page_data/page_data.dart';

part 'pages.g.dart';

@JsonSerializable(explicitToJson: true)
class Pages {
  Pages({required this.pageData});

  List<PageData> pageData;

  factory Pages.fromJson(Map<String, dynamic> json) => _$PagesFromJson(json);
  Map<String, dynamic> toJson() => _$PagesToJson(this);
}
