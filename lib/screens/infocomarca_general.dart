import 'package:comarcasgui/repository/repository_ejemplo.dart';
import 'package:comarcasgui/screens/infocomarca_detall.dart';
import 'package:flutter/material.dart';

// Clase principal de pantalla
// Clase principal de pantalla
class InfoComarcaGeneral extends StatelessWidget {

  final String comarcaName;

  InfoComarcaGeneral(this.comarcaName, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          title: const Text("Provincias"),
        ),
        body: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height - kToolbarHeight,
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: InfoComarcaCard(comarcaName: comarcaName),
            ),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          onTap: (index) {
            if (index == 1) {
              // segunda pestaña
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      InfoComarcaDetall(comarcaName: comarcaName),
                ),
              );
            }
          },
          selectedItemColor: Colors.purple,
          unselectedItemColor: Colors.grey,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.info_outline),
              label: "Informació general",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.wb_sunny_outlined),
              label: "Informació detallada",
            ),
          ],
        ));
  }

  void setState(InfoComarcaDetall Function() param0) {}
}

// Tarjeta de información
class InfoComarcaCard extends StatelessWidget {
  final String comarcaName;

  const InfoComarcaCard({required this.comarcaName, super.key});

  @override
  Widget build(BuildContext context) {
    final comarca = RepositoryEjemplo.obtenerInfoComarca(comarcaName);

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            comarca?.img ??
                "https://via.placeholder.com/400x180.png?text=No+Image",
            width: double.infinity,
            height: 250,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => Container(
              height: 250,
              color: Colors.grey,
              alignment: Alignment.center,
              child: const Text("Imagen no disponible"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  comarcaName,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 10),
                Text(
                  comarca?.desc ?? "Sin descripción disponible",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
