import 'package:flutter_svg/flutter_svg.dart';

class NavBarIconData {
  NavBarIconData({
    required this.selectedIcon,
    required this.unSelectedIcon,
    required this.labelText,
  });

  final SvgPicture selectedIcon;
  final SvgPicture unSelectedIcon;
  final String labelText;
}
