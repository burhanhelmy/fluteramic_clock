import 'package:fluteramic_clock/panoramic/panoramic_painter.dart';
import 'package:fluteramic_clock/panoramic/provider/day_night_config.dart';
import 'package:flutter/material.dart';

class Panoramic extends StatefulWidget {
  @override
  _PanoramicState createState() => _PanoramicState();
}

class _PanoramicState extends State<Panoramic>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  DayNightConfig _dayNightConfig = DayNightConfig();

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        // TODO: adjust lower bound base on current time
        duration: const Duration(seconds: 86400),
        vsync: this,
        lowerBound: 0.8)
      ..repeat();
  }

  @override
  Widget build(BuildContext context) {
    // print(_dayNightConfig.dayNightInfo.fullDayPercentage);
    return AnimatedBuilder(
      animation: controller,
      builder: (BuildContext context, Widget child) {
        _dayNightConfig.updateFulldayPercentage(newValue: controller.value);
        return CustomPaint(
          painter: PanoramicPainter(),
          child: Container(),
        );
      },
    );
  }
}
