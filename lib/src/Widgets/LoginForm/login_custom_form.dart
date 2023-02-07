import 'package:flutter/material.dart';

class LoginCustomForm extends StatelessWidget {
  const LoginCustomForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return SizedBox(
      width: size.width * 0.6,
      height: size.width * 0.6,
      child: Center(
        child: Row(
          children: [
            Container(
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(25),
                      topLeft: Radius.circular(25)),
                  gradient: LinearGradient(colors: [
                    Color.fromRGBO(181, 0, 0, 1),
                    Color.fromRGBO(162, 0, 0, 0.83),
                  ], begin: Alignment(0.5, 1), end: Alignment(0.8, 0))),
            ),
            Container(
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(25),
                        topRight: Radius.circular(25)),
                    color: Colors.white)),
          ],
        ),
      ),
    );
  }
}
