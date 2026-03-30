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
}
