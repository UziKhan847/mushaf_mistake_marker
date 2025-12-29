import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mushaf_mistake_marker/mushaf/page/page_pre_fetcher.dart';
import 'package:mushaf_mistake_marker/providers/dual_page_mode.dart';
import 'package:mushaf_mistake_marker/providers/mushaf_page_controller.dart';

class MushafContainer extends ConsumerWidget {
  const MushafContainer({super.key, required this.isPortrait});

  final bool isPortrait;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<bool>(dualPageModeProvider, (_, isDualMode) {
      ref
          .read(mushafPgCtrlProvider.notifier)
          .preservePage(isDualMode ? .dualPage : .singlePage);
    });

    return LayoutBuilder(
      builder: (_, constraints) {
        return MushafPagePreFetcher(constraints: constraints);
      },
    );
  }
}
