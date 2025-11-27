import 'dart:convert'; // Para realizar conversiones entre tipos de datos
import 'dart:io';
import 'package:comarcasgui/models/comarca.dart';
import 'package:comarcasgui/models/provincia.dart';
import 'package:http/http.dart' as http;

class ComarcasService {
  static Future<List<Provincia>> obtenerProvincias() async {
    // Obtiene la lista de provincias
    try {
      String url =
          "https://node-comarques-rest-server-production.up.railway.app/api/comarques/provincies";
      var data = await http.get(Uri.parse(url));

      // Preparamos la lista de provincias a devolver
      List<Provincia> listaProvincias = [];

      if (data.statusCode == 200) {
        String body = utf8.decode(data.bodyBytes);
        final bodyJSON = jsonDecode(body) as List;

        listaProvincias = bodyJSON.map((provinciaJSON) {
          return Provincia(
            nombre: provinciaJSON["provincia"],
            imagen: provinciaJSON["img"],
          );
        }).toList();
      }
      // Finalmente devolvemos la lista
      return listaProvincias;
    } catch (except) {
      print(except.toString());
      return [];
    }
  }

  static Future<List<dynamic>> obtenerComarcas(String provincia) async {
    String url =
        "https://node-comarques-rest-server-production.up.railway.app/api/comarques/comarquesAmbImatge/$provincia";
    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var output = jsonDecode(response.body);
      return output;
    } else {
      throw Exception('Error al obtener la comarca: ${response.statusCode}');
    }
  }

  static Future<Comarca?> infoComarca(String comarca) async {
    final url = Uri.parse(
        "https://node-comarques-rest-server-production.up.railway.app/api/comarques/infoComarca/$comarca");

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      return Comarca.fromJSON(jsonData);
    } else {
      throw Exception('Error: ${response.statusCode}');
    }
  }
}
