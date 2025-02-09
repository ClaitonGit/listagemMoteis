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
      appBar: AppBar(
        title: const Text('Ir agora '),
      ),
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

                   SizedBox(height: 16),
                  const Text(
                    'Suítes:',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
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
                            Card(
                              color: Colors.white, // Fundo branco do Card
                              elevation: 3, // Sombra suave para destaque
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10), // Bordas arredondadas
                              ),
                              child: ExpansionTile(
                                backgroundColor: Colors.white,
                                collapsedBackgroundColor: Colors.white,
                                title: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const SizedBox(width: 8),
                                    const Text(
                                      'Itens:',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                                children: suite.itens.map((item) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Text(
                                      '${item['nome']}',
                                      textAlign: TextAlign.left,
                                      style: const TextStyle(fontSize: 13, color: Colors.black87),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),

                            const SizedBox(height: 8),
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
                                      Icon(
                                        Icons.access_time,
                                        color: Colors.black26,
                                      ),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        child: Text(
                                          ' ${periodo['tempoFormatado']}: R\$ ${periodo['valorTotal']}',
                                          style: TextStyle(
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
      child: PageView.builder(
        itemCount: imagens.length,
        itemBuilder: (context, index) {
          print("Carregando imagem: ${imagens[index]}");
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
    );
  }
}
