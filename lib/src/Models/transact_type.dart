import 'dart:convert';

TransactType transactTypeFromJson(String str) =>
    TransactType.fromJson(json.decode(str));

String transactTypeToJson(TransactType data) => json.encode(data.toJson());

class TransactType {
  TransactType({
    required this.id,
    required this.descripcion,
  });

  int id;
  String descripcion;

  factory TransactType.fromJson(Map<String, dynamic> json) => TransactType(
        id: json["id"],
        descripcion: json["descripcion"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "descripcion": descripcion,
      };
}
