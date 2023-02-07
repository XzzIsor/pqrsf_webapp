import 'package:flutter/material.dart';

import 'package:pqrsf_webapp/src/Views/show_page.dart';
import 'package:pqrsf_webapp/src/Views/views.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PQRSF Unicauca',
      initialRoute: '/show',
      routes: {
        '/register': (_) => const RegisterPage(),
        '/show': (_) => const ShowPage(),
        '/consult': (_) => const ConsultPage(),
        '/info': (_) => const InformPage(),
        '/download': (_) => const InformGeneratePage()
      },
    );
  }
}
