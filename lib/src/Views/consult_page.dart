import 'package:flutter/material.dart';
import 'package:pqrsf_webapp/src/Widgets/background_theme.dart';
import 'package:pqrsf_webapp/src/Widgets/widgets.dart';

class ConsultPage extends StatelessWidget {
  const ConsultPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: NavigationButton(),
        body: Stack(
          children: const [BackgroundTheme(), SearchRow(), InfoPanel()],
        ));
  }
}
