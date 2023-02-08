import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Controllers/controllers.dart';
import '../../Models/models.dart';

class InfoPanel extends StatefulWidget {
  const InfoPanel({Key? key}) : super(key: key);

  @override
  State<InfoPanel> createState() => _InfoPanelState();
}

class _InfoPanelState extends State<InfoPanel> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    Object? args = ModalRoute.of(context)!.settings.arguments;

    final Size size = MediaQuery.of(context).size;

    final styleText =
        TextStyle(fontSize: size.aspectRatio * 12, fontWeight: FontWeight.bold);

    TransactController transactController =
        Provider.of<TransactController>(context);

    if (args != null && index == 0) {
      transactController.getTransactByID(int.parse(args.toString()));
      index++;
    }
    TransactShow info = transactController.selectedTransact;

    return Center(
      child: Container(
        width: size.width * 0.9,
        height: size.height * 0.65,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(25)),
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.02, vertical: size.height * 0.03),
            width: size.width * 0.90,
            height: size.height * 0.65,
            child: Column(
              children: [
                Center(
                  child: Text('NúmeroVU', style: styleText),
                ),
                Row(
                  children: [
                    _columnInfo1(size, styleText, info),
                    SizedBox(width: size.width * 0.14),
                    _columnInfo2(size, styleText, info),
                    SizedBox(width: size.width * 0.14),
                    _descriptionCamp(size, styleText, info)
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _descriptionCamp(Size size, TextStyle styleText, TransactShow info) {
    return SizedBox(
      width: size.width * 0.19,
      child: Column(
        children: [
          SizedBox(
            height: size.height * 0.05,
          ),
          Text('Descripción', style: styleText),
          SizedBox(
            height: size.height * 0.02,
          ),
          Container(
            height: size.height * 0.4,
            width: size.width * 0.19,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black, strokeAlign: 1),
                borderRadius: BorderRadius.circular(20)),
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(size.aspectRatio * 6),
                child: Text(info.descripcion),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _columnInfo1(Size size, TextStyle styleText, TransactShow info) {
    Color colorButton = Colors.grey;

    return SizedBox(
      width: size.width * 0.19,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Asunto: ${info.asunto}\n'
            'Tipo PQRSF: ${info.tipoPqrsf}\n'
            'Peticionario ${info.peticionario}\n'
            'Tipo Peticionario ${info.tipoPeticionario}\n',
            style: styleText,
            textAlign: TextAlign.start,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(
            height: size.height * 0.05,
            width: size.width * 0.19,
          ),
          Text(
            'Número de Oficio: ${info.numeroOficio}\n'
            'Dependencia ${info.dependencia}\n'
            'Número VU: ${info.id}',
            style: styleText,
            textAlign: TextAlign.start,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(
            height: size.height * 0.03,
          ),
          Padding(
            padding: EdgeInsets.only(left: size.width * 0.03),
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                  backgroundColor: colorButton,
                  foregroundColor: Colors.black,
                  elevation: 12,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25))),
              child: Text(
                'Respuesta',
                style: TextStyle(
                    fontSize: size.aspectRatio * 8,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _columnInfo2(Size size, TextStyle styleText, TransactShow info) {
    return SizedBox(
      width: size.width * 0.19,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'E-Mail: ${info.email}\n'
            'Celular: ${info.celular}\n'
            'Dirección: ${info.direccion}\n',
            style: styleText,
            textAlign: TextAlign.start,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(
            height: size.height * 0.05,
          ),
          Text(
            'Recepción: ${info.fechaRecepcion}\n'
            'Vencimiento: ${info.fechaVencimiento}\n'
            'Medio De Recepción: ${info.medioRecepcion}\n',
            style: styleText,
            textAlign: TextAlign.start,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
