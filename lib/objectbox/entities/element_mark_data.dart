import 'package:mushaf_mistake_marker/enums.dart';
import 'package:mushaf_mistake_marker/objectbox/entities/mushaf_data.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class ElementMarkData {
  ElementMarkData({
    this.id = 0,
    required this.key,
    HighlightType highlight = .unknown,
    this.annotation,
  }) {
    highlightId = highlight.id;
  }

  @Id()
  int id;

  @Index()
  String key;

  @Property(type: .byte)
  int highlightId = 0;

  String? annotation;

  final mushafData = ToOne<UserMushafData>();

  @Transient()
  bool get isEmpty =>
      highlightId == 0 && (annotation == null || annotation == '');

  @Transient()
  HighlightType get highlight => .fromId(highlightId);
  set highlight(HighlightType value) => highlightId = value.id;

  @Transient()
  void updateHighlight(HighlightType? highlight) =>
      this.highlight = highlight ?? this.highlight;

  @Transient()
  void updateAnnotation(String? annotation) =>
      this.annotation = annotation == '' ? null : annotation;

  @Transient()
  int get highlightColorIndex => switch (highlight) {
    .doubt => 0,
    .mistake => 1,
    .oldMistake => 2,
    .tajwid => 3,
    _ => 4,
  };

  @Transient()
  ElementMarkData copyWith({
    int? id,
    String? key,
    HighlightType? highlight,
    Object? annotation = _nothingPassed,
  }) {
    final copy = ElementMarkData(
      id: id ?? this.id,
      key: key ?? this.key,
      highlight: highlight ?? this.highlight,
      annotation: annotation == _nothingPassed
          ? this.annotation
          : annotation as String?,
    );
    copy.mushafData.target = mushafData.target;
    return copy;
  }
}

const _nothingPassed = Object();
