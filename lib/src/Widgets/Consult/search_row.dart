import 'package:flutter/material.dart';
import 'package:pqrsf_webapp/src/Widgets/widgets.dart';

class SearchRow extends StatelessWidget {
  const SearchRow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double margin = size.width * 0.02;

    final styleButton = ElevatedButton.styleFrom(
      elevation: 12,
      fixedSize: Size(size.width * 0.07, size.height * 0.04),
      backgroundColor: const Color.fromRGBO(181, 0, 0, 1),
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      textStyle: TextStyle(
          fontWeight: FontWeight.bold, fontSize: size.aspectRatio * 10),
    );

    final styleTransactButton = ElevatedButton.styleFrom(
      elevation: 12,
      fixedSize: Size(size.width * 0.07, size.height * 0.04),
      backgroundColor: const Color.fromARGB(255, 8, 170, 8),
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
        child: Row(children: [
          SizedBox(
            width: size.width * 0.17,
            child: CustomTextField(
                label: 'Número VU',
                icon: Icons.search,
                hintText: '###########',
                onChange: (value) {},
                emailType: false,
                obscureText: false),
          ),
          SizedBox(width: margin),
          ElevatedButton(
            onPressed: () {},
            style: styleButton,
            child: const Text('Mostrar'),
          ),
          SizedBox(width: margin),
          ElevatedButton(
              onPressed: () {},
              style: styleButton,
              child: const Text('Editar')),
          SizedBox(width: margin),
          ElevatedButton(
              onPressed: () {},
              style: styleButton,
              child: const Text('Eliminar')),
        ]),
      ),
    );
  }
}
