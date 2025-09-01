class CustomIconData {
  CustomIconData({
    required this.label,
    required this.selectedAsset,
    required this.unselectedAsset,
  });

  final String label;
  final String selectedAsset;
  final String unselectedAsset;

  static CustomIconData fromJson(Map<String, String> json) => CustomIconData(
    label: json['label'] as String,
    selectedAsset: json['selectedAsset'] as String,
    unselectedAsset: json['unselectedAsset'] as String,
  );
}

const iconsData = {
  'mushaf': {
    'label': 'Mushaf',
    'selectedAsset': 'assets/icons/mushaf_selected.svg',
    'unselectedAsset': 'assets/icons/mushaf_unselected.svg',
  },
  'index': {
    'label': 'Index',
    'selectedAsset': 'assets/icons/index_selected.svg',
    'unselectedAsset': 'assets/icons/index_unselected.svg',
  },
  'settings': {
    'label': 'Settings',
    'selectedAsset': 'assets/icons/settings_selected.svg',
    'unselectedAsset': 'assets/icons/settings_unselected.svg',
  },
  'dualpage': {
    'label': 'Dual Page',
    'selectedAsset': 'assets/icons/dualpage_selected.svg',
    'unselectedAsset': 'assets/icons/dualpage_unselected.svg',
  },
  'darkmode': {
    'label': 'Dark Mode',
    'selectedAsset': 'assets/icons/darkmode_selected.svg',
    'unselectedAsset': 'assets/icons/darkmode_unselected.svg',
  },
  'highlighter': {
    'label': 'Highlighter',
    'selectedAsset': 'assets/icons/highlighter_selected.svg',
    'unselectedAsset': 'assets/icons/highlighter_unselected.svg',
  },
};
