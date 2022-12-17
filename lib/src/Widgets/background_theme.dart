import 'package:flutter/material.dart';

class BackgroundTheme extends StatelessWidget {
  const BackgroundTheme({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 4, 16, 102),
            Color.fromARGB(255, 55, 92, 202),
          ],
          begin: FractionalOffset(0, 0.8),
          end: FractionalOffset(0.8, 1),
        ),
      ),
    );
  }
}
