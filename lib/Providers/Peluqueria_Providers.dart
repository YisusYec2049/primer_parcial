import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:primer_parcial/Models/Peluqueria_Models.dart';

class PeluqueriaProvider {
  final url = Uri.parse("https://www.datos.gov.co/resource/e27n-di57.json");

  Future<List<PeluqueriaModels>> getPeluqueria() async {
    final response = await http.get(url);

    if (response.statusCode == 200) {
      String body = utf8.decode(response.bodyBytes);
      final jsonList = jsonDecode(body);
      final peluqueriasList =
          Peluquerias.fromJsonList(jsonList); // Usar el nombre correcto
      return peluqueriasList
          .items; // Devolver la lista de peluquerías directamente
    } else {
      throw Exception('Ocurrió algo ${response.statusCode}');
    }
  }
}
