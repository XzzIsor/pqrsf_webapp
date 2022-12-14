import 'package:flutter/material.dart';
import 'package:pqrsf_webapp/src/Views/views.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Material App',
      home: Scaffold(
        body: RegisterPage(),
      ),
    );
  }
}
