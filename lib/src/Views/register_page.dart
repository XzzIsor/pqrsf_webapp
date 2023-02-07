import 'package:flutter/material.dart';
import 'package:pqrsf_webapp/src/Controllers/controllers.dart';
import 'package:pqrsf_webapp/src/Widgets/widgets.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => DataInfoController()),
        ChangeNotifierProvider(create: (context) => TransactController())
      ],
      child: Scaffold(
        floatingActionButton: NavigationButton(),
        body: Center(child: RegisterForm()),
      ),
    );
  }
}
