import 'dart:convert';

import 'package:bikeshared/constantes/shered_preference.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../home_widgets/home_pricipalpage.dart';

class ServiceLogin {
  Future<void> login(
      String email, String password, BuildContext context) async {
    // Header
    Map<String, String> headers = {"Content-Type": "application/json"};

    // Corpo da solicitação
    Map data = {
      'email': email,
      'password': password,
    };

    // Convertendo os dados para JSON
    var body = json.encode(data);

    // Enviando a solicitação POST para o endpoint de login
    var uri = Uri.parse(MySharedPreferences.ip + "/estacao1/login");
    var response = await http.post(uri, headers: headers, body: body);
    print(response.body);

    // Verificando a resposta do servidor
    if (response.statusCode == 200) {
      // Se as credenciais forem válidas, armazene o ID da sessão e navegue para a próxima tela
      var sessionId = response.body;

      await saveSessionId(sessionId);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MenuPrincipal()),
      );
    } else if (response.statusCode == 401) {
      // Se as credenciais forem inválidas, exiba um diálogo de erro
      _showMyDialog(context);
    } else {
      // Caso contrário, exiba uma mensagem de erro no console
      print('Erro durante o login');
    }
  }

  // Método para exibir um diálogo de erro
  void _showMyDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Row(
            children: [
              Icon(Icons.error, color: Colors.red),
              SizedBox(width: 8),
              Text('Aviso'),
            ],
          ),
          content: Text('Credenciais inválidas'),
          actions: [
            TextButton(
              onPressed: () {
                // Ao pressionar o botão "OK", volte para a tela de login
                Navigator.pop(context);
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  // Método para salvar o ID da sessão localmente
  Future<void> saveSessionId(String sessionId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('sessionId', sessionId);
  }
}
