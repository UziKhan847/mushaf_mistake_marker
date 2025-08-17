import 'package:json_annotation/json_annotation.dart';

part 'orig_size.g.dart';

@JsonSerializable()
class OrigSize {
  OrigSize({required this.h, required this.w});

  double w;
  double h;

    factory OrigSize.fromJson(Map<String, dynamic> json) =>
      _$OrigSizeFromJson(json);

  Map<String, dynamic> toJson() => _$OrigSizeToJson(this);
}
