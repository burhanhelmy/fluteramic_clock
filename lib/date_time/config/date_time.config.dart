enum DateTimeConfigState { OFFSET, NEWDAY }

class DateTimeConfig {
  static final DateTimeConfig _singleton = DateTimeConfig._internal();

  factory DateTimeConfig() {
    return _singleton;
  }

  DateTime _initTime = DateTime.now();
  DateTime _currentDemoTime = DateTime.now();
  DateTimeConfig._internal();

  getTimeAnimationProgress() {
    var now = DateTime.now();
    var originTime = _initTime;
    const oneDayToSecond = 86400;
    originTime = new DateTime(
        originTime.year, originTime.month, originTime.day, 0, 0, 0, 0, 0);
    var animationProgress =
        (now.difference(originTime).inSeconds / oneDayToSecond).abs();
    animationProgress = animationProgress - 0.3 >= 0
        // 0.3 and 0.7 offset is required because of start animation consider from (0)sunrise time
        ? animationProgress - 0.3
        : animationProgress + 0.7;
    if (animationProgress > 1) {
      animationProgress = animationProgress - animationProgress.floor();
    }
    return animationProgress;
  }

  getDemoTime(double animationProgress) {
    var second = animationProgress * 86400;
    _currentDemoTime = new DateTime(
        _initTime.year, _initTime.month, _initTime.day, 10, 0, 0, 0, 0);

    return _currentDemoTime.add(Duration(seconds: second.toInt()));
  }

  resetSettings() {}

  get currentTime {
    return DateTime.now();
  }
}
