import 'package:flutter/material.dart';
import 'package:pqrsf_webapp/src/Widgets/widgets.dart';

class InformGeneratePage extends StatelessWidget {
  const InformGeneratePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: const [BackgroundTheme(), DownloadSection()],
      ),
    );
  }
}
