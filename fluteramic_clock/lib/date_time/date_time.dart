import 'dart:async';

import 'package:fluteramic_clock/date_time/config/date_time.config.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateTimeWidget extends StatefulWidget {
  final bool demoMode;
  DateTimeWidget({this.demoMode = false});

  @override
  _DateTimeWidgetState createState() => _DateTimeWidgetState();
}

class _DateTimeWidgetState extends State<DateTimeWidget>
    with SingleTickerProviderStateMixin {
  AnimationController microAnimationController;

  @override
  void initState() {
    super.initState();
    if (this.widget.demoMode) {
      microAnimationController =
          AnimationController(duration: const Duration(seconds: 1), vsync: this)
            ..repeat();
    }
  }

  @override
  Widget build(BuildContext context) {
    return this.widget.demoMode
        ? AnimatedBuilder(
            animation: microAnimationController,
            builder: (BuildContext context, Widget child) {
              return DemoClock(microAnimationController.value);
            },
          )
        : NormalClock();
  }
}

class NormalClock extends StatefulWidget {
  @override
  _NormalClockState createState() => _NormalClockState();
}

class _NormalClockState extends State<NormalClock>
    with SingleTickerProviderStateMixin {
  DateTimeConfig _dateTimeConfig = DateTimeConfig();

  AnimationController timerStream;

  Stream<int> counterStream;

  @override
  void initState() {
    super.initState();
    counterStream = Stream<int>.periodic(Duration(seconds: 1), (x) => x);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder<Object>(
          stream: counterStream,
          builder: (context, snapshot) {
            return Padding(
              padding: const EdgeInsets.only(left: 60, right: 60),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        DateFormat("h:mm")
                            .format(_dateTimeConfig.currentTime)
                            .toString(),
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 150,
                            fontWeight: FontWeight.w900),
                        maxLines: 1,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 40.0),
                        child: Column(
                          children: <Widget>[
                            Text(
                              DateFormat("ss")
                                  .format(_dateTimeConfig.currentTime),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 25,
                                  fontWeight: FontWeight.w900),
                            ),
                            Text(
                              DateFormat("a")
                                  .format(_dateTimeConfig.currentTime),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 25,
                                  fontWeight: FontWeight.w900),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Center(
                    child: Text(
                      DateFormat("EEE,  d MMM yy")
                          .format(_dateTimeConfig.currentTime)
                          .toString(),
                      style: TextStyle(
                          // shadows: [Shadow(color: Colors.white12, blurRadius: 100)],
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.w900),
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }
}

class DemoClock extends StatefulWidget {
  final percent;
  DemoClock(this.percent);
  @override
  _DemoClockState createState() => _DemoClockState();
}

class _DemoClockState extends State<DemoClock> {
  DateTimeConfig _dateTimeConfig = DateTimeConfig();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 60, right: 60),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Text(
                DateFormat("h:mm")
                    .format(_dateTimeConfig.getDemoTime(this.widget.percent))
                    .toString(),
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 150,
                    fontWeight: FontWeight.w900),
                maxLines: 1,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 45.0),
                child: Column(
                  children: <Widget>[
                    Text(
                      DateFormat("ss").format(
                          _dateTimeConfig.getDemoTime(this.widget.percent)),
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.w900),
                    ),
                    Text(
                      DateFormat("a").format(
                          _dateTimeConfig.getDemoTime(this.widget.percent)),
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.w900),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Center(
            child: Text(
              DateFormat("EEE,  d MMM yy")
                  .format(_dateTimeConfig.getDemoTime(this.widget.percent))
                  .toString(),
              style: TextStyle(
                  // shadows: [Shadow(color: Colors.white12, blurRadius: 100)],
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.w900),
            ),
          ),
        ],
      ),
    );
  }
}
