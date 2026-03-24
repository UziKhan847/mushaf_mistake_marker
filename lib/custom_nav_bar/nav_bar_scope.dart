import 'package:flutter/material.dart';

class NavBarScope extends InheritedWidget {
  const NavBarScope({super.key, required this.widgetKey, required super.child});

  final GlobalKey widgetKey;

  RenderBox? get renderBox =>
      widgetKey.currentContext?.findRenderObject() as RenderBox?;

  static NavBarScope? of(BuildContext context) =>
      context.getInheritedWidgetOfExactType<NavBarScope>();

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => false;
}
