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
  });
}
