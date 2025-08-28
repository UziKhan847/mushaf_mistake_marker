import 'package:mushaf_mistake_marker/widgets/custom_nav_bar/nav_bar_item_data.dart';

const darkMode = NavBarItemData(
  label: 'Dark Mode',
  selectedAsset: 'assets/icons/darkmode_selected.svg',
  unSelectedAsset: 'assets/icons/darkmode_unselected.svg',
);

const dualPage = NavBarItemData(
  label: 'Dual Page',
  selectedAsset: 'assets/icons/dualpage_selected.svg',
  unSelectedAsset: 'assets/icons/dualpage_unselected.svg',
);

const List<NavBarItemData> navItems = [
  NavBarItemData(
    label: 'Mushaf',
    selectedAsset: 'assets/icons/mushaf_selected.svg',
    unSelectedAsset: 'assets/icons/mushaf_unselected.svg',
  ),
  NavBarItemData(
    label: 'Index',
    selectedAsset: 'assets/icons/index_selected.svg',
    unSelectedAsset: 'assets/icons/index_unselected.svg',
  ),
  NavBarItemData(
    label: 'Page Info',
    selectedAsset: 'assets/icons/pageinfo_selected.svg',
    unSelectedAsset: 'assets/icons/pageinfo_unselected.svg',
  ),
  NavBarItemData(
    label: 'More',
    selectedAsset: 'assets/icons/more_selected.svg',
    unSelectedAsset: 'assets/icons/more_unselected.svg',
  ),
];

const double iconSize = 24;