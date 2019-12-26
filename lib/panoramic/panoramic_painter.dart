import 'dart:math';

import 'package:fluteramic_clock/panoramic/panoramic_colors.dart';
import 'package:fluteramic_clock/panoramic/provider/aeroplane_config.dart';
import 'package:fluteramic_clock/panoramic/provider/cloud_config.dart';
import 'package:fluteramic_clock/panoramic/provider/day_night_config.dart';
import 'package:fluteramic_clock/panoramic/provider/moon_config.dart';
import 'package:fluteramic_clock/panoramic/provider/sea_wave_config.dart';
import 'package:fluteramic_clock/panoramic/provider/stars_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

enum ColorFor {
  sky,
  sea,
  mountain,
  smallMountain,
  backgroundLand,
  smallBackgroundLand,
}

class PanoramicPainter extends CustomPainter {
  PanoramicPainter(this._microAnimationValue);
  double _microAnimationValue;
  StarsConfig _starConfig = StarsConfig();
  SeaWaveConfig _seaWaveConfig = SeaWaveConfig();
  CloudConfig _cloudConfig = CloudConfig();
  MoonConfig _moonConfig = MoonConfig();
  AeroplaneConfig _aeroplaneConfig = AeroplaneConfig();
  DayNightConfig _dayNightConfig = DayNightConfig();
  double _fullDayPercentage = 0;
  double _nightTimePercentage = 0;
  double _dayTimePercentage = 0;

  List<Color> _getColors(ColorFor colorFor) {
    var colors;
    switch (colorFor) {
      case ColorFor.sky:
        colors = SkyColors();
        break;
      case ColorFor.sea:
        colors = SeaColors();
        break;
      case ColorFor.mountain:
        colors = MountainColors();
        break;
      case ColorFor.smallMountain:
        colors = SmallMountainColors();
        break;
      case ColorFor.backgroundLand:
        colors = BackgroundLandColors();
        break;
      case ColorFor.smallBackgroundLand:
        colors = SmallBackgroundLandColors();
        break;
      default:
    }

    return [
      Color.lerp(
          colors.primary[
              (_fullDayPercentage * 100) - ((_fullDayPercentage * 100) % 25)],
          colors.primary[(_fullDayPercentage * 100) -
                      ((_fullDayPercentage * 100) % 25) +
                      25 <
                  100
              ? (_fullDayPercentage * 100) -
                  ((_fullDayPercentage * 100) % 25) +
                  25
              : 0],
          calculateSessionPecentage),
      Color.lerp(
          colors.secondary[
              (_fullDayPercentage * 100) - ((_fullDayPercentage * 100) % 25)],
          colors.secondary[(_fullDayPercentage * 100) -
                      ((_fullDayPercentage * 100) % 25) +
                      25 <
                  100
              ? (_fullDayPercentage * 100) -
                  ((_fullDayPercentage * 100) % 25) +
                  25
              : 0],
          calculateSessionPecentage),
    ];
  }

