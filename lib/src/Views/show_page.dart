import 'package:flutter/material.dart';
import 'package:pqrsf_webapp/src/Widgets/widgets.dart';

class ShowPage extends StatelessWidget {
  const ShowPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: NavigationButton(),
      body: Stack(
        children: const [BackgroundTheme(), TransactTable()],
      ),
    );
  }
}
