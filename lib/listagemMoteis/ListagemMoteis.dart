import 'package:flutter/material.dart';
import '../models/motel.dart';
import '../services/motel_service.dart';

class Listagemmoteis extends StatefulWidget {
  const Listagemmoteis({super.key});

  @override
  State<Listagemmoteis> createState() => _ListagemmoteisState();
}

class _ListagemmoteisState extends State<Listagemmoteis> {
  late Future<Motel> futureMotel;

  @override
  void initState() {
    super.initState();
    futureMotel = MotelService().fetchMotel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ir agora')),
      body: FutureBuilder<Motel>(
        future: futureMotel,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro: ${snapshot.error}'));
          } else if (snapshot.data == null) {
            return const Center(child: Text('Nenhum dado encontrado'));
          } else {
            Motel motel = snapshot.data!;
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Card do Motel
                  Card(
                    margin: const EdgeInsets.all(8),
                    elevation: 4,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              motel.logo,
                              width: 80,
                              height: 80,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                              const Icon(Icons.broken_image, size: 80),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  motel.fantasia,
                                  style: const TextStyle(
                                    fontSize: 19,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Bairro: ${motel.bairro}',
                                  style: const TextStyle(fontSize: 16),
                                ),
                                Text(
                                  'Distância: ${motel.distancia} km',
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),
                  const Text(
                    'Suítes:',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),

                  // Listagem das suítes
                  ...motel.suites.map((suite) {
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 8),

                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              suite.nome,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            ImageSlider(imagens: suite.fotos),
                            const SizedBox(height: 8),

                            // Itens com Ícones
                            // Card dos Itens da Suíte
                            Card(
                              color: Colors.white,
                              elevation: 3,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: ExpansionTile(
                                title: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const SizedBox(width: 8),
                                    const Text(
                                      'Itens da Suíte:',
                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                    ),
                                  ],
                                ),
                                children: suite.categoriaItens.isEmpty && suite.itens.isEmpty
                                    ? [const Padding(padding: EdgeInsets.all(8), child: Text("Nenhum item disponível"))]
                                    : [
                                  Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Wrap(
                                      spacing: 16,
                                      runSpacing: 8,
                                      alignment: WrapAlignment.center,
                                      children: suite.categoriaItens.map((categoria) {
                                        return Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Image.network(
                                              categoria.icone,
                                              width: 40,
                                              height: 40,
                                              errorBuilder: (context, error, stackTrace) => const Icon(Icons.error, size: 40),
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              categoria.nome,
                                              style: const TextStyle(fontSize: 12),
                                            ),
                                          ],
                                        );
                                      }).toList(),
                                    ),
                                  ),

                                  // Outros Itens
                                  if (suite.itens.isNotEmpty) ...[
                                    const Divider(),
                                    const Padding(
                                      padding: EdgeInsets.symmetric(vertical: 8),
                                      child: Text(
                                        'Tem também:',
                                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 8),
                                      child: Wrap(
                                        spacing: 8,
                                        runSpacing: 4,
                                        alignment: WrapAlignment.center,
                                        children: suite.itens.map((item) {
                                          return Chip(
                                            label: Text(
                                              item.nome,
                                              style: const TextStyle(fontSize: 10),
                                            ),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                            ),


                            const SizedBox(height: 8),

                            // Períodos
                            const Text(
                              'Períodos:',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 8),

                            ...suite.periodos.map((periodo) {
                              return Card(
                                color: Colors.white,
                                elevation: 3,
                                margin: const EdgeInsets.symmetric(vertical: 6),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      const Icon(Icons.access_time, color: Colors.black26),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        child: Text(
                                          ' ${periodo['tempoFormatado']}: R\$ ${periodo['valorTotal']}',
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }).toList(),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}

/// Classe para exibir imagens em um slider horizontal
class ImageSlider extends StatelessWidget {
  final List<String> imagens;

  const ImageSlider({super.key, required this.imagens});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          PageView.builder(
            itemCount: imagens.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    imagens[index],
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.error, size: 100),
                  ),
                ),
              );
            },
          ),
          Positioned(
            bottom: 8,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                imagens.length,
                    (index) => Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
