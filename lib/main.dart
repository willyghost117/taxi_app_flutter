import 'package:flutter/material.dart';
import 'package:taxi_app/screen/screen.dart'; // Asegúrate de importar tus pantallas correctamente

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Envío de credenciales',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/', // Establece la ruta inicial como '/'
      routes: {
        '/': (context) => const LoginPage(key: null,), // Asigna LoginPage() a la ruta inicial
        'homeLoading': (context) => const HomeLoadingScreen(),
      },
    );
  }
}
