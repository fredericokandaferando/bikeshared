import 'package:flutter/material.dart';

class DevolverBicicleta extends StatefulWidget {
  @override
  _DevolverBicicletaState createState() => _DevolverBicicletaState();
}

class _DevolverBicicletaState extends State<DevolverBicicleta> {
  List<Estacao> estacoes = [];
  List<Estacao> estacoesFiltradas = [];

  @override
  void initState() {
    super.initState();
    // Aqui você pode adicionar dados estáticos para simular interação com o servidor
    // Por exemplo:
    estacoes = [
      Estacao(
        id: 1,
        name: 'Estação 1',
        capacidade: 20,
        latitude: 40.7128,
        longitude: -74.0060,
        premioEntrega: 50,
        binas_disponiveis: 15,
        docas_disponiveis: 5,
      ),
      Estacao(
        id: 2,
        name: 'Estação 2',
        capacidade: 15,
        latitude: 34.0522,
        longitude: -118.2437,
        premioEntrega: null,
        binas_disponiveis: 10,
        docas_disponiveis: 5,
      ),
    ];
    estacoesFiltradas = List.from(estacoes);
  }

  void filtrarEstacoes(String query) {
    setState(() {
      estacoesFiltradas = estacoes.where((estacao) {
        return estacao.name.toLowerCase().contains(query.toLowerCase());
      }).toList();
    });
  }

  void exibirInformacoesEstacao(Estacao estacao) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(estacao.name),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Capacidade: ${estacao.capacidade.toString()}'),
              Text('Latitude: ${estacao.latitude.toString()}'),
              Text('Longitude: ${estacao.longitude.toString()}'),
              Text('Prêmio De Entrega: ${estacao.premioEntrega.toString()}'),
              Text(
                  'Bicicletas Disponíveis: ${estacao.binas_disponiveis.toString()}'),
              Text(
                  'Docas Disponíveis: ${estacao.docas_disponiveis.toString()}'),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Fechar'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                _devolverBicicleta();
              },
              child: Text('Devolver'),
            ),
          ],
        );
      },
    );
  }

  void _devolverBicicleta() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Bicicleta Devolvida com Sucesso!'),
          content: Text('A bicicleta foi devolvida com sucesso.'),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Ok'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Devolver Bicicleta',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 114, 56, 2),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            color: Colors.white,
            onPressed: () {
              showSearch(
                context: context,
                delegate: EstacoesSearchDelegate(estacoes: estacoes),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: estacoesFiltradas.length,
        itemBuilder: (context, index) {
          final estacao = estacoesFiltradas[index];
          return Container(
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(10),
            ),
            child: ListTile(
              title: Text(estacao.name),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(7),
                        child: Container(
                          color: Color.fromARGB(255, 28, 150, 244),
                          padding: EdgeInsets.all(4),
                        ),
                      ),
                      SizedBox(width: 8),
                      Text('Preminho:${estacao.premioEntrega.toString()}'),
                    ],
                  ),
                  Text('Docas Livres: ${estacao.docas_disponiveis.toString()}'),
                ],
              ),
              onTap: () {
                exibirInformacoesEstacao(estacao);
              },
            ),
          );
        },
      ),
    );
  }
}

class Estacao {
  final int id;
  final String name;
  final int capacidade;
  final double latitude;
  final double longitude;
  final int? premioEntrega;
  int binas_disponiveis;
  int docas_disponiveis;

  Estacao({
    required this.id,
    required this.name,
    required this.capacidade,
    required this.latitude,
    required this.longitude,
    required this.premioEntrega,
    required this.binas_disponiveis,
    required this.docas_disponiveis,
  });
}

class EstacoesSearchDelegate extends SearchDelegate<Estacao> {
  final List<Estacao> estacoes;

  EstacoesSearchDelegate({required this.estacoes});

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(
          context,
          Estacao(
            id: 0,
            name: '',
            capacidade: 0,
            latitude: 0,
            longitude: 0,
            premioEntrega: 0,
            binas_disponiveis: 0,
            docas_disponiveis: 0,
          ),
        );
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final resultados = estacoes.where((estacao) {
      return estacao.name.toLowerCase().contains(query.toLowerCase());
    }).toList();

    return ListView.builder(
      itemCount: resultados.length,
      itemBuilder: (context, index) {
        final estacao = resultados[index];
        return ListTile(
          title: Text(estacao.name),
          onTap: () {
            close(context, estacao);
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final resultados = estacoes.where((estacao) {
      return estacao.name.toLowerCase().contains(query.toLowerCase());
    }).toList();

    return ListView.builder(
      itemCount: resultados.length,
      itemBuilder: (context, index) {
        final estacao = resultados[index];
        return ListTile(
          title: Text(estacao.name),
          onTap: () {
            close(context, estacao);
          },
        );
      },
    );
  }
}
