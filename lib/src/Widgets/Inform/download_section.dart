import 'package:flutter/material.dart';

class DownloadSection extends StatelessWidget {
  const DownloadSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.all(size.aspectRatio * 10),
      child: Row(
        children: [
          Container(
            width: size.width * 0.45,
            height: size.height * 0.9,
            decoration: BoxDecoration(
                color: Colors.grey, borderRadius: BorderRadius.circular(15)),
          ),
          SizedBox(
            width: size.width * 0.25,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _actionButton('Descargar', size, () {}),
              _actionButton('Regresar', size, () {
                Navigator.pushReplacementNamed(context, '/info');
              })
            ],
          )
        ],
      ),
    );
  }

  ElevatedButton _actionButton(String label, Size size, VoidCallback onPress) {
    return ElevatedButton(
        onPressed: onPress,
        style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromRGBO(181, 0, 0, 1),
            foregroundColor: Colors.white,
            fixedSize: Size(size.width * 0.1, size.height * 0.08),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15))),
        child: Text(
          label,
          style: TextStyle(
              color: Colors.white,
              fontSize: size.aspectRatio * 15,
              fontWeight: FontWeight.bold),
        ));
  }
}
