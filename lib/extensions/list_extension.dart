extension MergeMaps<K, V> on List<Map<K, V>> {
  Map<K, V> toCombinedMap() => Map<K, V>.fromEntries(expand((m) => m.entries));
}
