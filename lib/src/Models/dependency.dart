import 'dart:convert';

Dependency dependencyFromJson(String str) =>
    Dependency.fromJson(json.decode(str));

String dependencyToJson(Dependency data) => json.encode(data.toJson());

class Dependency {
  Dependency({
    required this.id,
    required this.descripcion,
  });

  int id;
  String descripcion;

  factory Dependency.fromJson(Map<String, dynamic> json) => Dependency(
        id: json["id"],
        descripcion: json["descripcion"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "descripcion": descripcion,
      };
}
