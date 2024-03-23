import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<bool> registrarUsuario(String username, String email, String password, String password2, BuildContext context) async {
  final url = Uri.parse('http://10.147.17.64:8000/user/register/');

  final response = await http.post(
    url,
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({
      'username': username,
      'email': email,
      'password': password,
      'password2': password2,
    }),
  );

  if (response.statusCode == 200) {
    final responseData = json.decode(response.body);
    final message = responseData['response']; // Mensaje de respuesta del servidor

    if (message != null && message == 'El registro del usuario fue exitoso') {
      print('Usuario registrado exitosamente');
      return true;
    } else {
      print('Error al registrar usuario: $message');
      return false;
    }
  } else if (response.statusCode == 400) {
    final responseData = json.decode(response.body);
    final errorMessage = responseData['username']; // Mensaje de error específico para nombre de usuario existente

    if (errorMessage != null && errorMessage.contains("A user with that username already exists")) {
      print('Error al registrar usuario: El nombre de usuario ya existe');
      return false;
    } else {
      print('Error al registrar usuario: ${response.reasonPhrase}');
      return false;
    }
  } else {
    print('Error al registrar usuario: ${response.reasonPhrase}');
    return false;
  }
}
