import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mushaf_mistake_marker/pages/loading_page.dart';
import 'package:mushaf_mistake_marker/providers/mushaf/listeners.dart';
import 'package:mushaf_mistake_marker/providers/orientation.dart';

class OrientationSync extends ConsumerWidget {
  const OrientationSync({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.read(mushafListenersProvider);

    return OrientationBuilder(
      builder: (_, orientation) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          ref.read(orientationProvider.notifier).setValue(orientation);
        });

        return LoadingPage();
      },
    );
  }
}
