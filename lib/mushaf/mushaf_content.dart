import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mushaf_mistake_marker/mushaf/mushaf_page_view.dart';
import 'package:mushaf_mistake_marker/providers/mushaf_page_controller_provider.dart';
import 'package:mushaf_mistake_marker/providers/shared_prefs_provider.dart';

class MushafContent extends ConsumerStatefulWidget {
  const MushafContent({
    super.key,
    // required this.isPortrait,
    required this.pageController,
  });

  //final bool isPortrait;
  final PageController pageController;

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
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

    oldIsPortrait ??= isPortrait;

    isDualPgTglOn = prefs.getBool('dualPageToggleOn') ?? false;

    isDualPageMode = !isPortrait && isDualPgTglOn;

    prefs.setBool('isDualPageMode', isDualPageMode);

    if (oldIsPortrait != isPortrait) {
      mushafPgCrtlProv.preservePage(
        isDualPageMode ? PageLayout.dualPage : PageLayout.singlePage,
      );

      oldIsPortrait = isPortrait;
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constraints) {
        return PageView(
          physics: NeverScrollableScrollPhysics(),
          controller: widget.pageController,
          children: [
            MushafPageView(constraints: constraints, isPortrait: isPortrait),
            Placeholder(color: Colors.red),
            Placeholder(color: Colors.blueAccent),
            Placeholder(color: Colors.amberAccent),
          ],
        );
      },
    );
  }
}
