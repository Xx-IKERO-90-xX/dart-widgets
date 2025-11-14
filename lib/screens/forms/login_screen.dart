import 'package:comarcasgui/screens/provincias_screen.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String? correo;
  String? contrasena;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Comarcas")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Center(
                child: Text('Login',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    )),
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Correo'),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Por favor, ingrese el correo";
                  }
                  if (!value.contains("@")) {
                    return "Ingrese un correo válido.";
                  }
                  if (value != 'ikero90@gmail.com') {
                    return "Correo no reconocido";
                  }
                  return null;
                },
                onSaved: (value) => correo = value,
              ),
              const SizedBox(height: 10),
              TextFormField(
                decoration: const InputDecoration(labelText: "Contraseña"),
                keyboardType: TextInputType.visiblePassword,
                obscureText: true, // oculta la contraseña
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Tienes que introducir la contraseña";
                  }
                  if (value != "ikero8080") {
                    return "Contraseña Incorrecta";
                  }
                  return null;
                },
                onSaved: (value) => contrasena = value,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    // Si pasa la validación, navega a ProvinciasScreen
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ProvinciasScreen(),
                      ),
                    );
                  } else {
                    // Muestra un SnackBar si el login es incorrecto
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Correo o contraseña incorrectos"),
                        duration: Duration(seconds: 2),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
                child: const Text("Iniciar Sesión"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
