import 'package:bikeshared/constantes/shered_preference.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class EstacoesPage extends StatefulWidget {
  @override
  _EstacoesPageState createState() => _EstacoesPageState();
}

class _EstacoesPageState extends State<EstacoesPage> {
  List<Estacao> estacoes = [];
  List<Estacao> estacoesFiltradas = [];

  @override
  void initState() {
    super.initState();
    obterEstacoes(); // Chama a função para obter as estações da API
  }

  Future<void> obterEstacoes() async {
    try {
      final response =
          await http.get(Uri.parse(MySharedPreferences.ip + "/listarInfo"));

      if (response.statusCode == 200) {
        final List<dynamic> estacoesJson = jsonDecode(response.body);
        setState(() {
          estacoes =
              estacoesJson.map((json) => Estacao.fromJson(json)).toList();
          estacoesFiltradas = List.from(estacoes);
        });
      } else {
        throw Exception('Erro ao obter as estações: ${response.statusCode}');
      }
    } catch (e) {
      print('Erro ao obter as estações: $e');
    }
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
          'Todas as Estações',
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
                      Text(
                          'Bicicletas Disponível:${estacao.binas_disponiveis.toString()}'),
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

  factory Estacao.fromJson(Map<String, dynamic> json) {
    return Estacao(
      id: json['id'],
      name: json['name'],
      capacidade: json['capacidade'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      premioEntrega: json['premioEntrega'],
      binas_disponiveis: json['binas_disponiveis'],
      docas_disponiveis: int.parse(json['docas_disponiveis'].toString()),
    );
  }
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
