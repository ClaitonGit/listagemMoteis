import 'categoriaItem.dart';
import 'itens.dart';

class Suite {
  final String nome;
  final List<String> fotos;
  final List<Itens> itens;
  final List<CategoriaItem> categoriaItens;
  final List<Map<String, dynamic>> periodos;

  Suite({
    required this.nome,
    required this.fotos,
    required this.itens,
    required this.categoriaItens,
    required this.periodos,
  });

  factory Suite.fromJson(Map<String, dynamic> json) {
    return Suite(
      nome: json['nome'] ?? 'Sem nome',
      fotos: List<String>.from(json['fotos'] ?? []),
      itens: (json['itens'] as List<dynamic>?)
          ?.map((item) => Itens.fromJson(item))
          .toList() ?? [],
      categoriaItens: (json['categoriaItens'] as List<dynamic>?)
          ?.map((item) => CategoriaItem.fromJson(item))
          .toList() ?? [],
      periodos: List<Map<String, dynamic>>.from(json['periodos'] ?? []),
    );
  }
}
