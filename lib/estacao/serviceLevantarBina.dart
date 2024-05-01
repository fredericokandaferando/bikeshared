import 'package:bikeshared/constantes/shered_preference.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'dart:async';

Future<void> levantarBicicleta(
    String userEmail, int stationId, BuildContext context) async {
  final String url =
      MySharedPreferences.ip + "/estacao/$userEmail/bike/$stationId";

  final response = await http.post(Uri.parse(url));
  print(response.body);
  if (response.body == "Bicicleta levantada com sucesso!") {
    exibirMensagem("Bicicleta levantada com sucesso!", context);
  } else if (response.body == "Usuário não encontrado.") {
    exibirMensagem("Usuário não encontrado.", context);
  } else if (response.body == "Saldo insuficiente para levantar a bicicleta.") {
    exibirMensagem("Saldo insuficiente para levantar a bicicleta.", context);
  } else if (response.body == "Você já possui uma bicicleta levantada.") {
    exibirMensagem("Você já possui uma bicicleta levantada.", context);
  } else if (response.body == "Estação não encontrada.") {
    exibirMensagem("Estação não encontrada.", context);
  } else if (response.body == "Não há bicicletas disponíveis nesta estação.") {
    exibirMensagem("Não há bicicletas disponíveis nesta estação.", context);
  } else {
    print("erro ao levantar bicicleta");
  }
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
