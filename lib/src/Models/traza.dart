import 'dart:convert';

Traza trazaFromJson(String str) => Traza.fromJson(json.decode(str));

String trazaToJson(Traza data) => json.encode(data.toJson());

class Traza {
  Traza({
    required this.dependencia,
    required this.numeroOficio,
    required this.descripcion,
    required this.fechaCreacion,
    required this.activo,
  });

  String dependencia;
  String numeroOficio;
  String descripcion;
  String fechaCreacion;
  bool activo;

  factory Traza.fromJson(Map<String, dynamic> json) => Traza(
        dependencia: json["dependencia"],
        numeroOficio: json["numeroOficio"],
        descripcion: json["descripcion"],
        fechaCreacion: json["fechaCreacion"],
        activo: json["activo"],
      );

  Map<String, dynamic> toJson() => {
        "dependencia": dependencia,
        "numeroOficio": numeroOficio,
        "descripcion": descripcion,
        "fechaCreacion": fechaCreacion,
        "activo": activo,
      };
}
