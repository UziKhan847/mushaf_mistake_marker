import 'package:flutter_svg/flutter_svg.dart';

class MainNavBarIcon {
  MainNavBarIcon({
    required this.selectedIcon,
    required this.unSelectedIcon,
    required this.labelText,
  });

  final SvgPicture selectedIcon;
  final SvgPicture unSelectedIcon;
  final String labelText;
}
