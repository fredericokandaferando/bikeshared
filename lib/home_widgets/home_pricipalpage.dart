import 'package:bikeshared/estacao/DevolverBicicleta.dart';
import 'package:bikeshared/estacao/LevantarBicicleta.dart';
import 'package:bikeshared/estacao/TelaListaEstacao.dart';
import 'package:bikeshared/estacao/mapa.dart';
import 'package:bikeshared/home_widgets/home_appbar.dart';
import 'package:bikeshared/wifidirect/TransferiPonto.dart';
import 'package:bikeshared/wifidirect/chat.dart';
import 'package:flutter/material.dart';

class MenuPrincipal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: getHomeAppBar(),
        //floatingActionButton: getHomeFab(),
        body: Container(),
        drawer: Drawer(
          child: Column(
            children: [
              UserAccountsDrawerHeader(
                decoration:
                    BoxDecoration(color: Color.fromARGB(255, 114, 56, 2)),
                accountName: Text('Frederico'),
                accountEmail: Text('fredericokanda21@gmail.com'),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Text(
                    "BS",
                    style: TextStyle(
                        color: Color.fromARGB(255, 114, 56, 2), fontSize: 40),
                  ),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.search,
                    color: Color.fromARGB(255, 114, 56, 2)),
                title: const Text("Localizar Estação"),
                onTap: () {
                  // ignore: prefer_const_constructors
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => TrackingMapScreen()),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.search,
                    color: Color.fromARGB(255, 114, 56, 2)),
                title: const Text("Listar Estações"),
                onTap: () {
                  // ignore: prefer_const_constructors
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
                    MaterialPageRoute(builder: (context) => GerirBicicleta()),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.bike_scooter_rounded,
                    color: Color.fromARGB(255, 114, 56, 2)),
                title: const Text("Devolver Bicicleta"),
                onTap: () {
                  // ignore: prefer_const_constructors
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
                  // ignore: prefer_const_constructors
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
                  // ignore: prefer_const_constructors
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
                /* onTap: (){
          // ignore: prefer_const_constructors
           Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ListaUsuario()),) ;
        },*/
              ),
              ListTile(
                leading: const Icon(Icons.info,
                    color: Color.fromARGB(255, 114, 56, 2)),
                title: const Text("Info"),
                /* onTap: (){
          // ignore: prefer_const_constructors
           Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Logalizacao()),) ;
        },*/
              ),
              ListTile(
                leading: const Icon(Icons.arrow_back_sharp,
                    color: Color.fromARGB(255, 114, 56, 2)),
                title: const Text("Sair"),
                /*  onTap: (){
          // ignore: prefer_const_constructors
           Navigator.of(context).push(MaterialPageRoute(builder: (context)=>HomePage()),) ;
        },*/
              )
            ],
          ),
        ));
  }
}
