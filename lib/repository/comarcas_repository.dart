import 'package:comarcasgui/models/comarca.dart';
import 'package:comarcasgui/services/comarcas_service.dart';

class ComarcasRepository {
  Future<List<dynamic>> getProvincias() => ComarcasService.obtenerProvincias();

  Future<List<dynamic>> getComarcas(String provincia) =>
      ComarcasService.obtenerComarcas(provincia);

  Future<Comarca?> getInfoComarca(String comarca) =>
      ComarcasService.infoComarca(comarca);
}
