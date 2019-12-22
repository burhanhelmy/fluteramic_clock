import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

enum SeaWaveConfigState { NULL, GENERATED }

class SeaWaveConfig {
  static final SeaWaveConfig _singleton = SeaWaveConfig._internal();

  factory SeaWaveConfig() {
    return _singleton;
  }

  int seaWaveCount = 0;
  SeaWaveConfigState state = SeaWaveConfigState.NULL;
  List<SeaWaveInfo> seaWavesInfo = [];
  Random _rnd = Random();
  bool seaWaveOpacityGeneratorIsRunning = false;

  SeaWaveConfig._internal();

  generateSeaWaveSettings(Size size) {
    seaWaveCount = (50 + _rnd.nextInt(100));
    for (var i = 0; i < seaWaveCount; i++) {
      var xpos = (_rnd.nextInt(size.width.toInt())).toDouble();
      var ypos = (_rnd.nextInt((size.height.toInt() ~/ 2))).toDouble();
      var width = 100 * _rnd.nextDouble();
      seaWavesInfo.add(SeaWaveInfo([xpos, (ypos + size.height ~/ 2)],
          Size(width, 15 * (ypos / size.height)), _getWaveColor));
    }
    if (!seaWaveOpacityGeneratorIsRunning) {
      startRegenerateWaveColor();
    }
    state = SeaWaveConfigState.GENERATED;
  }

  get _getWaveColor {
    var isBlack = false;
    return isBlack
        ? Colors.black.withOpacity(_rnd.nextDouble())
        : Colors.white.withOpacity(_rnd.nextDouble());
  }

  startRegenerateWaveColor() {
    seaWaveOpacityGeneratorIsRunning = true;
    Timer.periodic(new Duration(seconds: 2), (timer) {
      for (var i = 0; i < seaWaveCount; i++) {
        seaWavesInfo[i].color = _getWaveColor;
      }
    });
  }

  resetSettings() {
    seaWaveCount = 0;
    seaWavesInfo = [];
    state = SeaWaveConfigState.NULL;
  }
}

class SeaWaveInfo {
  SeaWaveInfo(this.coordinate, this.size, this.color);
  List<double> coordinate = [];
  Size size = Size(0, 0);
  Color color = Colors.white10;
}
