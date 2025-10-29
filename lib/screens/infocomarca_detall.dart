import 'package:comarcasgui/models/comarca.dart';
import 'package:comarcasgui/repository/repository_ejemplo.dart';
import 'package:flutter/material.dart';
import 'package:comarcasgui/screens/widgets/my_weather_info.dart';

class InfoComarcaDetall extends StatelessWidget {
  const InfoComarcaDetall({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Comarca comarca = RepositoryEjemplo.obtenerInfoComarca();

    // TO-DO
    // Añadir la información siguiente sobre la comarca:
    // Población (num. de habitantes), latitud y longitud.
    // Podéis combinar Column y Row para mostrar la información tabulada
    // Antes de la información, deberemos mostrar la información sobre el tiempo en la comarca,
    // mediante el widtget personalizado MyWeatherInfo(), que se os proporciona ya implementado
    return Scaffold(
      appBar: AppBar(title: Text("Info Comarca")),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MyWeatherInfo(),
              
            ],
          ),
        ),
      ),
    );
  }
}
