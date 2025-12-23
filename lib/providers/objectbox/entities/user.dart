import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mushaf_mistake_marker/main.dart';
import 'package:mushaf_mistake_marker/objectbox/entities/settings.dart';
import 'package:mushaf_mistake_marker/objectbox/entities/user.dart';
import 'package:mushaf_mistake_marker/providers/objectbox/box/settings.dart';
import 'package:mushaf_mistake_marker/providers/objectbox/box/user.dart';
import 'package:mushaf_mistake_marker/providers/shared_prefs.dart';

final userProvider = NotifierProvider<UserNotifier, User?>(
  UserNotifier.new,
);

class UserNotifier extends Notifier<User?> {
  @override
  User? build() {
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
    state = user;
  }

  Future<void> saveUser(User user) async {
    final (userBox, settingsBox) = (
      ref.read(userBoxProvider),
      ref.read(settingsBoxProvider),
    );

    final settings = UserSettings(
      updatedAt: DateTime.now().millisecondsSinceEpoch,
    );

    settingsBox.put(settings);

    user.settings.target = settings;

    userBox.put(user);

    state = user;
  }
}
