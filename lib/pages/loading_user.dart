import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mushaf_mistake_marker/objectbox/entities/user.dart';
import 'package:mushaf_mistake_marker/pages/homepage.dart';
import 'package:mushaf_mistake_marker/providers/objectbox/entities/user.dart';

class LoadingUser extends ConsumerStatefulWidget {
  const LoadingUser({super.key});

  @override
  ConsumerState<LoadingUser> createState() => _LoadingUserState();
}

class _LoadingUserState extends ConsumerState<LoadingUser> {
  late final Future<User> data = ref.read(userProvider.future);

  // @override
  // void initState() {
  //   super.initState();

  //data = ref.read(userProvider.future);
  //}

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: data,
      builder: (_, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        if (snapshot.connectionState == .done && snapshot.hasData) {
          return Homepage();
        }

        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
