import 'dart:io';
import 'package:mushaf_mistake_marker/objectbox/entities/user.dart';
import 'package:mushaf_mistake_marker/objectbox/entities/user_settings.dart';
import 'package:mushaf_mistake_marker/objectbox/objectbox.g.dart';
import 'package:path_provider/path_provider.dart';

class ObjectBox {
  late final Store store;

  ObjectBox._create(this.store) {
    initializeDefaultUser();
  }

  void initializeDefaultUser() {
    final userBox = store.box<User>();
    final settingsBox = store.box<UserSettings>();

    if (userBox.isEmpty()) {
      final userSettings = UserSettings(updatedAt: DateTime.now().millisecondsSinceEpoch);

      settingsBox.put(userSettings);

      final user = User(username: 'default_user');
      user.settings.target = userSettings;
      userBox.put(user);
    }
  }

  static Future<ObjectBox> create() async {
    final docsDir = await getApplicationDocumentsDirectory();
    final obxDir = Directory('${docsDir.path}/obx_mushaf_data');

    if (!await obxDir.exists()) {
      await obxDir.create(recursive: true);
    }

    final store = await openStore(directory: obxDir.path);

    return ObjectBox._create(store);
  }
}
