import 'package:fluteramic_clock/date_time/provider/date_time.config.dart';
import 'package:fluteramic_clock/panoramic/panoramic_painter.dart';
import 'package:fluteramic_clock/panoramic/provider/day_night_config.dart';
import 'package:flutter/material.dart';

class Panoramic extends StatefulWidget {
  @override
  _PanoramicState createState() => _PanoramicState();
}

class _PanoramicState extends State<Panoramic>
    with SingleTickerProviderStateMixin {
  AnimationController microAnimationController;
  DayNightConfig _dayNightConfig = DayNightConfig();
  DateTimeConfig _dayTimeConfig = DateTimeConfig();

  @override
  void initState() {
    super.initState();
    microAnimationController =
        AnimationController(duration: const Duration(seconds: 10), vsync: this)
          ..repeat();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: microAnimationController,
      builder: (BuildContext context, Widget child) {
        _dayNightConfig.updateFulldayPercentage(
            newValue: _dayTimeConfig.getTimeAnimationProgress());
        return CustomPaint(
          willChange: true,
          isComplex: true,
          painter: PanoramicPainter(microAnimationController.value),
          child: Container(),
        );
      },
    );
  }
}
