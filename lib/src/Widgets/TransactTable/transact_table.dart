import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pqrsf_webapp/src/Controllers/controllers.dart';

import '../../Models/models.dart';

class TransactTable extends StatefulWidget {
  const TransactTable({Key? key}) : super(key: key);

  @override
  State<TransactTable> createState() => _TransactTableState();
}

class _TransactTableState extends State<TransactTable> {
  List<Transact> transacts = [];
  TransactController transactController = TransactController();

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: _size.height * 0.06),
          child: Center(
            child: Text(
              'Tabla PQRSF',
              style: TextStyle(
                  fontSize: _size.aspectRatio * 15,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Center(
          child: Container(
            decoration: const BoxDecoration(color: Colors.transparent),
            height: _size.height * 0.8,
            width: _size.width * 0.95,
            child: Column(
              children: [
                Container(
                    padding: EdgeInsets.all(_size.height * 0.015),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    height: _size.height * 0.6,
                    child: FutureBuilder<List<TableTransact>>(
                        future: transactController.getAllTransacts(),
                        builder: ((context, listTransacts) {
                          List<TableTransact> tableTrasacts = [
                            TableTransact(
                                numeroVu: -1,
                                asunto: 'Asunto',
                                fechaRecepcion: 'Fecha Recepción',
                                fechaVencimiento: 'Fecha Vencimiento',
                                descripcionTipoTramite: 'Tipo PQRSF')
                          ];

                          if (!listTransacts.hasData) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else {
                            for (var element in listTransacts.data!) {
                              tableTrasacts.add(element);
                            }
                          }

                          return ListView.builder(
                              itemCount: tableTrasacts.length,
                              itemBuilder: ((context, index) {
                                return _envTile(_size, tableTrasacts[index]);
                              }));
                        }))),
                SizedBox(height: _size.height * 0.015),
                Row(
                  children: [
                    _searchInput(_size),
                    SizedBox(
                      width: _size.width * 0.15,
                    ),
                    _filtrationSection(_size)
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _envTile(Size size, TableTransact tableT) {
    return SizedBox(
      height: size.height * 0.05,
      width: size.width * 0.7,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _textBox(
              tableT.numeroVu == -1 ? 'Número VU' : '${tableT.numeroVu}', size),
          SizedBox(width: size.width * 0.0005),
          _textBox(tableT.asunto, size),
          SizedBox(width: size.width * 0.0005),
          _textBox(tableT.fechaRecepcion, size),
          SizedBox(width: size.width * 0.0005),
          _textBox(tableT.fechaVencimiento, size),
          SizedBox(width: size.width * 0.0005),
          _statusCircle(size, tableT),
          _textBox(tableT.descripcionTipoTramite, size),
          _crudButton(size, const Color.fromARGB(255, 19, 4, 158), Icons.edit,
              () {}, tableT.numeroVu),
          SizedBox(width: size.width * 0.005),
        ],
      ),
    );
  }

  Widget _crudButton(
      Size size, Color color, IconData icon, VoidCallback function, int id) {
    return id != -1
        ? SizedBox(
            width: size.width * 0.04,
            child: ElevatedButton(
              onPressed: function,
              child: Icon(icon, size: size.aspectRatio * 6),
              style: ElevatedButton.styleFrom(
                primary: color,
                onPrimary: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          )
        : _textBox('Traza', size);
  }

  Widget _textBox(String text, Size size) {
    return Container(
      height: size.height * 0.04,
      width: size.width * 0.132,
      color: Colors.white,
      child: Text(
        text,
        style: TextStyle(fontSize: size.longestSide / size.shortestSide * 8),
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget _searchInput(Size size) {
    return SizedBox(
      height: size.height * 0.08,
      width: size.width * 0.15,
      child: TextField(
        onChanged: (value) {},
        style: TextStyle(
            height: size.height * 0.0015,
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: size.longestSide / size.shortestSide * 8),
        decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.white)),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.white)),
            hintText: 'Buscar',
            hintStyle: const TextStyle(color: Colors.white),
            prefixIcon: Icon(Icons.search,
                color: Colors.white,
                size: size.longestSide / size.shortestSide * 16)),
      ),
    );
  }

  Widget _statusCircle(Size size, TableTransact tableObj) {
    Color color = Colors.black;

    if (tableObj.numeroVu != -1) {
      DateTime currentDate = DateTime.now();
      String dateString =
          tableObj.fechaVencimiento.replaceAll(RegExp('/'), '-');
      DateTime date = DateFormat('d-M-y').parse(dateString);

      int difference = currentDate.difference(date).inDays;

      if (difference >= 15) {
        color = Colors.red[700]!;
      }

      if (difference > 7 && difference <= 14) {
        color = Colors.yellow[700]!;
      }

      if (difference <= 7) {
        color = Colors.green[700]!;
      }

      return Padding(
          padding: EdgeInsets.only(
              right: size.width * 0.115, bottom: size.width * 0.01),
          child: _circle(size, color));
    } else {
      return _textBox('Estado', size);
    }
  }

  Widget _circle(Size size, Color color) {
    return Container(
        height: size.width * 0.02,
        width: size.width * 0.02,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100), color: color));
  }

  Widget _filtrationSection(Size size) {
    TextStyle _textStyle = TextStyle(
        color: Colors.white,
        fontSize: size.aspectRatio * 15,
        fontWeight: FontWeight.bold);

    return Padding(
        padding: EdgeInsets.only(top: size.height * 0.01),
        child: SizedBox(
          child: Row(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Estado', style: _textStyle),
                  SizedBox(height: size.height * 0.01),
                  _checkBoxTile(size, false, 'Favorable', Colors.green[700]!),
                  _checkBoxTile(size, false, 'Atrasado', Colors.yellow[700]!),
                  _checkBoxTile(size, false, 'Vencido', Colors.red[700]!)
                ],
              ),
              SizedBox(width: size.width * 0.02),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Tipo PQRSF', style: _textStyle),
                  SizedBox(height: size.height * 0.01),
                  _checkBoxTile(size, false, 'Petición', Colors.white),
                  _checkBoxTile(size, false, 'Queja', Colors.white),
                  _checkBoxTile(size, false, 'Reclamo', Colors.white)
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('', style: _textStyle),
                  SizedBox(height: size.height * 0.01),
                  _checkBoxTile(size, false, 'Sugerencia', Colors.white),
                  _checkBoxTile(size, false, 'Felicitación', Colors.white),
                ],
              ),
            ],
          ),
        ));
  }

  Widget _checkBoxTile(Size size, bool status, String message, Color color) {
    TextStyle _textStyle = TextStyle(
        color: color,
        fontSize: size.aspectRatio * 12,
        fontWeight: FontWeight.bold);

    return Container(
      padding: EdgeInsets.only(bottom: size.height * 0.005),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Checkbox(
            checkColor: color,
            value: status,
            shape: const CircleBorder(),
            onChanged: (bool? value) {
              setState(() {
                status = value!;
              });
            },
          ),
          Text(
            message,
            style: _textStyle,
          )
        ],
      ),
    );
  }
}
