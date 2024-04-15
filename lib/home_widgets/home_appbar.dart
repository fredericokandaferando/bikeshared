import 'package:flutter/material.dart';

AppBar getHomeAppBar() {
  return AppBar(
    title: const Text(
      "Bem-Vindo ao BikeShared",
      style: TextStyle(
        color: Colors.white, // Definindo a cor do título como branco
      ),
    ),
    centerTitle: true,
    backgroundColor: const Color.fromARGB(255, 114, 56, 2),
    actions: [
      IconButton(
        onPressed: () {},
        icon: const Icon(
          Icons.more_vert_rounded,
        ),
        color: Colors.white, // Definindo a cor do ícone como branco
      ),
    ],
  );
}
