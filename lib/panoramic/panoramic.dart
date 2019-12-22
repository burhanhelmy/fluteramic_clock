import 'package:fluteramic_clock/date_time/provider/date_time.provider.dart';
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
    microAnimationController = AnimationController(
        // TODO: adjust lower bound base on current time
        // duration: const Duration(seconds: 100),
        duration: const Duration(seconds: 86400),
        vsync: this,
        lowerBound: 0.0)
      ..repeat();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: microAnimationController,
      builder: (BuildContext context, Widget child) {
        _dayNightConfig.updateFulldayPercentage(
            newValue: _dayTimeConfig.getTimeAnimationOffset() - 0.3 >= 0
                // 0.3 and 0.7 offset for current animation timeframe which is start animation consider from sunrise time
                ? _dayTimeConfig.getTimeAnimationOffset() - 0.3
                : _dayTimeConfig.getTimeAnimationOffset() + 0.7);
        return CustomPaint(
          painter: PanoramicPainter(),
          child: Container(),
        );
      },
    );
  }
}
