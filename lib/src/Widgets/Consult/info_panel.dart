import 'package:flutter/material.dart';

class InfoPanel extends StatelessWidget {
  const InfoPanel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    final styleText =
        TextStyle(fontSize: size.aspectRatio * 15, fontWeight: FontWeight.bold);

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
                  child: Text('Titulo', style: styleText),
                ),
                Row(
                  children: [
                    _ColumnInfo1(size: size, styleText: styleText),
                    SizedBox(width: size.width * 0.14),
                    _ColumnInfo2(size: size, styleText: styleText),
                    SizedBox(width: size.width * 0.14),
                    _DescriptionCamp(size: size, styleText: styleText)
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _DescriptionCamp extends StatelessWidget {
  const _DescriptionCamp({
    super.key,
    required this.size,
    required this.styleText,
  });

  final Size size;
  final TextStyle styleText;

  @override
  Widget build(BuildContext context) {
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
                child: Text(' '),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _ColumnInfo2 extends StatelessWidget {
  const _ColumnInfo2({
    super.key,
    required this.size,
    required this.styleText,
  });

  final Size size;
  final TextStyle styleText;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size.width * 0.19,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'E-Mail: \n'
            'Celular: \n'
            'Dirección: \n',
            style: styleText,
            textAlign: TextAlign.start,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(
            height: size.height * 0.05,
          ),
          Text(
            'Recepción: \n'
            'Vencimiento: \n'
            'Medio De Recepción: \n',
            style: styleText,
            textAlign: TextAlign.start,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

class _ColumnInfo1 extends StatelessWidget {
  const _ColumnInfo1({
    super.key,
    required this.size,
    required this.styleText,
  });

  final Size size;
  final TextStyle styleText;

  @override
  Widget build(BuildContext context) {
    Color colorButton = Colors.grey;

    return SizedBox(
      width: size.width * 0.19,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Asunto: \n'
            'Tipo PQRSF: \n'
            'Peticionario \n'
            'Tipo Peticionario \n',
            style: styleText,
            textAlign: TextAlign.start,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(
            height: size.height * 0.05,
            width: size.width * 0.19,
          ),
          Text(
            'Número de Oficio: \n'
            'Dependencia \n'
            'Oficio de Respuesta: \n',
            style: styleText,
            textAlign: TextAlign.start,
            overflow: TextOverflow.ellipsis,
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
}
