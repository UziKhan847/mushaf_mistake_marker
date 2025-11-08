import 'package:json_annotation/json_annotation.dart';

part 'page_data.g.dart';

@JsonSerializable()
class PageData {
  PageData({
    required this.pNum,
    this.pSize,
    required this.hzNum,
    required this.rHzbNum,
    required this.rkNum,
    required this.mnzlNum,
    this.sjdNum,
    required this.jzNum,
    required this.srNum,
    required this.srVrsSets,
  });

  final int pNum;
  final List<double>? pSize;
  final Set<int> srNum;
  final Set<int> hzNum;
  final Set<int> rHzbNum;
  final Set<int> rkNum;
  final Set<int> mnzlNum;
  final int? sjdNum;
  final Set<int> jzNum;
  final Map<int, Set<int>> srVrsSets;

  factory PageData.fromJson(Map<String, dynamic> json) =>
      _$PageDataFromJson(json);

  Map<String, dynamic> toJson() => _$PageDataToJson(this);
}

