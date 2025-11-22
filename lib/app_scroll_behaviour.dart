import 'dart:ui';

import 'package:flutter/material.dart';

class AppScrollBehaviour extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
    .touch,
    .mouse,
    .trackpad,
  };
}
