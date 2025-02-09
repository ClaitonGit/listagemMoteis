import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/motel.dart';

class MotelService {
  final String url = "https://thingproxy.freeboard.io/fetch/https://jsonkeeper.com/b/1IXK";

  Future<Motel> fetchMotel() async {
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = json.decode(response.body);
        return Motel.fromJson(jsonResponse['data']['moteis'][0]);
      } else {
        throw Exception('Erro ao carregar os dados: Código ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Erro de conexão: $e');
    }
  }
}
