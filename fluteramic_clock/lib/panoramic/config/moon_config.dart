import 'dart:math';

import 'package:fluteramic_clock/panoramic/config/day_night_config.dart';

class MoonConfig {
  static final MoonConfig _singleton = MoonConfig._internal();

  factory MoonConfig() {
    return _singleton;
  }
  MoonConfig._internal();

  DayNightConfig _dayNightConfig = DayNightConfig();

  getMoonOpacity() {
    var nightTimePercentage = _dayNightConfig.dayNightInfo.nightTimePercentage;
    return (-4 * pow((nightTimePercentage), 2)) + (4 * nightTimePercentage);
  }
}
