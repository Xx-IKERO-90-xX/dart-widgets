import 'package:comarcasgui/models/provincia.dart';
import 'package:comarcasgui/screens/comarcas_screen.dart';
import 'package:comarcasgui/repository/comarcas_repository.dart';
import 'package:flutter/material.dart';

/* Pantalla ProvinciasScreen: muestra tres CircleAvatar con las distintas provincias */

class ProvinciasScreen extends StatelessWidget {
  const ProvinciasScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Provincias")),
        body: FutureBuilder<List<dynamic>>(
          future: ComarcasRepository().getProvincias(),
          builder:
              (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }

            final provincias = snapshot.data!;

            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: _creaListaProvincias(provincias),
            );
          },
        ));
  }
}

List<Widget> _creaListaProvincias(List<dynamic> provincias) {
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
    return Center(
      child: SizedBox(
        width: 220,
        height: 220,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: const CircleBorder(),
            padding: EdgeInsets.zero,
          ),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (_) => ComarcasScreen(nombre)));
          },
          child: CircleAvatar(
            radius: 110,
            backgroundImage: NetworkImage(imagen),
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: Text(nombre,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontFamily: 'leckerliOne',
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontSize: 30,
                        shadows: [
                          Shadow(
                            blurRadius: 4,
                            color: Colors.black,
                            offset: Offset(2, 2),
                          ),
                        ])),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
