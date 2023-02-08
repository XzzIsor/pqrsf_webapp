import 'package:flutter/material.dart';
import 'package:pqrsf_webapp/src/Controllers/controllers.dart';
import 'package:pqrsf_webapp/src/Widgets/widgets.dart';
import 'package:provider/provider.dart';

class SearchRow extends StatelessWidget {
  const SearchRow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TransactController transactController =
        Provider.of<TransactController>(context);

    final Size size = MediaQuery.of(context).size;
    final double margin = size.width * 0.02;
    String numVU = transactController.selectedVU;
    final formKey = GlobalKey<FormState>();

    final styleButton = ElevatedButton.styleFrom(
      elevation: 12,
      fixedSize: Size(size.width * 0.07, size.height * 0.04),
      backgroundColor: const Color.fromRGBO(181, 0, 0, 1),
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      textStyle: TextStyle(
          fontWeight: FontWeight.bold, fontSize: size.aspectRatio * 10),
    );

    final styleButtonTrace = ElevatedButton.styleFrom(
      elevation: 12,
      fixedSize: Size(size.width * 0.07, size.height * 0.04),
      backgroundColor: const Color.fromARGB(255, 6, 143, 197),
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      textStyle: TextStyle(
          fontWeight: FontWeight.bold, fontSize: size.aspectRatio * 10),
    );

    return Container(
      margin: EdgeInsets.symmetric(horizontal: size.width * 0.03),
      width: size.width * 0.9,
      height: size.height * 0.15,
      child: Form(
        key: formKey,
        child: Row(children: [
          SizedBox(
            width: size.width * 0.17,
            child: CustomTextField(
              initialValue: numVU == "" ? "" : numVU,
              label: 'Número VU',
              icon: Icons.search,
              hintText: '###########',
              onChange: (value) {
                if (int.tryParse(value) != null) {
                  numVU = value;
                }
              },
              numberType: false,
              obscureText: false,
              validator: (value) {
                if (int.tryParse(value!) == null) {
                  return "Ingrese un dato numértico válido";
                }
                return null;
              },
            ),
          ),
          SizedBox(width: margin),
          ElevatedButton(
            onPressed: () async {
              if (formKey.currentState!.validate()) {
                await transactController.getTransactByID(int.parse(numVU));
              }
            },
            style: styleButton,
            child: const Text('Mostrar'),
          ),
          SizedBox(width: margin),
          ElevatedButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  Navigator.pushReplacementNamed(context, '/trace',
                      arguments: numVU);
                }
              },
              style: styleButtonTrace,
              child: const Text('Traza')),
          SizedBox(width: margin),
        ]),
      ),
    );
  }
}
