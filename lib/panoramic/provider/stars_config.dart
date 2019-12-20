import 'dart:async';
import 'dart:math';

import 'package:fluteramic_clock/panoramic/provider/moon_config.dart';
import 'package:flutter/material.dart';

enum StarConfigState { NULL, GENERATED }

class StarsConfig {
  static final StarsConfig _singleton = StarsConfig._internal();

  factory StarsConfig() {
    return _singleton;
  }

  int starsCount = 0;
  StarConfigState state = StarConfigState.NULL;
  List<StarInfo> starsPositions = [];
  Random rnd = Random();
  bool starOpacityGeneratorIsRunning = false;
  MoonConfig _moonConfig = MoonConfig();

  StarsConfig._internal();

  generateStarSettings(Size size) {
    starsCount = (50 + rnd.nextInt(100));
    for (var i = 0; i < starsCount; i++) {
      var xpos = (0 + rnd.nextInt(size.width.toInt())).toDouble();
      var ypos = (0 + rnd.nextInt(size.height.toInt() ~/ 2)).toDouble();
      starsPositions.add(StarInfo([xpos, ypos], 0.1));
    }
    if (!starOpacityGeneratorIsRunning) {
      startRegenerateStarOpacity();
    }
    state = StarConfigState.GENERATED;
  }

  get _getStarOpacity {
    return (rnd.nextInt(1 + (_moonConfig.getMoonOpacity() * 100).round()) /
        100);
  }

  startRegenerateStarOpacity() {
    starOpacityGeneratorIsRunning = true;
    Timer.periodic(new Duration(milliseconds: 800), (timer) {
      for (var i = 0; i < starsCount; i++) {
        starsPositions[i].opacity = _getStarOpacity;
      }
    });
  }

  resetSettings() {
    starsCount = 0;
    starsPositions = [];
    state = StarConfigState.NULL;
  }
}

class StarInfo {
  StarInfo(this.coordinate, this.opacity);
  List<double> coordinate = [];
  double opacity = 0;
}
