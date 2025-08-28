import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mushaf_mistake_marker/pages/homepage.dart';
import 'package:mushaf_mistake_marker/providers/pages_provider.dart';

class LoadingPage extends ConsumerWidget {
  const LoadingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref
        .watch(pagesProvider)
        .when(
          data: (pages) => Homepage(),
          error: (e, st) => Center(child: Text('Error: $e')),
          loading: () => Center(child: CircularProgressIndicator()),
        );
  }
}
