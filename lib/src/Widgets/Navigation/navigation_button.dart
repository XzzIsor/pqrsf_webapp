import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class NavigationButton extends StatelessWidget {
  NavigationButton({Key? key}) : super(key: key);

  final ValueNotifier<bool> isDialOpen = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return FloatingActionButton(
      onPressed: () {
        isDialOpen.value = !isDialOpen.value;
      },
      elevation: 10,
      mouseCursor: MouseCursor.defer,
      child: _navigationMenu(size, context),
    );
  }

  SpeedDial _navigationMenu(Size size, BuildContext context) {
    Color color = const Color.fromARGB(255, 55, 92, 202);
    return SpeedDial(
      backgroundColor: color,
      foregroundColor: Colors.black,
      overlayColor: Colors.black26,
      overlayOpacity: 0.5,
      renderOverlay: false,
      closeManually: false,
      spaceBetweenChildren: size.longestSide / size.shortestSide * 2,
      animatedIcon: AnimatedIcons.menu_close,
      openCloseDial: isDialOpen,
      animatedIconTheme:
          IconThemeData(size: size.longestSide / size.shortestSide * 13),
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 300),
      children: [
        SpeedDialChild(
          backgroundColor: color,
          child: const Icon(Icons.data_array),
          label: 'Registrar',
          onTap: () {
            isDialOpen.value = false;
            Navigator.pushReplacementNamed(context, '/register');
          },
        ),
        SpeedDialChild(
          backgroundColor: color,
          child: const Icon(Icons.remove_red_eye),
          label: 'Mostrar',
          onTap: () {
            isDialOpen.value = false;
            Navigator.pushReplacementNamed(context, '/show');
          },
        ),
        SpeedDialChild(
          backgroundColor: color,
          child: const Icon(Icons.search),
          label: 'Consultar',
          onTap: () {
            isDialOpen.value = false;
            Navigator.pushReplacementNamed(context, '/consult');
          },
        ),
        SpeedDialChild(
          backgroundColor: color,
          child: const Icon(Icons.document_scanner),
          label: 'Informe',
          onTap: () {
            isDialOpen.value = false;
            Navigator.pushReplacementNamed(context, '/info');
          },
        ),
      ],
    );
  }
}
