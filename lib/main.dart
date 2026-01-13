import 'package:comarcasgui/provider/comarcas_provider.dart';
import 'package:comarcasgui/screens/forms/login_screen.dart';
import 'package:comarcasgui/themes/tema_comarcas.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (BuildContext context) => ComarcasProvider(),
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Material App',
            theme: temaComarcas,
            home: LoginScreen()));
  }
}
