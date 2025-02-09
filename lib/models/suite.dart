class Suite {
  final String nome;
  final List<String> fotos;
  final List<Map<String, dynamic>> itens;
  final List<Map<String, dynamic>> periodos;

  Suite({
    required this.nome,
    required this.fotos,
    required this.itens,
    required this.periodos,
  });

  factory Suite.fromJson(Map<String, dynamic> json) {
    return Suite(
      nome: json['nome'] ?? 'Sem nome',
      fotos: List<String>.from(json['fotos'] ?? []),
      itens: List<Map<String, dynamic>>.from(json['itens'] ?? []),
      periodos: List<Map<String, dynamic>>.from(json['periodos'] ?? []),
    );
  }
}
