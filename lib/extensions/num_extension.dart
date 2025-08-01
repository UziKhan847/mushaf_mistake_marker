extension NumExtension on num {
  String toArabic() {
    final westernToArabic = {
      '0': '٠',
      '1': '١',
      '2': '٢',
      '3': '٣',
      '4': '٤',
      '5': '٥',
      '6': '٦',
      '7': '٧',
      '8': '٨',
      '9': '٩',
    };

    String result = toString();

    westernToArabic.forEach((latin, arabic) {
      result = result.replaceAll(latin, arabic);
    });

    return result;
  }
}
