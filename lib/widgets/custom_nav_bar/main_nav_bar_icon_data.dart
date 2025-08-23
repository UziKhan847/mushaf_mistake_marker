import 'package:flutter_svg/flutter_svg.dart';

class MainNavBarIconData {
  MainNavBarIconData({
    required this.selectedIcon,
    required this.unSelectedIcon,
    required this.labelText,
  });

  final SvgPicture selectedIcon;
  final SvgPicture unSelectedIcon;
  final String labelText;
}
