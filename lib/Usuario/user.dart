class User{
  late final int? ponto;
  late final String? name;
  late final String? address;
  late final String?email;
  late final int?istation_id;

  User({
required this.ponto,
required this.name,
required this.email,
required this.address,

required this.istation_id,
  });

  factory User.fromJson(Map<String,dynamic>json){
    return User
    (ponto:json['ponto'], name:json['name'], email:json['email'], address:json['address'],istation_id:json['istation_id']);
  }
}