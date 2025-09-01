import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mushaf_mistake_marker/mushaf/mushaf_page_view.dart';
import 'package:mushaf_mistake_marker/providers/mushaf_page_controller_provider.dart';
import 'package:mushaf_mistake_marker/providers/shared_prefs_provider.dart';

class MushafContent extends ConsumerStatefulWidget {
  const MushafContent({
    super.key,
    required this.isPortrait,
    required this.pageController,
  });

  final bool isPortrait;
  final PageController pageController;

  @override
  ConsumerState<MushafContent> createState() => _MushafContentState();
}

class _MushafContentState extends ConsumerState<MushafContent> {
  late final mushafPgCrtlProv = ref.read(mushafPgCtrlProvider.notifier);
  late final prefs = ref.read(sharedPrefsProv);
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

    oldIsPortrait ??=
        MediaQuery.of(context).orientation == Orientation.portrait;
  }

  void preservePageOnOrientChange(bool isPortrait, bool isDualPage) {
    if (oldIsPortrait == null) {
      oldIsPortrait = isPortrait;
      return;
    }

    if (oldIsPortrait != isPortrait && isDualPage) {
      mushafPgCrtlProv.preservePage(
        isPortrait ? PageLayout.singlePage : PageLayout.dualPage,
      );
      oldIsPortrait = isPortrait;
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constraints) {
        final isDualPage = prefs.getBool('savedPageMode') ?? false;

        preservePageOnOrientChange(widget.isPortrait, isDualPage);

        return PageView(
          physics: NeverScrollableScrollPhysics(),
          controller: widget.pageController,
          children: [
            MushafPageView(
              constraints: constraints,
              isPortrait: widget.isPortrait,
            ),
            Placeholder(color: Colors.red),
            Placeholder(color: Colors.blueAccent),
            Placeholder(color: Colors.amberAccent),
          ],
        );
      },
    );
  }
}
