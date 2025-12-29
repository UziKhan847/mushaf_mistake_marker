import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mushaf_mistake_marker/main.dart';
import 'package:mushaf_mistake_marker/objectbox/entities/mushaf_data.dart';
import 'package:mushaf_mistake_marker/objectbox/entities/settings.dart';
import 'package:mushaf_mistake_marker/objectbox/entities/user.dart';
import 'package:mushaf_mistake_marker/providers/objectbox/box/mushaf_data.dart';
import 'package:mushaf_mistake_marker/providers/objectbox/box/settings.dart';
import 'package:mushaf_mistake_marker/providers/objectbox/box/user.dart';
import 'package:mushaf_mistake_marker/providers/shared_prefs.dart';

final userProvider = NotifierProvider<UserNotifier, User>(UserNotifier.new);

class UserNotifier extends Notifier<User> {
  @override
  User build() {
    final prefs = ref.read(sharedPrefsProv);
    final userBox = objectbox.store.box<User>();

    final storedId = prefs.getInt('userId');

    User? user;

    if (storedId != null) {
      user = userBox.get(storedId);
    }

    user ??= userBox.getAll().firstOrNull;

    if (user == null) {
      throw Exception('Error, No User Found!');
    }

    prefs.setInt('userId', user.id);

    return user;
  }

  void setUser(User user) {
    ref.read(sharedPrefsProv).setInt('userId', user.id);
    state = user;
  }

  Future<void> saveUser(User user) async {
    final (userBox, settingsBox, mushafDataBox) = (
      ref.read(userBoxProvider),
      ref.read(settingsBoxProvider),
      ref.read(mushafDataBoxProvider),
    );

    final (settings, mushafData) = (
      UserSettings(updatedAt: DateTime.now().millisecondsSinceEpoch),
      UserMushafData(),
    );

    settingsBox.put(settings);
    mushafDataBox.put(mushafData);

    user.settings.target = settings;
    user.mushafData.target = mushafData;

    userBox.put(user);

    ref.read(sharedPrefsProv).setInt('userId', user.id);

    state = user;
  }
}
