import 'dart:convert';

TableTransact tableTransactFromJson(String str) =>
    TableTransact.fromJson(json.decode(str));

String tableTransactToJson(TableTransact data) => json.encode(data.toJson());

class TableTransact {
  TableTransact({
    required this.numeroVu,
    required this.asunto,
    required this.fechaRecepcion,
    required this.fechaVencimiento,
    required this.descripcionTipoTramite,
  });

  int numeroVu;
  String asunto;
  String fechaRecepcion;
  String fechaVencimiento;
  String descripcionTipoTramite;

  factory TableTransact.fromJson(Map<String, dynamic> json) => TableTransact(
        numeroVu: json["numeroVU"],
        asunto: json["asunto"],
        fechaRecepcion: json["fechaRecepcion"],
        fechaVencimiento: json["fechaVencimiento"],
        descripcionTipoTramite: json["descripcionTipoTramite"],
      );

  Map<String, dynamic> toJson() => {
        "numeroVU": numeroVu,
        "asunto": asunto,
        "fechaRecepcion": fechaRecepcion,
        "fechaVencimiento": fechaVencimiento,
        "descripcionTipoTramite": descripcionTipoTramite,
      };
}
