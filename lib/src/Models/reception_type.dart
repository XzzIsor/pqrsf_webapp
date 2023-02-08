// To parse this JSON data, do
//
//     final receptionType = receptionTypeFromJson(jsonString);
import 'dart:convert';

ReceptionType receptionTypeFromJson(String str) =>
    ReceptionType.fromJson(json.decode(str));

String receptionTypeToJson(ReceptionType data) => json.encode(data.toJson());

class ReceptionType {
  ReceptionType({
    required this.id,
    required this.descripcion,
  });

  int id;
  String descripcion;

  factory ReceptionType.fromJson(Map<String, dynamic> json) => ReceptionType(
        id: json["id"],
        descripcion: json["descripcion"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "descripcion": descripcion,
      };
}
