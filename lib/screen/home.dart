import 'package:flutter/material.dart';


class HomeLoadingScreen extends StatelessWidget {
  const HomeLoadingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> tokens = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Loading'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Has iniciado sesión. Bienvenido!'),
            const SizedBox(height: 20),
            Text('Token de actualización: ${tokens['refresh']}'),
            const SizedBox(height: 20),
            Text('Token de acceso: ${tokens['access']}'),
          ],
        ),
      ),
    );
  }
}