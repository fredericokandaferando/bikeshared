import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:bikeshared/constantes/shered_preference.dart';
import 'package:bikeshared/Usuario/user.dart';
import 'package:bikeshared/estacao/DevolverBicicleta.dart';
import 'package:bikeshared/estacao/LevantarBicicleta.dart';
import 'package:bikeshared/estacao/TelaListaEstacao.dart';
import 'package:bikeshared/estacao/mapa.dart';
import 'package:bikeshared/home_widgets/home_appbar.dart';
import 'package:bikeshared/wifidirect/TransferiPonto.dart';
import 'package:bikeshared/wifidirect/chat.dart';

class MenuPrincipal extends StatefulWidget {
  const MenuPrincipal({Key? key}) : super(key: key);

  @override
  State<MenuPrincipal> createState() => _MenuPrincipalState();
}

class _MenuPrincipalState extends State<MenuPrincipal> {
  late Future<User> _userFuture;

  @override
  void initState() {
    super.initState();
    _userFuture = fetchUser();
  }

  Future<User> fetchUser() async {
    String email = await MySharedPreferences.useremail;
    final response = await http
        .get(Uri.parse(MySharedPreferences.ip + '/estacao1/user/$email'));
    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load user information');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User>(
      future: _userFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData) {
          return Text('No data available');
        } else {
          User user = snapshot.data!;

          return Scaffold(
            appBar: getHomeAppBar(),
            body: Container(),
            drawer: Drawer(
              child: Column(
                children: [
                  UserAccountsDrawerHeader(
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 114, 56, 2),
                    ),
                    accountName: Text('${user.name}'),
                    accountEmail: Text('${user.email}'),
                    currentAccountPicture: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Text(
                        "BS",
                        style: TextStyle(
                          color: Color.fromARGB(255, 114, 56, 2),
                          fontSize: 40,
                        ),
                      ),
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.search,
                        color: Color.fromARGB(255, 114, 56, 2)),
                    title: const Text("Rastreio de Trajetória"),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => TrackingMapScreen()),
                      );
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.list,
                        color: Color.fromARGB(255, 114, 56, 2)),
                    title: const Text("Listar Estações"),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => EstacoesPage()),
                      );
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.bike_scooter_rounded,
                        color: Color.fromARGB(255, 114, 56, 2)),
                    title: const Text("Levantar Bicicleta"),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => GerirBicicleta()),
                      );
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.bike_scooter_rounded,
                        color: Color.fromARGB(255, 114, 56, 2)),
                    title: const Text("Devolver Bicicleta"),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => DevolverBicicleta()),
                      );
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.chat,
                        color: Color.fromARGB(255, 114, 56, 2)),
                    title: const Text("Chat"),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => ChatScreen()),
                      );
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.transfer_within_a_station,
                        color: Color.fromARGB(255, 114, 56, 2)),
                    title: const Text("Transferir Pontos"),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => PointsTransferScreen()),
                      );
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.list,
                        color: Color.fromARGB(255, 114, 56, 2)),
                    title: const Text("Lista Usuario"),
                    onTap: () {
                      // Implement user list navigation here
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.info,
                        color: Color.fromARGB(255, 114, 56, 2)),
                    title: const Text("Info"),
                    onTap: () {
                      // Implement info navigation here
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.arrow_back_sharp,
                        color: Color.fromARGB(255, 114, 56, 2)),
                    title: const Text("Exit"),
                    onTap: () {
                      // Implement exit navigation here
                    },
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
