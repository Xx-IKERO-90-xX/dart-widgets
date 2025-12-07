import 'package:comarcasgui/models/comarca.dart';
import 'package:comarcasgui/screens/infocomarca_detall.dart';
import 'package:flutter/material.dart';
import 'package:comarcasgui/repository/comarcas_repository.dart';

// Clase principal de pantalla
class InfoComarcaGeneral extends StatelessWidget {
  final String comarcaName;

  InfoComarcaGeneral(this.comarcaName, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text("Comarca"),
      ),
      body: FutureBuilder<Comarca?>(
          future: ComarcasRepository().getInfoComarca(comarcaName),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }

            final comarca = snapshot.data!;

            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight:
                      MediaQuery.of(context).size.height - kToolbarHeight,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: InfoComarcaCard(comarca: comarca),
                ),
              ),
            );
          }),
    );
  }

  void setState(InfoComarcaDetall Function() param0) {}
}

// Tarjeta de información
class InfoComarcaCard extends StatelessWidget {
  final Comarca comarca;

  const InfoComarcaCard({required this.comarca, super.key});

  @override
  Widget build(BuildContext context) {
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
                  comarca.comarca,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 10),
                Text(comarca.desc ?? "Sin descripción disponible",
                    textAlign: TextAlign.justify),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
