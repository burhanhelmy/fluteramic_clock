class DayNightConfig {
  static final DayNightConfig _singleton = DayNightConfig._internal();

  factory DayNightConfig() {
    return _singleton;
  }
  DayNightConfig._internal();

  var dayNightInfo = DayNightInfo();

  updateFulldayPercentage({double newValue}) {
    dayNightInfo.fullDayPercentage = newValue;
    updateDayAndNightTimePercentage();
  }

  updateDayAndNightTimePercentage() {
    dayNightInfo.dayTimePercentage = ((dayNightInfo.fullDayPercentage) / 0.50);
    dayNightInfo.nightTimePercentage = dayNightInfo.fullDayPercentage > .5
        ? ((dayNightInfo.fullDayPercentage - 0.50) / 0.50)
        : 0;
  }
}

class DayNightInfo {
  double fullDayPercentage = 0;
  double nightTimePercentage = 0;
  double dayTimePercentage = 0;
}
