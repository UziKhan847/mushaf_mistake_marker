import 'package:objectbox/objectbox.dart';

@Entity()
class UserSettings {
  UserSettings({this.initPage = 0, this.updatedAt = 0});

  @Id()
  int id = 0;

  int initPage;
  //bool isDarkMode = false;
  //bool dualPageToggleOn = false;
  //bool isDualPageMode = false;
  //bool isHighlightMode = false;
  //bool isLeftHand = false;

  int updatedAt;
}
