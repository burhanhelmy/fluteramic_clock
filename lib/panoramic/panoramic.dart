import 'package:fluteramic_clock/date_time/config/date_time.config.dart';
import 'package:fluteramic_clock/panoramic/panoramic_painter.dart';
import 'package:fluteramic_clock/panoramic/config/day_night_config.dart';
import 'package:flutter/material.dart';

class Panoramic extends StatefulWidget {
  final demoMode;

  Panoramic({this.demoMode = false});
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
        AnimationController(duration: const Duration(seconds: 20), vsync: this)
          ..repeat();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: microAnimationController,
      builder: (BuildContext context, Widget child) {
        _dayNightConfig.updateFulldayPercentage(
            newValue: this.widget.demoMode
                ? microAnimationController.value
                : _dayTimeConfig.getTimeAnimationProgress());
        return CustomPaint(
          painter: PanoramicPainter(microAnimationController.value),
          child: Container(),
        );
      },
    );
  }
}
