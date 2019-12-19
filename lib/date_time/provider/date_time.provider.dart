import 'dart:math';

import 'package:flutter/material.dart';

enum ConfigState { NULL, GENERATED }

class DateTimeProvider {
  static final DateTimeProvider _singleton = DateTimeProvider._internal();

  factory DateTimeProvider() {
    return _singleton;
  }

  int starsCount = 0;
  ConfigState state = ConfigState.NULL;
  List<List<double>> starsPositions = [];
  Random rnd = Random();

  DateTimeProvider._internal();

  generateStarSettings(Size size) {
    starsCount = (50 + rnd.nextInt(100));
    for (var i = 0; i < starsCount; i++) {
      var xpos = (0 + rnd.nextInt(size.width.toInt())).toDouble();
      var ypos = (0 + rnd.nextInt(size.height.toInt() ~/ 2)).toDouble();
      starsPositions.add([xpos, ypos]);
    }
    print("generated");
    state = ConfigState.GENERATED;
  }

  resetSettings() {
    starsCount = 0;
    starsPositions = [];
    state = ConfigState.NULL;
  }
}
