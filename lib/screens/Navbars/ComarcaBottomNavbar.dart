import 'package:flutter/material.dart';
import 'package:comarcasgui/screens/infocomarca_detall.dart';
import 'package:comarcasgui/screens/infocomarca_general.dart';

class ComarcaBottomNavigarion extends StatefulWidget {
  final String comarcaName;

  const ComarcaBottomNavigarion({
    Key? key,
    required this.comarcaName,
  }) : super(key: key);

  @override
  State<ComarcaBottomNavigarion> createState() =>
      _ExempleBottomNavigationBarState();
}

class _ExempleBottomNavigationBarState extends State<ComarcaBottomNavigarion> {
  int indexActual = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            indexActual = index;
          });
        },
        selectedIndex: indexActual,
        destinations: const <Widget>[
          NavigationDestination(
            icon: Icon(Icons.info_outline),
            selectedIcon: Icon(Icons.info),
            label: 'Información General',
          ),
          NavigationDestination(
            icon: Icon(Icons.wb_sunny_outlined),
            selectedIcon: Icon(Icons.sunny),
            label: 'Información Detallada',
          ),
        ],
      ),
      body: <Widget>[
        Container(
          color: Colors.amber,
          alignment: Alignment.center,
          child: InfoComarcaGeneral(widget.comarcaName),
        ),
        Container(
          color: Colors.lime,
          alignment: Alignment.center,
          child: InfoComarcaDetall(comarcaName: widget.comarcaName),
        ),
      ][indexActual],
    );
  }
}
