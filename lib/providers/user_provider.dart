import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mushaf_mistake_marker/main.dart';
import 'package:mushaf_mistake_marker/objectbox/entities/user.dart';
import 'package:mushaf_mistake_marker/objectbox/entities/user_settings.dart';
import 'package:mushaf_mistake_marker/providers/user_id_provider.dart';

final userProvider = NotifierProvider<UserNotifier, User>(UserNotifier.new);

class UserNotifier extends Notifier<User> {
  @override
  User build() {
    final int userId = ref.watch(userIdProvider);

    if (userId == 0) {
      throw Exception('Invalid User Id');
    }

    final user = objectbox.store.box<User>().get(userId);

    if (user == null) {
      throw Exception('Invalid User');
    }

    return user;
  }

  Future<void> saveUser(User user) async {
    final userBox = objectbox.store.box<User>();
    final settingsBox = objectbox.store.box<UserSettings>();

    final settings = UserSettings(
      updatedAt: DateTime.now().millisecondsSinceEpoch,
    );

    settingsBox.put(settings);

    user.settings.target = settings;

    userBox.put(user);

    state = user;
  }
}
