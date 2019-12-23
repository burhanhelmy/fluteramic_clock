import 'dart:math';
import 'dart:ui';

class AeroplaneConfig {
  static final AeroplaneConfig _singleton = AeroplaneConfig._internal();

  factory AeroplaneConfig() {
    return _singleton;
  }
  AeroplaneConfig._internal();

  Random _rnd = Random();

  double aeroplaneHeight = 100.0;
  var chars = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
  var char = 'W';

  updateAeroplaneSettings(Size size) {
    char = chars[_rnd.nextInt(chars.length)];
    aeroplaneHeight = (_rnd.nextInt(size.height.toInt() ~/ 2)).toDouble();
  }
}
