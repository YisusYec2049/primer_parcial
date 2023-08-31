import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:primer_parcial/Models/Peluqueria_Models.dart';

class PeluqueriaProvider {
  // URL de la fuente de datos de peluquerías
  final url = Uri.parse("https://www.datos.gov.co/resource/e27n-di57.json");

  // Método para obtener la lista de peluquerías
  Future<List<PeluqueriaModels>> getPeluqueria() async {
    final response = await http.get(url); // Realizar la solicitud HTTP

    if (response.statusCode == 200) {
      // Si la solicitud fue exitosa (código 200)
      String body = utf8.decode(response.bodyBytes);
      final jsonList = jsonDecode(body); // Decodificar el JSON
      final peluqueriasList = Peluquerias.fromJsonList(jsonList);
      return peluqueriasList
          .items; // Devolver la lista de peluquerías directamente
    } else {
      // Si hubo un error en la solicitud, lanzar una excepción con el código de error
      throw Exception('Ocurrió algo ${response.statusCode}');
    }
  }
}
