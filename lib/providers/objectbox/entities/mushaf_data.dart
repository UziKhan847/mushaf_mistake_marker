import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mushaf_mistake_marker/objectbox/entities/mushaf_data.dart';
import 'package:mushaf_mistake_marker/providers/objectbox/entities/user.dart';

final userMushafDataProvider = Provider<UserMushafData?>(
  (ref) => ref.watch(userProvider).mushafData.target,
);
