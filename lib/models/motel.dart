import 'suite.dart';

class Motel {
  final String fantasia;
  final String logo;
  final String bairro;
  final double distancia;
  final List<Suite> suites;

  Motel({
    required this.fantasia,
    required this.logo,
    required this.bairro,
    required this.distancia,
    required this.suites,
  });

  factory Motel.fromJson(Map<String, dynamic> json) {
    var suitesList = json['suites'] as List? ?? [];
    List<Suite> suites = suitesList.map((i) => Suite.fromJson(i)).toList();

    return Motel(
      fantasia: json['fantasia'] ?? '',
      logo: json['logo'] ?? '',
      bairro: json['bairro'] ?? '',
      distancia: (json['distancia'] ?? 0).toDouble(),
      suites: suites,
    );
  }
}
