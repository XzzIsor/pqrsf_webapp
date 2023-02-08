import 'package:flutter/material.dart';

class InformGenerator extends StatefulWidget {
  const InformGenerator({Key? key}) : super(key: key);

  @override
  State<InformGenerator> createState() => _InformGeneratorState();
}

class _InformGeneratorState extends State<InformGenerator> {
  int year = DateTime.now().year;
  int selectedIndex = -1;
  List<Color> textColors = [
    Colors.black,
    Colors.black,
    Colors.black,
    Colors.black
  ];

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(top: size.height * 0.15),
      child: Center(
        child: Column(
          children: [
            _titleLabel(size),
            _dateSelector(size),
            SizedBox(height: size.height * 0.1),
            _generateButton(size)
          ],
        ),
      ),
    );
  }

  Container _titleLabel(Size size) {
    return Container(
      width: size.width * 0.3,
      height: size.height * 0.07,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50), color: Colors.white),
      child: Center(
        child: Text(
          'Seleccionar Trimestre',
          style: TextStyle(
              color: Colors.black,
              fontSize: size.aspectRatio * 20,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Container _dateSelector(Size size) {
    return Container(
      width: size.width * 0.25,
      height: size.height * 0.27,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20)),
          color: Colors.white),
      child: Center(
          child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                  onPressed: () {
                    setState(() {
                      year -= 1;
                    });
                  },
                  icon: Icon(
                    Icons.arrow_circle_left_outlined,
                    size: size.aspectRatio * 15,
                  )),
              Text(
                '$year',
                style: TextStyle(
                    color: Colors.red,
                    fontSize: size.aspectRatio * 15,
                    fontWeight: FontWeight.bold),
              ),
              IconButton(
                  onPressed: () {
                    setState(() {
                      int actualYear = DateTime.now().year;
                      if (year == actualYear) {
                        return;
                      }
                      year += 1;
                    });
                  },
                  icon: Icon(
                    Icons.arrow_circle_right_outlined,
                    size: size.aspectRatio * 15,
                  ))
            ],
          ),
          _trimester('Enero 1 - Marzo 31', size, 0),
          _trimester('Abril 1 - Junio 31', size, 1),
          _trimester('Julio 1 - Septiembre 31', size, 2),
          _trimester('Octubre 1 - Diciembre 31', size, 3),
        ],
      )),
    );
  }

  Container _trimester(String label, Size size, int index) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: size.height * 0.01),
      child: GestureDetector(
        child: Text(label,
            style: TextStyle(
                color: textColors[index],
                fontSize: size.aspectRatio * 12,
                fontWeight: FontWeight.bold)),
        onTap: () {
          if (selectedIndex != -1) {
            textColors[selectedIndex] = Colors.black;
          }
          selectedIndex = index;
          textColors[selectedIndex] = Colors.red;
          setState(() {});
        },
      ),
    );
  }

  ElevatedButton _generateButton(Size size) {
    return ElevatedButton(
        onPressed: selectedIndex != -1
            ? () {
                Navigator.pushNamed(context, '/download');
              }
            : null,
        style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromRGBO(181, 0, 0, 1),
            foregroundColor: Colors.white,
            fixedSize: Size(size.width * 0.09, size.height * 0.07),
            elevation: 12,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10))),
        child: Text(
          'Generar',
          style: TextStyle(
              color: Colors.white,
              fontSize: size.aspectRatio * 15,
              fontWeight: FontWeight.bold),
        ));
  }
}
