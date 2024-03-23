import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


Future<void> enviarCredenciales(String username, String password, BuildContext context) async {
    final url = Uri.parse('http://10.147.17.64:8000/user/api/token/');
    print("Me ejecute_______________________________________________________________");
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

}

