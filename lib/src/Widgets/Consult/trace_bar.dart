import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:pqrsf_webapp/src/Widgets/widgets.dart';
import 'package:provider/provider.dart';

import '../../Controllers/controllers.dart';
import '../../Models/models.dart';

class TraceBar extends StatefulWidget {
  const TraceBar({Key? key}) : super(key: key);

  @override
  State<TraceBar> createState() => _TraceBarState();
}

class _TraceBarState extends State<TraceBar> {
  Color barColor = Colors.white;
  double percent = 0;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    TransactController transactController =
        Provider.of<TransactController>(context);

    TransactShow transact = transactController.selectedTransact;
    List<Traza> trace = transact.traza;

    if (transact.asunto != "") {
      _position(transact, size);
    }

    return Center(
      child: Container(
        margin: EdgeInsets.only(top: size.height * 0.8),
        width: size.width * 0.9,
        height: size.width * 0.015,
        child: LinearPercentIndicator(
          backgroundColor: Colors.white,
          barRadius: const Radius.circular(50),
          lineHeight: size.height * 0.02,
          animationDuration: 1000,
          curve: Curves.bounceIn,
          progressColor: barColor,
          percent: percent,
          center: SizedBox(
            width: (size.width * 0.9) * percent,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: transact.asunto == "" ? [] : _listTrace(trace, size)),
          ),
        ),
      ),
    );
  }

  List<GestureDetector> _listTrace(List<Traza> info, Size size) {
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
        onTap: () {
          TraceDialog().showTraceDialog(context, info[i]);
        },
      ));
    }

    return balls;
  }

  void _position(TransactShow transact, Size size) {
    DateFormat formatter = DateFormat("dd/MM/yyyy");
    DateTime actual = DateTime.now();
    DateTime time = formatter.parse(transact.fechaVencimiento);
    int difference = time.difference(actual).inDays;

    if (difference >= 7) {
      barColor = Colors.green;
    }

    if (difference < 7 && difference >= 0) {
      barColor = Colors.yellow;
    }

    if (difference <= 0) {
      barColor = Colors.red;
    }

    if (difference <= 0) {
      percent = 1;
    } else {
      percent = (15 - difference) / 15;
    }
  }
}
