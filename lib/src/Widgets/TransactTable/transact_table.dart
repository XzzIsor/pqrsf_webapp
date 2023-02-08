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
  TransactController transactController = TransactController();
  List<TransactTable> transactList = [];
  bool intimeStatus = false;
  bool overdueStatus = false;
  bool failStatus = false;
  bool petitionStatus = false;
  bool complaingStatus = false;
  bool reclaimStatus = false;
  bool adviceStatus = false;
  bool congratulationStatus = false;
  String dateInitial = 'dd/mm/YY';
  String dateFinal = 'dd/mm/YY';
  DateTime? initialLimit;
  DateTime? finalLimit;
  int? numVU;
  int? type;
  bool filter = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: size.height * 0.06),
          child: Center(
            child: Text(
              'Tabla PQRSF',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: size.aspectRatio * 20,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Center(
          child: Container(
            decoration: const BoxDecoration(color: Colors.transparent),
            height: size.height * 0.8,
            width: size.width * 0.95,
            child: Column(
              children: [
                Container(
                    padding: EdgeInsets.all(size.height * 0.015),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    height: size.height * 0.6,
                    child: FutureBuilder<List<TableTransact>>(
                        future: !filter
                            ? transactController.getAllTransacts()
                            : transactController.filterTransacts(numVU, type),
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
                              DateFormat formatter = DateFormat("dd/MM/yyyy");
                              DateTime vec =
                                  formatter.parse(element.fechaVencimiento);
                              DateTime actual = DateTime.now();
                              int difference = actual.difference(vec).inDays;

                              DateTime rep =
                                  formatter.parse(element.fechaRecepcion);

                              if (_confirmDate(rep)) {
                                if (intimeStatus) {
                                  if (difference <= 7) {
                                    tableTrasacts.add(element);
                                  }
                                } else if (overdueStatus) {
                                  if (difference > 7 && difference <= 14) {
                                    tableTrasacts.add(element);
                                  }
                                } else if (failStatus) {
                                  if (difference > 15) {
                                    tableTrasacts.add(element);
                                  }
                                } else {
                                  tableTrasacts.add(element);
                                }
                              }
                            }
                          }

                          return ListView.builder(
                              itemCount: tableTrasacts.length,
                              itemBuilder: ((context, index) {
                                return _envTile(size, tableTrasacts[index]);
                              }));
                        }))),
                SizedBox(height: size.height * 0.015),
                Row(
                  children: [
                    _searchInput(size),
                    SizedBox(
                      width: size.width * 0.15,
                    ),
                    _filtrationSection(size)
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  bool _confirmDate(DateTime reception) {
    if (initialLimit == null || finalLimit == null) {
      return true;
    }

    if (reception.isAfter(initialLimit!) && reception.isBefore(finalLimit!)) {
      return true;
    }

    return false;
  }

  Widget _envTile(Size size, TableTransact tableT) {
    return Container(
      height: size.height * 0.05,
      width: size.width * 0.7,
      decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey))),
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
              () {
            Navigator.pushReplacementNamed(context, '/consult',
                arguments: tableT.numeroVu);
          }, tableT.numeroVu),
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
              style: ElevatedButton.styleFrom(
                backgroundColor: color,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Icon(icon, size: size.aspectRatio * 6),
            ),
          )
        : _textBox('Traza', size);
  }

  Widget _textBox(String text, Size size) {
    return Container(
      padding: EdgeInsets.only(top: size.height * 0.01),
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
        onChanged: (value) {
          if (int.tryParse(value) != null) {
            setState(() {});
            numVU = int.parse(value);
            filter = true;
          }
          if (value == "") {
            setState(() {});
            numVU = null;
            filter = false;
          }
        },
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

      if (difference >= 0) {
        color = Colors.red[700]!;
      }

      if (difference < 0 && difference > -7) {
        color = Colors.yellow[700]!;
      }

      if (difference <= -7) {
        color = Colors.green[700]!;
      }

      return Padding(
          padding: EdgeInsets.only(
              right: size.width * 0.115,
              bottom: size.width * 0.01,
              top: size.height * 0.01),
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
    TextStyle textStyle = TextStyle(
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
                  Text('Estado', style: textStyle),
                  SizedBox(height: size.height * 0.01),
                  _checkBoxTile(size, (value) {
                    setState(() {});
                    intimeStatus = !intimeStatus;
                    overdueStatus = false;
                    failStatus = false;
                  }, intimeStatus, 'Favorable', Colors.green[700]!),
                  _checkBoxTile(size, (value) {
                    setState(() {});
                    overdueStatus = !overdueStatus;
                    intimeStatus = false;
                    failStatus = false;
                  }, overdueStatus, 'Atrasado', Colors.yellow[700]!),
                  _checkBoxTile(size, (value) {
                    setState(() {});
                    failStatus = !failStatus;
                    overdueStatus = false;
                    intimeStatus = false;
                  }, failStatus, 'Vencido', Colors.red[700]!)
                ],
              ),
              SizedBox(width: size.width * 0.02),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Tipo PQRSF', style: textStyle),
                  SizedBox(height: size.height * 0.01),
                  _checkBoxTile(size, (value) {
                    setState(() {});
                    petitionStatus = !petitionStatus;
                    _uncheckRest(1);
                    if (petitionStatus == true) {
                      type = 1;
                      filter = true;
                    } else {
                      type = null;
                      filter = false;
                    }
                  }, petitionStatus, 'Petición', Colors.white),
                  _checkBoxTile(size, (value) {
                    setState(() {});
                    complaingStatus = !complaingStatus;
                    _uncheckRest(2);
                    if (complaingStatus == true) {
                      type = 2;
                      filter = true;
                    } else {
                      type = null;
                      filter = false;
                    }
                  }, complaingStatus, 'Queja', Colors.white),
                  _checkBoxTile(size, (value) {
                    setState(() {});
                    reclaimStatus = !reclaimStatus;
                    _uncheckRest(3);
                    if (reclaimStatus == true) {
                      type = 3;
                      filter = true;
                    } else {
                      type = null;
                      filter = false;
                    }
                  }, reclaimStatus, 'Reclamo', Colors.white)
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('', style: textStyle),
                  SizedBox(height: size.height * 0.01),
                  _checkBoxTile(size, (value) {
                    setState(() {});
                    adviceStatus = !adviceStatus;
                    _uncheckRest(4);
                    if (adviceStatus == true) {
                      type = 4;
                      filter = true;
                    } else {
                      type = null;
                      filter = false;
                    }
                  }, adviceStatus, 'Sugerencia', Colors.white),
                  _checkBoxTile(size, (value) {
                    setState(() {});
                    congratulationStatus = !congratulationStatus;
                    _uncheckRest(5);
                    if (congratulationStatus == true) {
                      type = 5;
                      filter = true;
                    } else {
                      type = null;
                      filter = false;
                    }
                  }, congratulationStatus, 'Felicitación', Colors.white),
                ],
              ),
              SizedBox(width: size.width * 0.02),
              _dateTile(textStyle, size)
            ],
          ),
        ));
  }

  SizedBox _dateTile(TextStyle textStyle, Size size) {
    return SizedBox(
      height: size.height * 0.17,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Intervalo Fecha', style: textStyle),
          SizedBox(
            height: size.height * 0.01,
          ),
          Row(
            children: [
              Text(
                dateInitial,
                style: textStyle,
              ),
              IconButton(
                  onPressed: () async {
                    DateTime? date = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2020),
                        lastDate: DateTime.now(),
                        helpText: 'Seleccione una fecha',
                        errorFormatText: 'Formato de fecha inválido');
                    if (date != null) {
                      DateFormat formatter = DateFormat("dd/MM/yy");
                      initialLimit = date;
                      dateInitial = formatter.format(date);
                      setState(() {});
                    }
                  },
                  icon: const Icon(Icons.calendar_month, color: Colors.white)),
              Text(' -  ', style: textStyle),
              Text(dateFinal, style: textStyle),
              IconButton(
                  onPressed: () async {
                    DateTime? date = await showDatePicker(
                        initialDatePickerMode: DatePickerMode.day,
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2020),
                        lastDate: DateTime.now(),
                        helpText: 'Seleccione una fecha',
                        errorFormatText: 'Formato de fecha inválido');

                    if (date != null) {
                      DateFormat formatter = DateFormat("dd/MM/yy");
                      finalLimit = date;
                      dateFinal = formatter.format(date);
                      setState(() {});
                    }
                  },
                  icon: const Icon(
                    Icons.calendar_month,
                    color: Colors.white,
                  )),
              SizedBox(
                width: size.width * 0.005,
              ),
              IconButton(
                  onPressed: () {
                    dateFinal = 'dd/mm/YY';
                    dateInitial = 'dd/mm/YY';
                    initialLimit = null;
                    finalLimit = null;
                    setState(() {});
                  },
                  icon: Icon(
                    Icons.delete_outlined,
                    color: Colors.red,
                    size: size.aspectRatio * 18,
                  ))
            ],
          )
        ],
      ),
    );
  }

  Widget _checkBoxTile(Size size, Function(bool?) onChange, bool status,
      String message, Color color) {
    TextStyle textStyle = TextStyle(
        color: color,
        fontSize: size.aspectRatio * 12,
        fontWeight: FontWeight.bold);

    return Container(
      padding: EdgeInsets.only(bottom: size.height * 0.005),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Checkbox(
              activeColor: color,
              checkColor: color,
              value: status,
              shape: const CircleBorder(),
              onChanged: onChange),
          Text(
            message,
            style: textStyle,
          )
        ],
      ),
    );
  }

  void _uncheckRest(int index) {
    if (index == 1) {
      adviceStatus = false;
      complaingStatus = false;
      reclaimStatus = false;
      congratulationStatus = false;
    }
    if (index == 2) {
      adviceStatus = false;
      petitionStatus = false;
      reclaimStatus = false;
      congratulationStatus = false;
    }
    if (index == 3) {
      adviceStatus = false;
      petitionStatus = false;
      complaingStatus = false;
      congratulationStatus = false;
    }
    if (index == 4) {
      reclaimStatus = false;
      petitionStatus = false;
      complaingStatus = false;
      congratulationStatus = false;
    }
    if (index == 5) {
      reclaimStatus = false;
      petitionStatus = false;
      complaingStatus = false;
      adviceStatus = false;
    }
  }
}
