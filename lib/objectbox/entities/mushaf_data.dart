import 'package:mushaf_mistake_marker/objectbox/entities/element_mark_data.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class UserMushafData {
  UserMushafData({this.updatedAt = 0});

  @Id()
  int id = 0;

  final elementMarkData = ToMany<ElementMarkData>();
  int updatedAt;
}
