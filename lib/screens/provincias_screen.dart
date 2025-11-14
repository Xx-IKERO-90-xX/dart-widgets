import 'package:comarcasgui/models/provincia.dart';
import 'package:comarcasgui/repository/repository_ejemplo.dart';
import 'package:comarcasgui/screens/comarcas_screen.dart';
import 'package:flutter/material.dart';

/* Pantalla ProvinciasScreen: muestra tres CircleAvatar con las distintas provincias */

class ProvinciasScreen extends StatelessWidget {
  const ProvinciasScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Provincias")),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children:
                _creaListaProvincias(RepositoryEjemplo.obtenerProvincias()),
          ),
        ),
      ),
    );
  }
}

List<Widget> _creaListaProvincias(List<Provincia> provincias) {
  List<Widget> lista = [];

  for (Provincia provincia in provincias) {
    lista.add(
      ProvinciaRoundButton(
        nombre: provincia.nombre,
        imagen: provincia.imagen ?? "",
      ),
    );
    lista.add(const SizedBox(height: 20));
  }
  return lista;
}

class ProvinciaRoundButton extends StatelessWidget {
  const ProvinciaRoundButton(
      {required this.imagen, required this.nombre, super.key});

  final String imagen;
  final String nombre;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 220,
      height: 220,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: const CircleBorder(),
          padding: EdgeInsets.zero,
        ),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) => ComarcasScreen(nombre)));
        },
        child: CircleAvatar(
          radius: 110,
          backgroundImage: NetworkImage(imagen),
          child: Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              color: Colors.black54, // Fondo semitransparente para el texto
              child: Text(
                nombre,
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .displayMedium
                    ?.copyWith(color: Colors.white, fontSize: 20),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
