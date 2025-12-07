import 'package:comarcasgui/models/comarca.dart';
import 'package:comarcasgui/repository/repository_ejemplo.dart';
import 'package:flutter/material.dart';
import 'package:comarcasgui/screens/widgets/my_weather_info.dart';

class InfoComarcaDetall extends StatelessWidget {
  final String comarcaName;

  const InfoComarcaDetall({required this.comarcaName, super.key});

  get bottomNavigationBar => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Comarca")),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [ComarcaDetallContent(comarcaName: comarcaName)],
          ),
        ),
      ),
    );
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
                const Text('Población:',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                Text(comarca.poblacion.toString(),
                    style: const TextStyle(fontSize: 16)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Latitud:',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                Text(comarca.latitud.toString(),
                    style: const TextStyle(fontSize: 16)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Longitud:',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                Text(comarca.longitud.toString(),
                    style: const TextStyle(fontSize: 16)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
