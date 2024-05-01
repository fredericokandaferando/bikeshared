import 'package:bikeshared/Usuario/user.dart';
import 'package:bikeshared/constantes/shered_preference.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;


class Userlog extends StatefulWidget {
  const Userlog ({super.key});
  @override
  State<Userlog > createState() => UserlogState();
}
class UserlogState extends State<Userlog> {
  Future<User> fetchUser(String email) async {
    final response = await http.get(Uri.parse(MySharedPreferences.ip+'/estacao/user/$email'));
    print(response.body); // For debugging purposes, check the response body
    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Falha ao carregar informações do usuário');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}