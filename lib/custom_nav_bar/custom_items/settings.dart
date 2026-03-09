import 'package:flutter/material.dart';
import 'package:mushaf_mistake_marker/icons/my_flutter_app_icons.dart';

class SettingsItem extends StatelessWidget {
  const SettingsItem({super.key, required this.isPortrait});

  final bool isPortrait;

  @override
  Widget build(BuildContext context) {
    final outlineColor = Theme.of(context).colorScheme.outline.withAlpha(180);

    return Padding(
      padding: .symmetric(
        horizontal: isPortrait ? 10.0 : 1,
        vertical: isPortrait ? 1.0 : 10,
      ),
      child: Material(
        shape: CircleBorder(),
        child: Ink(
          decoration: BoxDecoration(
            shape: .circle,
            border: .all(color: outlineColor),
          ),
          height: 40,
          width: 40,
          child: InkWell(
            customBorder: const CircleBorder(),
            onTap: () {},
            child: const Icon(MyFlutterApp.settings_outlined),
          ),
        ),
      ),
    );
  }
}
