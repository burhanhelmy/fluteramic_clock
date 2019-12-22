enum DateTimeConfigState { OFFSET, NEWDAY }

class DateTimeConfig {
  static final DateTimeConfig _singleton = DateTimeConfig._internal();

  factory DateTimeConfig() {
    return _singleton;
  }

  DateTime _initTime = DateTime.now();
  DateTimeConfig._internal();

  getTimeAnimationOffset() {
    var now = DateTime.now();
    var originTime = _initTime;
    const oneDayToSecond = 86400;
    originTime = new DateTime(
        originTime.year, originTime.month, originTime.day, 0, 0, 0, 0, 0);
    return now.difference(originTime).inSeconds / oneDayToSecond;
  }

  resetSettings() {}
}
