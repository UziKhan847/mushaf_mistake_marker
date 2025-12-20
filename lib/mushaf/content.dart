import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// ignore: unused_import
import 'package:mushaf_mistake_marker/enums.dart';
import 'package:mushaf_mistake_marker/mushaf/page/page_view.dart';
import 'package:mushaf_mistake_marker/providers/mushaf_page_controller.dart';
import 'package:mushaf_mistake_marker/providers/shared_prefs.dart';

class MushafContent extends ConsumerStatefulWidget {
  const MushafContent({super.key});

  @override
  ConsumerState<MushafContent> createState() => _MushafContentState();
}

class _MushafContentState extends ConsumerState<MushafContent> {
  late final mushafPgCrtlProv = ref.read(mushafPgCtrlProvider.notifier);
  late final prefs = ref.read(sharedPrefsProv);
  late bool isDualPageMode;
  late bool isPortrait;
  late bool isDualPgTglOn;
  bool? oldIsPortrait;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    isPortrait = MediaQuery.of(context).orientation == .portrait;

    oldIsPortrait ??= isPortrait;

    isDualPgTglOn = prefs.getBool('dualPageToggleOn') ?? false;

    isDualPageMode = !isPortrait && isDualPgTglOn;

    prefs.setBool('isDualPageMode', isDualPageMode);

    if (oldIsPortrait != isPortrait) {
      if (isDualPgTglOn) {
        mushafPgCrtlProv.preservePage(
          isDualPageMode ? .dualPage : .singlePage,
        );
      }

      oldIsPortrait = isPortrait;
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constraints) {
        return MushafPageView(constraints: constraints, isPortrait: isPortrait);
      },
    );
  }
}