  _drawSky(Canvas canvas, Size size) {
    var sky = Offset.zero & Size(size.width, size.height / 2);
    var skyGradient = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: _getColors(ColorFor.sky),
      stops: [0, 1],
    );
    canvas.drawRect(
      sky,
      Paint()..shader = skyGradient.createShader(sky),
    );
  }

  _drawSun(Canvas canvas, Size size) {
    var sunXValue = _dayTimePercentage;
    var sun = Offset.zero & size;
    var sunGradient = RadialGradient(
      center: Alignment(
          (sunXValue) - 0.25, _getSunYValue(sunXValue) + 0.2), // added offset
      radius: 1 - (0.5 * _dayTimePercentage),
      colors: [
        Color.lerp(Color(0xFFFFFFFF), Colors.red, _dayTimePercentage),
        Color.lerp(Color(0xFFFFC400), Colors.transparent, _dayTimePercentage),
        Colors.transparent
      ],
      stops: [0.1, 0.09, 1],
    );
    canvas.drawRect(
        sun,
        Paint()
          ..shader = sunGradient.createShader(sun)
          ..blendMode = BlendMode.overlay);
  }

  _drawMoon(Canvas canvas, Size size) {
    var moon = Offset.zero & size;
    var moonGradient = RadialGradient(
      center: Alignment(0.38, -0.5 * _fullDayPercentage - 0.25), // added offset
      radius: 0.25 * _nightTimePercentage,
      colors: [
        Colors.transparent,
        Color.fromRGBO(255, 255, 46, _moonConfig.getMoonOpacity()),
      ],
      stops: [0.5, 0.4],
    );
    canvas.drawCircle(
        Offset.zero
            .translate(size.width / 1.5, size.width / 7.3), //ok for tablet
        70 * _nightTimePercentage,
        Paint()
          ..strokeWidth = 30
          ..strokeCap = StrokeCap.round
          ..shader = moonGradient.createShader(moon)
          ..blendMode = BlendMode.hardLight);
  }

  _resetConfigSettings() {
    if (_fullDayPercentage >= 0.9999) {
      _starConfig.resetSettings();
      _seaWaveConfig.resetSettings();
      _cloudConfig.resetSettings();
    }
  }

  _drawStars(Canvas canvas, Size size) {
    if (_starConfig.state == StarConfigState.NULL) {
      _starConfig.generateStarSettings(size);
    }
    _starConfig.stars.forEach((starInfo) => {
          canvas.drawCircle(
              Offset.zero
                  .translate(starInfo.coordinate[0], starInfo.coordinate[1]),
              starInfo.size,
              Paint()
                ..strokeWidth = 30
                ..strokeCap = StrokeCap.round
                ..color = Color.fromRGBO(255, 255, 46, starInfo.opacity))
        });
  }

  _drawSeaWave(Canvas canvas, Size size) {
    _resetConfigSettings();
    if (_seaWaveConfig.state == SeaWaveConfigState.NULL) {
      _seaWaveConfig.generateSeaWaveSettings(size);
    }
    _seaWaveConfig.seaWavesInfo.forEach((seaWaveInfo) => {
          canvas.drawLine(
              Offset.zero.translate(
                  seaWaveInfo.coordinate[0], seaWaveInfo.coordinate[1]),
              Offset.zero.translate(
                  seaWaveInfo.coordinate[0] + seaWaveInfo.size.width,
                  seaWaveInfo.coordinate[1]),
              Paint()
                ..strokeWidth = seaWaveInfo.size.height
                ..strokeCap = StrokeCap.round
                ..color = seaWaveInfo.color
                ..blendMode = BlendMode.overlay)
        });
  }

  _drawAeroplane(Canvas canvas, Size size) {
    if (_microAnimationValue >= 0.99) {
      _aeroplaneConfig.updateAeroplaneSettings(size);
    }
    final textStyle = TextStyle(
      color: _getColors(ColorFor.sea)[0],
      fontSize: 15,
      fontFamily: 'PLANES',
    );
    final textSpan = TextSpan(
      text: _aeroplaneConfig.char,
      style: textStyle,
    );
    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.rtl,
    );
    textPainter.layout(
      minWidth: 0,
      maxWidth: size.width,
    );
    var offset = Offset(
        (size.width) - ((size.width + 100) * _microAnimationValue),
        _aeroplaneConfig.aeroplaneHeight);
    textPainter.paint(canvas, offset);
  }

  get _getCloudOpacity {
    var opacity =
        (-4 * pow((_dayTimePercentage), 2)) + (4 * _dayTimePercentage);
    if (opacity >= 0) {
      return opacity;
    } else {
      return 0.0;
    }
  }

  _drawCloud(Canvas canvas, Size size) {
    if (_fullDayPercentage >= 0.9999) {
      _cloudConfig.resetSettings();
    }
    if (_cloudConfig.state == CloudConfigState.NULL) {
      _cloudConfig.generateCloudSettings(size);
    }

    var textStyle;
    var textSpan;
    TextPainter textPainter;
    var offset;

    _cloudConfig.clouds.forEach((cloud) => {
          textStyle = TextStyle(
            color: Colors.white.withOpacity(_getCloudOpacity),
            fontSize: 40,
            fontFamily: 'COMBO',
          ),
          textSpan = TextSpan(
            text: cloud.char,
            style: textStyle,
          ),
          textPainter = TextPainter(
            text: textSpan,
            textDirection: TextDirection.ltr,
          ),
          textPainter.layout(
            minWidth: 0.0,
            maxWidth: size.width,
          ),
          offset = Offset(cloud.offset[0], cloud.offset[1]),
          textPainter.paint(canvas, offset)
        });
  }

  _drawSea(Canvas canvas, Size size) {
    var sea = Offset.zero.translate(0, size.height / 2) & size;
    var seaGradient = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: _getColors(ColorFor.sea),
      stops: [0, .8],
    );

    canvas.drawRect(
      sea,
      Paint()..shader = seaGradient.createShader(sea),
    );
    _drawSeaWave(canvas, size);
  }

  _drawMountain(Canvas canvas, Size size) {
    var mountainPath = Path();
    var mountainGradient = LinearGradient(
      begin: Alignment.bottomLeft,
      end: Alignment.topRight,
      colors: _getColors(ColorFor.mountain),
      stops: [0, 1],
    );

    var mountainShaderContainer =
        Offset.zero.translate(0, size.height / 2) & size;
    mountainPath.moveTo(0, size.height * 0.6);
    mountainPath.lineTo(size.width * 0.15, size.height * 0.3);
    mountainPath.quadraticBezierTo(size.width * 0.2, size.height * 0.2,
        size.width * 0.25, size.height * 0.3);
    mountainPath.lineTo(size.width * 0.6, size.height);
    mountainPath.lineTo(0, size.height);
    mountainPath.close();
    canvas.drawPath(
        mountainPath,
        Paint()
          ..isAntiAlias
          ..shader = mountainGradient.createShader(mountainShaderContainer));
  }

  _drawSmallMountain(Canvas canvas, Size size) {
    var smallMountainPath = Path();
    var mountainShaderContainer =
        Offset.zero.translate(0, size.height / 2) & size;
    var mountainGradient = LinearGradient(
      begin: Alignment.bottomLeft,
      end: Alignment.topRight,
      colors: _getColors(ColorFor.smallMountain),
      stops: [0, 1],
    );

    smallMountainPath.moveTo(size.width * 0.4, size.height * 0.6);
    smallMountainPath.lineTo(size.width * 0.45, size.height * 0.5);
    smallMountainPath.quadraticBezierTo(size.width * 0.5, size.height * 0.44,
        size.width * 0.55, size.height * 0.55);
    smallMountainPath.lineTo(size.width * 0.8, size.height);
    smallMountainPath.lineTo(size.width * 0.6, size.height);
    smallMountainPath.close();
    canvas.drawPath(
        smallMountainPath,
        Paint()
          ..isAntiAlias
          ..shader = mountainGradient.createShader(mountainShaderContainer));
  }

  _drawBackgroundLand(Canvas canvas, Size size) {
    var land = Path();
    var mountainShaderContainer =
        Offset.zero.translate(0, size.height / 2) & size;
    var mountainGradient = LinearGradient(
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
      colors: _getColors(ColorFor.backgroundLand),
      stops: [0, 1],
    );

    land.moveTo(size.width, size.height * 0.5);
    land.lineTo(size.width * 0.8, size.height * 0.5);
    land.quadraticBezierTo(
        size.width * 0.95, size.height * 0.48, size.width, size.height * 0.4);
    land.close();
    canvas.drawPath(
        land,
        Paint()
          ..shader = mountainGradient.createShader(mountainShaderContainer));
  }

  get calculateSessionPecentage {
    var sectionVal =
        ((_fullDayPercentage * 100) - ((_fullDayPercentage * 100) % 25))
            .toInt();
    return (_fullDayPercentage - (sectionVal / 100)) / 0.25;
  }

  _drawSmallBackgroundLand(Canvas canvas, Size size) {
    var land = Path();
    var mountainShaderContainer =
        Offset.zero.translate(0, size.height / 2) & size;
    var mountainGradient = LinearGradient(
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
      colors: _getColors(ColorFor.smallBackgroundLand),
      stops: [0, 1],
    );

    land.moveTo(size.width, size.height * 0.5);
    land.lineTo(size.width * 0.9, size.height * 0.5);
    land.quadraticBezierTo(
        size.width * 0.98, size.height * 0.48, size.width, size.height * 0.45);
    land.close();
    canvas.drawPath(
        land,
        Paint()
          ..shader = mountainGradient.createShader(mountainShaderContainer));
  }

  _getBlinkLightOpacity() {
    const freq = 40;
    return sin(freq * (_microAnimationValue));
  }

  _getLightWidth() {
    const freq = 20;
    return sin(freq * (_microAnimationValue));
  }

  _drawLightHouse(Canvas canvas, Size size) {
    // tower head
    canvas.drawCircle(
        Offset.zero.translate(size.width * 0.925, size.height * 0.44),
        2.7,
        Paint()..color = Colors.black);

    // tower
    canvas.drawRect(
        Offset.zero.translate(size.width * 0.92, size.height * 0.44) &
            Size(size.width * 0.01, size.height * 0.05),
        Paint()..color = Colors.white);
    if (_moonConfig.getMoonOpacity() > 0) {
      var lightGradient = RadialGradient(
        colors: [Colors.yellow, Colors.white.withOpacity(0.0)],
        stops: [0, 1 * _getLightWidth()],
      );

      Rect lightGradientContainer =
          (Offset.zero.translate(size.width * 0.72, size.height * 0.03) &
              Size(size.width * 0.4, size.width * 0.4));

      const topOffset = 0.12;
      const leftOffset = 0.725;
      // right light
      canvas.drawArc(
          Offset.zero
                  .translate(size.width * leftOffset, size.height * topOffset) &
              Size(size.width * 0.4, size.width * 0.4),
          3,
          0.2,
          true,
          Paint()..shader = lightGradient.createShader(lightGradientContainer));

      // right light
      canvas.drawArc(
          Offset.zero
                  .translate(size.width * leftOffset, size.height * topOffset) &
              Size((size.width * 0.4), size.width * 0.4),
          -0.1,
          0.2,
          true,
          Paint()..shader = lightGradient.createShader(lightGradientContainer));

      // light leak light
      canvas.drawCircle(
          Offset.zero.translate(size.width * 0.925, size.height * 0.45),
          6,
          Paint()..color = Colors.yellow.withOpacity(0.2));
      // blink light
      canvas.drawCircle(
          Offset.zero.translate(size.width * 0.925, size.height * 0.42),
          2,
          Paint()..color = Colors.red.withOpacity(_getBlinkLightOpacity()));
    }
  }

  _getSunYValue(xVal) {
    const a = 0;
    const b = 1;
    var yVal = (-4 * (-0.9) / ((a - b) * (a - b))) *
        ((xVal * xVal) - ((a + b) * xVal) + (a * b));
    return yVal;
  }

  @override
  void paint(Canvas canvas, Size size) {
    // TODO prevent uneccecary object drawing from knowing day or night
    _fullDayPercentage = _dayNightConfig.dayNightInfo.fullDayPercentage;
    _nightTimePercentage = _dayNightConfig.dayNightInfo.nightTimePercentage;
    _dayTimePercentage = _dayNightConfig.dayNightInfo.dayTimePercentage;
    _drawSky(canvas, size);
    _drawSun(canvas, size);
    _drawMoon(canvas, size);
    _drawStars(canvas, size);
    _drawAeroplane(canvas, size);
    _drawCloud(canvas, size);
    _drawSea(canvas, size);
    _drawMountain(canvas, size);
    _drawSmallMountain(canvas, size);
    _drawBackgroundLand(canvas, size);
    _drawSmallBackgroundLand(canvas, size);
    _drawLightHouse(canvas, size);
  }

  @override
  bool shouldRepaint(PanoramicPainter oldDelegate) => true;
}
