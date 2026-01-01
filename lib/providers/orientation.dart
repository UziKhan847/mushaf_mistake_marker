import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final orientationProvider = NotifierProvider<OrientationNotifier, Orientation?>(
  OrientationNotifier.new,
);

class OrientationNotifier extends Notifier<Orientation?> {
  @override
  Orientation? build() => null;

  void setValue(Orientation value) {
    if (state != value) state = value;
  }
}
