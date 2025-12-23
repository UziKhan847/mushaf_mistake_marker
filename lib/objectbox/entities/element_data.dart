import 'package:mushaf_mistake_marker/enums.dart';
import 'package:mushaf_mistake_marker/objectbox/entities/mushaf_data.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class ElementData {
  ElementData({
    required this.key,
    MarkType mark = .unknown,
    MarkType highlight = .unknown,
    this.annotation,
  }) {
    markId = mark.id;
    highlightId = highlight.id;
  }

  @Id()
  int id = 0;

  @Index()
  String key;

  @Property(type: .byte)
  int markId = 0;

  @Property(type: .byte)
  int highlightId = 0;

  String? annotation;

  final mushafData = ToOne<UserMushafData>();

  @Transient()
  MarkType get mark => .fromId(markId);
  set mark(MarkType value) => markId = value.id;

  @Transient()
  MarkType get highlight => .fromId(highlightId);
  set highlight(MarkType value) => highlightId = value.id;
}
