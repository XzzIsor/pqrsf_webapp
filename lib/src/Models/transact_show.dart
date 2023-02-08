// To parse this JSON data, do
//
//     final transactShow = transactShowFromJson(jsonString);
import 'dart:convert';

TransactShow transactShowFromJson(String str) =>
    TransactShow.fromJson(json.decode(str));

String transactShowToJson(TransactShow data) => json.encode(data.toJson());

class TransactShow {
  TransactShow({
    required this.id,
    required this.tipoPqrsf,
    required this.peticionario,
    required this.tipoPeticionario,
    required this.numeroOficio,
    required this.dependencia,
    required this.email,
    required this.celular,
    required this.direccion,
    required this.fechaRecepcion,
    required this.fechaVencimiento,
    required this.medioRecepcion,
    required this.descripcion,
    required this.traza,
    required this.asunto,
  });

  int id;
  String tipoPqrsf;
  String peticionario;
  String tipoPeticionario;
  String numeroOficio;
  String dependencia;
  String email;
  String celular;
  String direccion;
  String fechaRecepcion;
  String fechaVencimiento;
  String medioRecepcion;
  String descripcion;
  List<Traza> traza;
  String asunto;

  factory TransactShow.fromJson(Map<String, dynamic> json) => TransactShow(
        id: json["id"],
        tipoPqrsf: json["tipoPQRSF"],
        peticionario: json["peticionario"],
        tipoPeticionario: json["tipoPeticionario"],
        numeroOficio: json["numeroOficio"],
        dependencia: json["dependencia"],
        email: json["email"],
        celular: json["celular"],
        direccion: json["direccion"],
        fechaRecepcion: json["fechaRecepcion"],
        fechaVencimiento: json["fechaVencimiento"],
        medioRecepcion: json["medioRecepcion"],
        descripcion: json["descripcion"],
        traza: List<Traza>.from(json["traza"].map((x) => Traza.fromJson(x))),
        asunto: json["asunto"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "tipoPQRSF": tipoPqrsf,
        "peticionario": peticionario,
        "tipoPeticionario": tipoPeticionario,
        "numeroOficio": numeroOficio,
        "dependencia": dependencia,
        "email": email,
        "celular": celular,
        "direccion": direccion,
        "fechaRecepcion": fechaRecepcion,
        "fechaVencimiento": fechaVencimiento,
        "medioRecepcion": medioRecepcion,
        "descripcion": descripcion,
        "traza": List<dynamic>.from(traza.map((x) => x.toJson())),
        "asunto": asunto,
      };
}

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
