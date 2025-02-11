class Itens {
  final String nome;

  Itens({required this.nome});

  factory Itens.fromJson(Map<String, dynamic> json) {
    return Itens(
      nome: json['nome'] ?? 'Sem nome',
    );
  }
}
