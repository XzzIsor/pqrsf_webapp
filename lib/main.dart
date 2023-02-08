import 'package:flutter/material.dart';

import 'package:pqrsf_webapp/src/Views/views.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PQRSF Unicauca App',
      initialRoute: '/register',
      routes: {
        '/register': (_) => const RegisterPage(),
        '/show': (_) => const ShowPage(),
        '/consult': (_) => const ConsultPage(),
        '/info': (_) => const InformPage(),
        '/download': (_) => const InformGeneratePage(),
        '/trace': (_) => const TraceRegisterPage()
      },
    );
  }
}
