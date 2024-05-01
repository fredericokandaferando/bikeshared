import 'package:bikeshared/constantes/shered_preference.dart';
import 'package:bikeshared/estacao/estacaoService.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GerirBicicleta extends StatefulWidget {
  @override
  _GerirBicicletaState createState() => _GerirBicicletaState();
}

class _GerirBicicletaState extends State<GerirBicicleta> {
  List<Estacao> estacoes = [];
  List<Estacao> estacoesFiltradas = [];

  String endPoint = MySharedPreferences.ip;

  @override
  void initState() {
    super.initState();
    obterTodasEstacoes();
  }

  Future<void> obterTodasEstacoes() async {
    final response =
        await http.get(Uri.parse(MySharedPreferences.ip + "/listarInfo"));

    if (response.statusCode == 200) {
      final List<dynamic> estacoesJson =
          jsonDecode(utf8.decode(response.bodyBytes));
      setState(() {
        estacoes = estacoesJson.map((json) {
          final estacao = Estacao.fromJson(json);
          estacao.binas_disponiveis = estacao.binas_disponiveis;
          estacao.docas_disponiveis = estacao.capacidade;
          estacao.binas_disponiveis; // Alteração: definir docas como 0
          return estacao;
        }).toList();
        estacoesFiltradas = List.from(estacoes);
      });
    } else {
      throw Exception('Erro ao obter as estações: ${response.statusCode}');
    }
  }

  void alugarBicicleta(String email, Estacao estacao) async {
    final response = await http.post(
      Uri.parse(
          '$endPoint/estacao1/alugarBicicleta?email=$email&estacaoId=${estacao.id}'),
    );

    if (response.statusCode == 200) {
      setState(() {
        estacao.binas_disponiveis -= 1;
        estacao.docas_disponiveis =
            estacao.capacidade - estacao.binas_disponiveis;
      });
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Aluguel Sucedido!'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Um ponto foi descontado do seu saldo.'),
              ],
            ),
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
    } else if (response.statusCode == 400) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Oh oh!'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Já não tens pontos suficiente.'),
              ],
            ),
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
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Erro!'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Erro ao tentar alugar.'),
              ],
            ),
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
  }

  void filtrarEstacoes(String query) {
    setState(() {
      estacoesFiltradas = estacoes.where((estacao) {
        return estacao.name.toLowerCase().contains(query.toLowerCase());
      }).toList();
    });
  }

  void devolverBicicleta(String email, Estacao estacao) async {
    final response = await http.post(
      Uri.parse(
          '$endPoint/estacao1/devolverBicicleta?email=$email&estacaoId=${estacao.id}'),
    );

    try {
      print('Resposta do servidor: ${response.body}');

      if (response.statusCode == 200) {
        // Bicicleta devolvida com sucesso
        setState(() {
          estacao.binas_disponiveis += 1;
          estacao.docas_disponiveis =
              estacao.capacidade - estacao.binas_disponiveis;
        });
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Devolução Sucedida!'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Bicicleta devolvida com sucesso.'),
                ],
              ),
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
      } else if (response.statusCode == 400) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Devolução Inválida!'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('O user não possui um aluguel em andamento'),
                ],
              ),
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
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Erro Desconhecido!'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Erro desconhecido ao tentar devolver a bicicleta.'),
                ],
              ),
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
    } catch (error) {
      print('Erro ao tentar devolver a bicicleta: $error');
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Erro Desconhecido 02!'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Erro desconhecido 02 ao tentar devolver a bicicleta.'),
              ],
            ),
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
              SizedBox(height: 16),
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
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Deseja alugar bicicleta?'),
                      actions: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            alugarBicicleta(
                                MySharedPreferences.useremail, estacao);
                          },
                          child: Text('Sim'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('Não'),
                        ),
                      ],
                    );
                  },
                );
              },
              child: Text('Alugar'),
            ),
            if (estacao.binas_disponiveis < estacao.capacidade)
              ElevatedButton(
                onPressed: () {
                  devolverBicicleta(MySharedPreferences.useremail, estacao);
                  Navigator.of(context).pop();
                },
                child: Text('Devolver'),
              ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    // Fazer a limpeza necessária aqui (cancelar assinaturas, desconectar fluxos, etc.)
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todas as Estações'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
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
                        borderRadius: BorderRadius.circular(
                            7), // Define o raio de arredondamento
                        child: Container(
                          color: Color.fromARGB(255, 28, 150,
                              244), // Defina a cor de fundo desejada aqui
                          padding: EdgeInsets.all(
                              4), // Opcional: Adicione preenchimento para espaçamento
                        ),
                      ),
                      SizedBox(width: 8),
                      Text(estacao.binas_disponiveis.toString()),
                    ],
                  ),
                  Text('Docas Livres: ${estacao.docas_disponiveis.toString()}'),
                ],
              ),
              onTap: () {
                if (estacao.binas_disponiveis > 0) {
                  exibirInformacoesEstacao(estacao);
                } else {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Não há bicicletas disponíveis.'),
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
              },
            ),
          );
        },
      ),
    );
  }
}

@override
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
              premio_entrega: null,
            ));
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
