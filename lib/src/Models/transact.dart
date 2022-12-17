// To parse this JSON data, do
//
//     final transact = transactFromJson(jsonString);

import 'dart:convert';

Transact transactFromJson(String str) => Transact.fromJson(json.decode(str));

String transactToJson(Transact data) => json.encode(data.toJson());

class Transact {
  Transact({
    required this.nombrePeticionario,
    required this.idTipoTramite,
    required this.correo,
    required this.numeroVu,
    required this.celular,
    required this.fechaRecepcion,
    required this.telefono,
    required this.direccion,
    required this.asunto,
    required this.numeroOficio,
    required this.idDependencia,
    required this.idTipoRecepcion,
    required this.descripcion,
    required this.idTipoTipoPeticionario,
  });

  String nombrePeticionario;
  int idTipoTramite;
  String correo;
  int numeroVu;
  String celular;
  String fechaRecepcion;
  String telefono;
  String direccion;
  String asunto;
  String numeroOficio;
  int idDependencia;
  int idTipoRecepcion;
  String descripcion;
  int idTipoTipoPeticionario;

  factory Transact.fromJson(Map<String, dynamic> json) => Transact(
        nombrePeticionario: json["nombrePeticionario"],
        idTipoTramite: json["idTipoTramite"],
        correo: json["correo"],
        numeroVu: json["numeroVU"],
        celular: json["celular"],
        fechaRecepcion: json["fechaRecepcion"],
        telefono: json["telefono"],
        direccion: json["direccion"],
        asunto: json["asunto"],
        numeroOficio: json["numeroOficio"],
        idDependencia: json["idDependencia"],
        idTipoRecepcion: json["idTipoRecepcion"],
        descripcion: json["descripcion"],
        idTipoTipoPeticionario: json["idTipoTipoPeticionario"],
      );

  Map<String, dynamic> toJson() => {
        "nombrePeticionario": nombrePeticionario,
        "idTipoTramite": idTipoTramite,
        "correo": correo,
        "numeroVU": numeroVu,
        "celular": celular,
        "fechaRecepcion": fechaRecepcion,
        "telefono": telefono,
        "direccion": direccion,
        "asunto": asunto,
        "numeroOficio": numeroOficio,
        "idDependencia": idDependencia,
        "idTipoRecepcion": idTipoRecepcion,
        "descripcion": descripcion,
        "idTipoTipoPeticionario": idTipoTipoPeticionario,
      };
}
