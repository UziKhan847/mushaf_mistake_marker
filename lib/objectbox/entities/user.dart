import 'package:mushaf_mistake_marker/objectbox/entities/mushaf_data.dart';
import 'package:mushaf_mistake_marker/objectbox/entities/settings.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class User {
  User({required this.username});

  @Id()
  int id = 0;

  String username;

  final settings = ToOne<UserSettings>();
  final mushafData = ToOne<UserMushafData>();
}
