class Estacao {
  final int id;
  final String name;
  final int capacidade;
  final double latitude;
  final double longitude;
  final double premioEntrega;
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
    required premio_entrega,
  });

  factory Estacao.fromJson(Map<String, dynamic> json) {
    return Estacao(
      id: json['id'],
      name: json['name'],
      capacidade: int.parse(json['capacidade'].toString()),
      latitude: double.parse(json['latitude'].toString()),
      longitude: double.parse(json['longitude'].toString()),
      premioEntrega: double.parse(json['premio_entrega'].toString()),
      binas_disponiveis: int.parse(json['binas_disponiveis'].toString()),
      docas_disponiveis: int.parse(json['docas_disponiveis'].toString()),
      premio_entrega: null,
    );
  }
}
