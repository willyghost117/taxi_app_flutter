import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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
      initialRoute: '/',
      routes: {
        '/': (context) => LoginPage(),
        'homeLoading': (context) => const HomeLoadingScreen(),
      },
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

  Future<void> enviarCredenciales(String username, String password, BuildContext context) async {
    final url = Uri.parse('http://10.147.17.64:8000/user/api/token/');
    setState(() {
      isLoading = true;
    });
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'username': username, 'password': password}),
    );

    if (response.statusCode == 200) {
      print('Token recibido: ${jsonDecode(response.body)}');
      final Map<String, dynamic> tokens = jsonDecode(response.body);
      Navigator.pushReplacementNamed(context, 'homeLoading', arguments: tokens);
    } else {
      print('Error: ${response.reasonPhrase}');
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: usernameController,
              decoration: const InputDecoration(labelText: 'Usuario'),
            ),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Contraseña'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: isLoading
                  ? null
                  : () {
                      enviarCredenciales(
                        usernameController.text,
                        passwordController.text,
                        context,
                      );
                    },
              child: isLoading
                  ? CircularProgressIndicator()
                  : const Text('Iniciar sesión'),
            ),
          ],
        ),
      ),
    );
  }
}

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
