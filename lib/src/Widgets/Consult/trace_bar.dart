import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class TraceBar extends StatefulWidget {
  TraceBar({Key? key}) : super(key: key);

  @override
  State<TraceBar> createState() => _TraceBarState();
}

class _TraceBarState extends State<TraceBar> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Center(
      child: Container(
        margin: EdgeInsets.only(top: size.height * 0.8),
        width: size.width * 0.9,
        height: size.width * 0.015,
        child: LinearPercentIndicator(
          backgroundColor: Colors.white,
          barRadius: const Radius.circular(50),
          lineHeight: size.height * 0.02,
          curve: Curves.elasticIn,
          progressColor: Colors.green,
          percent: 0.8,
          center: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: _listTrace(['A', 'Ve', 'Maria'], size)),
        ),
      ),
    );
  }

  List<GestureDetector> _listTrace(List<String> info, Size size) {
    List<GestureDetector> balls = [];

    for (int i = 0; i < info.length; i++) {
      balls.add(GestureDetector(
        child: Container(
          height: size.aspectRatio * 10,
          width: size.aspectRatio * 10,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: Colors.white,
          ),
        ),
        onTap: () {},
      ));
    }

    return balls;
  }
}
