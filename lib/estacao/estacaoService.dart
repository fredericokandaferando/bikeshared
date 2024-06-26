class Estacao {
  late final int? id;
  late final String name;
  late final int capacidade;
  late final double? latitude;
  late final double? longitude;
  late final double? premioEntrega;
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
