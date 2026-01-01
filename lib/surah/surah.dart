class Surah {
  Surah({required this.name, required this.number, required this.numOfVs});

  final String name;
  final int number;
  final int numOfVs;

  static Surah fromJson(Map<String, dynamic> json) => Surah(
    name: json['name'] as String,
    number: json['num'] as int,
    numOfVs: json['totalVrs'] as int,
  );
}
