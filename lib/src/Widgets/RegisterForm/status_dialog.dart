import 'package:flutter/material.dart';

class StatusDialog {
  Future<void> showStatusDialog(BuildContext context, String message) async {
    return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          Size size = MediaQuery.of(context).size;

          return AlertDialog(
            backgroundColor: Colors.transparent,
            content: Container(
              padding: EdgeInsets.all(size.aspectRatio * 5),
              width: size.width * 0.3,
              height: size.height * 0.3,
              decoration: BoxDecoration(
                  color: Color.fromRGBO(47, 45, 125, 1),
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.white)),
              child: Center(
                child: Text(
                  message,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: size.aspectRatio * 15),
                ),
              ),
            ),
            elevation: 24,
          );
        });
  }
}
