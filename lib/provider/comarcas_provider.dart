import 'package:flutter/foundation.dart';
import 'package:comarcasgui/models/comarca.dart';
import 'package:comarcasgui/models/provincia.dart';
import 'package:comarcasgui/repository/comarcas_repository.dart';

class ComarcasProvider with ChangeNotifier {
  String? _provinciaActual;
  List<dynamic>? listaComarcas;
  String? _nombreComarcaActual;
  Comarca? comarcaActual;
  List<Provincia>? provincias;

  ComarcasProvider() {
    _cargarProvincias();
  }

  set provinciaActual(String provincia) {
    if (_provinciaActual == null || _provinciaActual != provincia) {
      listaComarcas = null;
      _provinciaActual = provincia;

      _cargarComarcas(provincia);
    }
  }

  String get nombreComarcaActual {
    return _nombreComarcaActual ?? "";
  }

  set nombreComarcaActual(String comarca) {
    if (_nombreComarcaActual == null || _nombreComarcaActual != comarca) {
      _nombreComarcaActual = comarca;
      _cargarComarca(comarca);
    }
  }

  void _cargarProvincias() async {
    provincias = (await ComarcasRepository().getProvincias()).cast<Provincia>();
    notifyListeners();
  }

  void _cargarComarcas(String provincia) async {
    List<dynamic> jsonComarcas =
        await ComarcasRepository().getComarcas(provincia);
    listaComarcas = jsonComarcas;
    notifyListeners();
  }

  void _cargarComarca(String comarca) async {
    comarcaActual = await ComarcasRepository().getInfoComarca(comarca);
    notifyListeners();
  }
}
