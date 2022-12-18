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
            Color.fromRGBO(24, 47, 115, 1),
            Color.fromRGBO(5, 12, 69, 0.82),
          ],
          begin: FractionalOffset(0, 0.8),
          end: FractionalOffset(0.8, 1),
        ),
      ),
    );
  }
}
