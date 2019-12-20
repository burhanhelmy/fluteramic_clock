import 'dart:math';
import 'package:fluteramic_clock/panoramic/panoramic_colors.dart';
import 'package:fluteramic_clock/panoramic/provider/day_night_config.dart';
import 'package:fluteramic_clock/panoramic/provider/moon_config.dart';
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
  StarsConfig _starConfig = StarsConfig();
  MoonConfig _moonConfig = MoonConfig();
  DayNightConfig _dayNightConfig = DayNightConfig();
  double _fullDayPercentage = 0;
  double _nightTimePercentage = 0;
  double _dayTimePercentage = 0;
  Random _rnd = Random();

  _getColors(ColorFor colorFor) {
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
      radius: 0.12 * _nightTimePercentage,
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

  _drawStars(Canvas canvas, Size size) {
    if (_fullDayPercentage >= 0.9999) {
      _starConfig.resetSettings();
    }
    if (_starConfig.state == StarConfigState.NULL) {
      _starConfig.generateStarSettings(size);
    }
    _starConfig.starsPositions.forEach((starInfo) => (canvas.drawCircle(
        Offset.zero.translate(starInfo.coordinate[0], starInfo.coordinate[1]),
        2 * _rnd.nextDouble(),
        Paint()
          ..strokeWidth = 30
          ..strokeCap = StrokeCap.round
          ..color = Color.fromRGBO(255, 255, 46, starInfo.opacity))));
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
    _drawSea(canvas, size);
    _drawMountain(canvas, size);
    _drawSmallMountain(canvas, size);
    _drawBackgroundLand(canvas, size);
    _drawSmallBackgroundLand(canvas, size);
  }

  @override
  bool shouldRepaint(PanoramicPainter oldDelegate) => true;
}
