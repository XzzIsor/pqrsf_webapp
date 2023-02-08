// To parse this JSON data, do
//
//     final transact = transactFromJson(jsonString);

import 'dart:convert';

import 'models.dart';

Transact transactFromJson(String str) => Transact.fromJson(json.decode(str));

String transactToJson(Transact data) => json.encode(data.toJson());

class Transact {
  Transact(
      {required this.nombrePeticionario,
      required this.idTipoTramite,
      required this.correo,
      required this.numeroVU,
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
      this.traza});

  String nombrePeticionario;
  int idTipoTramite;
  String correo;
  int numeroVU;
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
  List<Traza>? traza;

  factory Transact.fromJson(Map<String, dynamic> json) => Transact(
      nombrePeticionario: json["nombrePeticionario"],
      idTipoTramite: json["idTipoTramite"],
      correo: json["correo"],
      numeroVU: json["numeroVU"],
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
      traza: json['traza']);

  Map<String, dynamic> toJson() => {
        "nombrePeticionario": nombrePeticionario,
        "idTipoTramite": idTipoTramite,
        "correo": correo,
        "numeroVU": numeroVU,
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
        "traza": traza
      };
}
