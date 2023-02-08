// To parse this JSON data, do
//
//     final peticionaryType = peticionaryTypeFromJson(jsonString);
import 'dart:convert';

PeticionaryType peticionaryTypeFromJson(String str) =>
    PeticionaryType.fromJson(json.decode(str));

String peticionaryTypeToJson(PeticionaryType data) =>
    json.encode(data.toJson());

class PeticionaryType {
  PeticionaryType({
    required this.id,
    required this.descripcion,
  });

  int id;
  String descripcion;

  factory PeticionaryType.fromJson(Map<String, dynamic> json) =>
      PeticionaryType(
        id: json["id"],
        descripcion: json["descripcion"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "descripcion": descripcion,
      };
}
