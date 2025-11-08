import 'package:mushaf_mistake_marker/objectbox/entities/user_settings.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class User {
  User({required this.username});

  @Id()
  int id = 0;

  String username;

  final settings = ToOne<UserSettings>();
}
