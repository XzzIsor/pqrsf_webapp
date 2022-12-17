import 'package:flutter/material.dart';
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
            decoration: BoxDecoration(color: Colors.transparent, boxShadow: [
              BoxShadow(
                  color: Colors.black45,
                  blurRadius: _size.width / _size.height * 12,
                  offset: const Offset(-5, 0))
            ]),
            height: _size.height * 0.7,
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
                      width: _size.width * 0.3,
                    ),
                    _addButton(_size)
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
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
          _textBox(tableT.descripcionTipoTramite, size),
          SizedBox(width: size.width * 0.0005),
          _crudButton(
              size, const Color.fromARGB(255, 19, 4, 158), Icons.edit, () {}),
          SizedBox(width: size.width * 0.005),
          _crudButton(
              size, const Color.fromARGB(255, 143, 4, 4), Icons.delete, () {}),
          SizedBox(width: size.width * 0.005),
          _crudButton(size, const Color.fromARGB(255, 194, 166, 7),
              Icons.content_paste_off, () {})
        ],
      ),
    );
  }

  SizedBox _crudButton(
      Size size, Color color, IconData icon, VoidCallback function) {
    return SizedBox(
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
    );
  }

  Widget _textBox(String text, Size size) {
    return Container(
      height: size.height * 0.04,
      width: size.width * 0.15,
      color: Colors.white,
      child: Text(
        text,
        style: TextStyle(fontSize: size.longestSide / size.shortestSide * 8),
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget _addButton(Size size) {
    return Padding(
      padding: EdgeInsets.only(top: size.height * 0.01),
      child: ElevatedButton(
          onPressed: () {},
          child: Icon(
            Icons.add,
            color: Colors.white,
            size: size.longestSide / size.shortestSide * 16,
          ),
          style: ElevatedButton.styleFrom(
              elevation: 2,
              primary: Colors.green[900],
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(200)))),
    );
  }

  Widget _searchInput(Size size) {
    return SizedBox(
      height: size.height * 0.08,
      width: size.width * 0.15,
      child: TextField(
        onChanged: (value) {},
        style: TextStyle(
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
}
