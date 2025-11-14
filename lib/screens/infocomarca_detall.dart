import 'package:comarcasgui/models/comarca.dart';
import 'package:comarcasgui/repository/repository_ejemplo.dart';
import 'package:comarcasgui/screens/infocomarca_general.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter/material.dart';
import 'package:comarcasgui/screens/widgets/my_weather_info.dart';

class InfoComarcaDetall extends StatelessWidget {
  final String comarcaName;

  const InfoComarcaDetall({required this.comarcaName, super.key});

  get bottomNavigationBar => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Provincias")),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [ComarcaDetallContent(comarcaName: comarcaName)],
            ),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
            currentIndex: 1, // 0 = general, 1 = detallada
            onTap: (index) {
              if (index == 0) {
                // Si toca "Información general"
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => InfoComarcaGeneral(comarcaName),
                  ),
                );
              }
            },
            unselectedItemColor: Colors.grey,
            selectedItemColor: Colors.purple,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.info_outline),
                label: "Información general",
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.wb_sunny_outlined),
                  label: "Información detallada")
            ]));
  }
}

class ComarcaDetallContent extends StatelessWidget {
  final String comarcaName;

  const ComarcaDetallContent({
    required this.comarcaName,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Comarca? comarca = RepositoryEjemplo.obtenerInfoComarca(comarcaName);

    if (comarca == null) {
      return Center(child: Text("No se encontró información de la comarca"));
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const MyWeatherInfo(),
          const SizedBox(height: 16),

          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Población:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                Text(comarca.poblacion.toString(), style: const TextStyle(fontSize: 16)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Latitud:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                Text(comarca.latitud.toString(), style: const TextStyle(fontSize: 16)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Longitud:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                Text(comarca.longitud.toString(), style: const TextStyle(fontSize: 16)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
