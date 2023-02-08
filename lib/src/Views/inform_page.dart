import 'package:flutter/material.dart';
import 'package:pqrsf_webapp/src/Widgets/widgets.dart';

class InformPage extends StatelessWidget {
  const InformPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: NavigationButton(),
      body: Stack(
        children: const [BackgroundTheme(), InformGenerator()],
      ),
    );
  }
}
