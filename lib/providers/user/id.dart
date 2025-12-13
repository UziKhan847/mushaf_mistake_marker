import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mushaf_mistake_marker/providers/shared_prefs.dart';

final userIdProvider = NotifierProvider<UserIdProvider, int>(
  UserIdProvider.new,
);

class UserIdProvider extends Notifier<int> {
  @override
  int build() => ref.read(sharedPrefsProv).getInt('userId') ?? 1;

  void setUserId(int userId) {
    final prefs = ref.read(sharedPrefsProv);
    prefs.setInt('userId', userId);
    state = userId;
  }
}
