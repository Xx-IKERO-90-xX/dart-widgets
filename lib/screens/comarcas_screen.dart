import 'package:comarcasgui/repository/repository_ejemplo.dart';
import 'package:comarcasgui/screens/infocomarca_general.dart' hide RepositoryEjemplo;
import 'package:flutter/material.dart';

class ComarcasScreen extends StatelessWidget {
  final String nombre; // ✅ Propiedad final

  const ComarcasScreen(this.nombre, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Comarcas")),
      body: Center(
        child: _creaListaComarcas(
          RepositoryEjemplo.obtenerComarcas(nombre),
        ),
      ),
    );
  }

  Widget _creaListaComarcas(List<dynamic> comarques) {
    return ListView.builder(
      itemCount: comarques.length,
      itemBuilder: (context, index) {
        final c = comarques[index];
        return ComarcaCard(
          comarca: c['nom'] ?? "",
          img: c['img'] ?? "",
        );
      },
    );
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
            Navigator.push(context, MaterialPageRoute(builder:(context) => InfoComarcaGeneral(comarca)));
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
                    style: TextStyle(
                      fontFamily: 'Black Arial',
                      fontSize: 40,
                      color: Colors.white.withOpacity(0.7),
                      shadows: [
                        Shadow(
                          blurRadius: 0.6,
                          color: Colors.black.withOpacity(0.7),
                          offset: const Offset(2, 2),
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
