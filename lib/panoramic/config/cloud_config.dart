import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

enum CloudConfigState { NULL, GENERATED }

class CloudConfig {
  static final CloudConfig _singleton = CloudConfig._internal();

  factory CloudConfig() {
    return _singleton;
  }

  int cloudCount = 0;
  CloudConfigState state = CloudConfigState.NULL;
  List<CloudInfo> clouds = [];
  Random _rnd = Random();
  bool cloudOpacityGeneratorIsRunning = false;

  CloudConfig._internal();

  generateCloudSettings(Size size) {
    var chars = 'cdef';
    // var chars = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
    cloudCount = (6 + _rnd.nextInt(10));
    for (var i = 0; i < cloudCount; i++) {
      var xpos = (_rnd.nextInt(size.width.toInt())).toDouble();
      var ypos = (_rnd.nextInt(size.height.toInt() ~/ 3)).toDouble();
      clouds
          .add(CloudInfo([xpos, ypos], 0.1, chars[_rnd.nextInt(chars.length)]));
    }
    if (!cloudOpacityGeneratorIsRunning) {
      startRegenerateCloudOpacity();
    }
    state = CloudConfigState.GENERATED;
  }

  startRegenerateCloudOpacity() {
    cloudOpacityGeneratorIsRunning = true;
    Timer.periodic(new Duration(milliseconds: 100), (timer) {
      for (var i = 0; i < cloudCount; i++) {
        clouds[i].opacity = 0.5;
      }
    });
  }

  resetSettings() {
    cloudCount = 0;
    clouds = [];
    state = CloudConfigState.NULL;
  }
}

class CloudInfo {
  CloudInfo(this.offset, this.opacity, this.char);
  List<double> offset = [];
  double opacity = 0;
  String char = 'A';
}
