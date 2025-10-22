import 'package:comarcasgui/repository/repository_ejemplo.dart';
import 'package:flutter/material.dart';

class ComarcasScreen extends StatelessWidget {
  const ComarcasScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          // Proporciona a _creaLlistaComarques la lista de comarcas de Alacant
          child: _creaListaComarcas(RepositoryEjemplo.obtenerComarcas())), ////
    );
  }

  _creaListaComarcas(List<dynamic> comarques) {
    // Recibimos la lista de JSON con el nombre y la imagen (img) de cada comarca
    return ListView.builder(
        itemCount: comarques.length,
        itemBuilder: (context, index) {
          final c = comarques[index];
          return ComarcaCard(
            comarca: c['nom'] ?? "",
            img: c['img'] ?? "",
          );
        });
    // TO-DO
    // Debemos utilizar un ListView.builder para recorrer la lista de comarcas
    // y generar un widget personalizado de tipo ComarcaCard, con la imagen y el nombre.
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
    // TO-DO
    // Devuelve un widget de tipo Card, con el diseño que desees, pero
    // que muestre la imagen  (obtenida de Internet a partir de la url)
    // y el nombre de la comarca.
    return SizedBox(
      height: 180,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 5,
        clipBehavior:
            Clip.antiAlias, // <- importante para que los bordes se recorten
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
                  child: Icon(Icons.image_not_supported, size: 50),
                );
              },
            ),

            // Capa de texto superpuesta
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: double.infinity, // fondo semitransparente
                padding: EdgeInsets.symmetric(vertical: 30, horizontal: 35),
                child: Text(
                  comarca.isEmpty ? "Comarca sin nombre" : comarca,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontFamily: 'Black Arial',
                    fontSize: 40,
                    color: const Color.fromARGB(255, 255, 255, 255).withOpacity(0.7),
                    shadows: [
                      Shadow(
                        blurRadius: 0.6,
                        color: Colors.black.withOpacity(0.7), // color de sombra
                        offset: Offset(2, 2),
                      )
                    ]
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
