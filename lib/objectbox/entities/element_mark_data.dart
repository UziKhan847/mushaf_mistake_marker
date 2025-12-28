import 'package:mushaf_mistake_marker/enums.dart';
import 'package:mushaf_mistake_marker/objectbox/entities/mushaf_data.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class ElementMarkData {
  ElementMarkData({
    this.id = 0,
    required this.key,
    MarkType mark = .unknown,
    MarkType highlight = .unknown,
    this.annotation,
  }) {
    markId = mark.id;
    highlightId = highlight.id;
  }

  @Id()
  int id;

  @Index()
  String key;

  @Property(type: .byte)
  int markId = 0;

  @Property(type: .byte)
  int highlightId = 0;

  String? annotation;

  final mushafData = ToOne<UserMushafData>();

  @Transient()
  bool get isEmpty => markId == 0 && highlightId == 0 && (annotation == null);

  @Transient()
  MarkType get mark => .fromId(markId);
  set mark(MarkType value) => markId = value.id;

  @Transient()
  void updateMark() {
    switch (mark) {
      case .unknown:
        mark = .doubt;
      case .doubt:
        mark = .mistake;
      case .mistake:
        mark = .oldMistake;
      case .oldMistake:
        mark = .tajwid;
      default:
        mark = .unknown;
    }
  }

  @Transient()
  MarkType get highlight => .fromId(highlightId);
  set highlight(MarkType value) => highlightId = value.id;

  @Transient()
  ElementMarkData copyWith({
    int? id,
    String? key,
    MarkType? mark,
    MarkType? highlight,
    String? annotation,
  }) => ElementMarkData(
    id: id ?? this.id,
    key: key ?? this.key,
    mark: mark ?? this.mark,
    highlight: highlight ?? this.highlight,
    annotation: annotation ?? this.annotation,
  );
}
