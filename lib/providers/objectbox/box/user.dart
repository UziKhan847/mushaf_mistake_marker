import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mushaf_mistake_marker/objectbox/entities/user.dart';
import 'package:mushaf_mistake_marker/objectbox/objectbox.g.dart';
import 'package:mushaf_mistake_marker/providers/objectbox/store.dart';

final userBoxProvider = NotifierProvider<UserBoxNotifier, Box<User>>(
  UserBoxNotifier.new,
);

class UserBoxNotifier extends Notifier<Box<User>> {
  @override
  Box<User> build() => ref.read(objectBoxStoreProvider).box<User>();

  List<String> get usernames {
    final users = state.getAll();

    final usernames = users.map((e) => e.username).toList();

    return usernames;
  }

  List<String> get lowerCaseUsernames {
    final users = state.getAll();

    final usernames = users.map((e) => e.username.toLowerCase()).toList();

    return usernames;
  }
}
