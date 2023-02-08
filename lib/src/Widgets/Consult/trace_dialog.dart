import 'package:flutter/material.dart';
import 'package:pqrsf_webapp/src/Models/models.dart';

class TraceDialog {
  Future<void> showTraceDialog(BuildContext context, Traza trace) async {
    return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          Size size = MediaQuery.of(context).size;

          String status = trace.activo ? "En curso" : "Terminado";

          return AlertDialog(
            backgroundColor: Colors.transparent,
            content: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.all(size.aspectRatio * 5),
                width: size.width * 0.3,
                height: size.height * 0.4,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                        width: size.aspectRatio * 2,
                        color: const Color.fromRGBO(47, 45, 125, 1))),
                child: Container(
                  padding: EdgeInsets.all(size.aspectRatio * 7),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _textField('Información del Movimiento:', size),
                      _textField('Dependencia: ${trace.dependencia}', size),
                      _textField(
                          'Número de Oficio: ${trace.numeroOficio}', size),
                      _textField('Fecha: ${trace.fechaCreacion}', size),
                      _textField('Estado: $status', size),
                      _textField('Descripción: ${trace.descripcion}', size),
                    ],
                  ),
                ),
              ),
            ),
            elevation: 24,
          );
        });
  }

  Container _textField(String message, Size size) {
    return Container(
      decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey))),
      margin: EdgeInsets.symmetric(vertical: size.height * 0.01),
      child: Text(
        message,
        style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: size.aspectRatio * 15),
        textAlign: TextAlign.start,
        overflow: TextOverflow.ellipsis,
        maxLines: 2,
      ),
    );
  }
}
