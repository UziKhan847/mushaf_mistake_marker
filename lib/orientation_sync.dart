import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mushaf_mistake_marker/pages/loading.dart';
import 'package:mushaf_mistake_marker/providers/mushaf/listeners.dart';
import 'package:mushaf_mistake_marker/providers/orientation.dart';
import 'package:mushaf_mistake_marker/providers/white_rect.dart';

class OrientationSync extends ConsumerWidget {
  const OrientationSync({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.read(mushafListenersProvider);
    ref.read(whiteRectProvider.notifier).generateImg();

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
