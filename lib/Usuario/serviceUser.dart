import 'dart:async';
import 'dart:convert';

import 'package:bikeshared/constantes/shered_preference.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ServiceResisterUser {
  Future<http.Response> saveUser(int pontos, int is_admin, String name,
      String email, String password, BuildContext context) async {
    //header
    Map<String, String> headers = {"Content-Type": "application/json"};
    //body
    Map data = {
      'pontos': '$pontos',
      'is_admin': '$is_admin',
      'name': '$name',
      'email': '$email',
      'password': '$password'
    };
    var uri = Uri.parse(MySharedPreferences.ip + "/estacao1/register");
//convert the above data into json
    var body = json.encode(data);
    var response = await http.post(uri, headers: headers, body: body);

    print(response.body);
    if (response.body == "Usuário Registado Com Sucesso") {
      exibirMensagem("Usuário Registado Com Sucesso", context);
      /*/Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => HomePage()),
      );*/
    } else if (response.body == "Usuário já registado com esse email.") {
      exibirMensagem("Usuário já registado com esse email.", context);
    } else if (response.body == "E-mail inválido.") {
      exibirMensagem("E-mail inválido.", context);
    } else {
      print('Erro durante o Registo');
    }
    return response;
  }

  void exibirMensagem(String mensagem, BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Mensagem'),
          content: Text(mensagem),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
