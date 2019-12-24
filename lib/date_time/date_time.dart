import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateTimeWidget extends StatefulWidget {
  @override
  _DateTimeWidgetState createState() => _DateTimeWidgetState();
}

class _DateTimeWidgetState extends State<DateTimeWidget> {
  @override
  void initState() {
    super.initState();
    Timer.periodic(new Duration(seconds: 1), (timer) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                (new DateFormat("h:mm").format(new DateTime.now())).toString(),
                style: TextStyle(
                    shadows: [Shadow(color: Colors.white12, blurRadius: 100)],
                    color: Colors.white,
                    fontSize: 170,
                    fontWeight: FontWeight.w900),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    (new DateFormat("ss").format(new DateTime.now())),
                    style: TextStyle(
                        shadows: [
                          Shadow(color: Colors.white12, blurRadius: 100)
                        ],
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.w900),
                  ),
                  Text(
                    (new DateFormat("a").format(new DateTime.now())),
                    style: TextStyle(
                        shadows: [
                          Shadow(color: Colors.white12, blurRadius: 100)
                        ],
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.w900),
                  ),
                ],
              ),
            ],
          ),
          Center(
            child: Text(
              (new DateFormat("EEEE,  d MMM yy").format(new DateTime.now()))
                  .toString(),
              style: TextStyle(
                  shadows: [Shadow(color: Colors.white12, blurRadius: 100)],
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.w800),
            ),
          ),
        ],
      ),
    );
  }
}
