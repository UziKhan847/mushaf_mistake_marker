extension StringExtension on String {
  String get verticalText => split('').join('\n');

  String get toQuranAudioUrl {
    final match = RegExp(r's(\d+)v(\d+)w(\d+)').firstMatch(split('_').first);
    if (match == null) throw FormatException('Invalid word ID: $this');

    final s = match.group(1)!.padLeft(3, '0');
    final v = match.group(2)!.padLeft(3, '0');
    final w = match.group(3)!.padLeft(3, '0');

    return 'https://audio.qurancdn.com/wbw/${s}_${v}_$w.mp3';
  }

  //Arabic Search Related
  static final diacritics = RegExp(
    r'[\u0610-\u061A\u064B-\u065F\u0670\u06D6-\u06ED\u06E9-\u06EF]',
  );

  static final diacriticsWithoutSmallMaddLetters = RegExp(
    r'[\u0610-\u061A\u064B-\u065F\u06D6-\u06E4\u06E7-\u06ED\u06E9-\u06EF]',
  );

  static final tatweel = RegExp(r'\u0640');

  static final punctuation = RegExp(
    r'''[۞،\u061F\.,;:\-\(\)\[\]\{\}"""\'«»—–…!?؛:]''',
  );

  String get removeTaskhil => replaceAll(diacritics, '')
      .replaceAll(tatweel, '')
      .replaceAll(punctuation, ' ')
      .replaceAll(RegExp(r'[أإآٱ]'), 'ا')
      .replaceAll('ة', 'ه')
      .replaceAll('ى', 'ي')
      .replaceAll('ؤ', 'و')
      .replaceAll('ئ', 'ي')
      .replaceAll(RegExp(r'\s+'), ' ')
      .trim();

  String get removeTaskhilExceptSmallMaddLetters {
    var s = replaceAll(
      diacriticsWithoutSmallMaddLetters,
      '',
    ).replaceAll(tatweel, '').replaceAll(punctuation, ' ');

    final List<int> out = [];

    for (final r in s.runes) {
      switch (r) {
        case 0x06E5: // small waw
          out.add(0x0648);
        case 0x06E6: // small ya
          out.add(0x064A);
        case 0x0670: // superscript alef
          if (out.isNotEmpty && out.last == 0x0648) {
            // waw + superscript alef → alef (Quranic spelling convention)
            out.removeLast();
          }
          out.add(0x0627);
        default:
          out.add(r);
      }
    }

    return String.fromCharCodes(out)
        .replaceAll(RegExp(r'[أإآٱ]'), 'ا')
        .replaceAll('ة', 'ه')
        .replaceAll('ى', 'ي')
        .replaceAll('ؤ', 'و')
        .replaceAll('ئ', 'ي')
        .replaceAll(RegExp(r'\s+'), ' ')
        .trim();
  }
}
