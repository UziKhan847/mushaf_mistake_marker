import 'package:flutter/material.dart';
import 'package:mushaf_mistake_marker/icons/my_flutter_app_icons.dart';

class SettingsItem extends StatelessWidget {
  const SettingsItem({super.key});

  @override
  Widget build(BuildContext context) {
    final outlineColor = Theme.of(context).colorScheme.outline.withAlpha(180);

    return Padding(
      padding: const .symmetric(horizontal: 4.0),
      child: Material(
        shape: CircleBorder(),
        child: Ink(
          decoration: BoxDecoration(
            shape: .circle,
            border: .all(color: outlineColor),
          ),
          height: 42,
          width: 42,
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
