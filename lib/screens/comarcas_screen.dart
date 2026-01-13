import 'package:comarcasgui/provider/comarcas_provider.dart';
import 'package:comarcasgui/screens/infocomarca_general.dart';
import 'package:comarcasgui/repository/comarcas_repository.dart';
import 'package:flutter/material.dart';
import 'package:comarcasgui/screens/Navbars/ComarcaBottomNavbar.dart';
import 'package:provider/provider.dart';

class ComarcasScreen extends StatelessWidget {
  final String nombre; // ✅ Propiedad final

  const ComarcasScreen(this.nombre, {super.key});

  @override
  Widget build(BuildContext context) {
    var comarcasProvider = Provider.of<ComarcasProvider>(context);
    comarcasProvider.provinciaActual = nombre;

    return Scaffold(
      appBar: AppBar(title: const Text("Comarcas")),
      body: FutureBuilder<List<dynamic>>(
          future: ComarcasRepository().getComarcas(nombre),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }
            return Center(
              child: _creaListaComarcas(comarcasProvider.listaComarcas ?? []),
            );
          }),
    );
  }

  Widget _creaListaComarcas(List<dynamic> comarques) {
    if (comarques.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    } else {
      return ListView.builder(
        itemCount: comarques.length,
        itemBuilder: (context, index) {
          if (comarques.isNotEmpty) {
            final c = comarques[index];
            return ComarcaCard(
              comarca: c['nom'] ?? "",
              img: c['img'] ?? "",
            );
          } else {
            return const Center(child: Text("La lista está vacía."));
          }
        },
      );
    }
  }
}

class ComarcaCard extends StatelessWidget {
  // Este widget recibirá dos argumentos con nombre para construirse:
  // la imagen (img) y el nombre de la comarca (comarca)
  const ComarcaCard({
    super.key,
    required this.img,
    required this.comarca,
  });

  final String img;
  final String comarca;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 5,
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ComarcaBottomNavigarion(
                          comarcaName: comarca,
                        )));
          },
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Imagen de fondo
              Image.network(
                img,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey,
                    child: const Icon(Icons.image_not_supported, size: 50),
                  );
                },
              ),

              // Capa de texto superpuesta
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(vertical: 30, horizontal: 35),
                  child: Text(
                    comarca.isEmpty ? "Comarca sin nombre" : comarca,
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      fontFamily: 'LeckerliOne',
                      fontSize: 40,
                      color: Colors.white,
                      shadows: [
                        Shadow(
                          blurRadius: 0.6,
                          color: Colors.black,
                          offset: Offset(2, 2),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
