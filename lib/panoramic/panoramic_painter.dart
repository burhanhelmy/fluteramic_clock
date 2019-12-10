import 'package:fluteramic_clock/panoramic/color_const.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class PanoramicPainter extends CustomPainter {
  double percentage;
  PanoramicPainter(this.percentage);
  double nightPercentage;
  double dayPercentage;

  _drawSky(Canvas canvas, Size size) {
    var sky = Offset.zero & Size(size.width, size.height / 2);
    var skyGradient = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Color.lerp(
            skyColorsPrimary[(percentage * 100) - ((percentage * 100) % 25)],
            skyColorsPrimary[
                (percentage * 100) - ((percentage * 100) % 25) + 25 < 100
                    ? (percentage * 100) - ((percentage * 100) % 25) + 25
                    : 0],
            calculateSessionPecentage),
        Color.lerp(
            skyColorsSecondary[(percentage * 100) - ((percentage * 100) % 25)],
            skyColorsSecondary[
                (percentage * 100) - ((percentage * 100) % 25) + 25 < 100
                    ? (percentage * 100) - ((percentage * 100) % 25) + 25
                    : 0],
            calculateSessionPecentage),
      ],
      stops: [0, 1],
    );
    canvas.drawRect(
      sky,
      Paint()..shader = skyGradient.createShader(sky),
    );
  }

  _drawSun(Canvas canvas, Size size) {
    dayPercentage = ((percentage) / 0.50);
    var sun = Offset.zero & size;
    var sunGradient = RadialGradient(
      center: Alignment((dayPercentage) - 0.25,
          _parabolicYValue(dayPercentage) + 0.2), // added offset
      radius: 1 - (0.5 * dayPercentage),
      colors: [
        Color.lerp(Color(0xFFFFFFFF), Colors.red, dayPercentage),
        Color.lerp(Color(0xFFFFC400), Colors.transparent, dayPercentage),
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

  _drawSea(Canvas canvas, Size size) {
    var sea = Offset.zero.translate(0, size.height / 2) & size;
    var seaGradient = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Color.lerp(Color(0xFF268F92), Colors.red[900], percentage),
        Color.lerp(Color(0xFF00484B), Colors.indigo, percentage)
      ],
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
      colors: [
        Color.lerp(Color(0xFF6E8300), Colors.brown[900], percentage),
        Color.lerp(Colors.green, Colors.brown[900], percentage)
      ],
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
          ..color = Colors.green
          ..shader = mountainGradient.createShader(mountainShaderContainer));
  }

  _drawSmallMountain(Canvas canvas, Size size) {
    var smallMountainPath = Path();
    var mountainShaderContainer =
        Offset.zero.translate(0, size.height / 2) & size;
    var mountainGradient = LinearGradient(
      begin: Alignment.bottomLeft,
      end: Alignment.topRight,
      colors: [
        Color.lerp(Colors.lime[600], Colors.brown[700], percentage),
        Color.lerp(Colors.lime[500], Colors.brown[700], percentage)
      ],
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
          ..color = Colors.greenAccent
          ..shader = mountainGradient.createShader(mountainShaderContainer));
  }

  _drawLand(Canvas canvas, Size size) {
    var land = Path();
    var mountainShaderContainer =
        Offset.zero.translate(0, size.height / 2) & size;
    var mountainGradient = LinearGradient(
      begin: Alignment.bottomLeft,
      end: Alignment.topRight,
      colors: [
        Color.lerp(Color(0xFFE7FFFD), Colors.red[100], percentage),
        Color.lerp(Color(0xFFE7FFFD), Colors.red[100], percentage)
      ],
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
          ..color = Colors.greenAccent
          ..shader = mountainGradient.createShader(mountainShaderContainer));
  }

  _drawMoon(Canvas canvas, Size size) {
    nightPercentage = ((percentage - 0.25) / 0.80);
    var moon = Offset.zero & size;
    var moonGradient = RadialGradient(
      center: Alignment(0.38, -0.72 * percentage - 0.25), // added offset
      radius: 0.12,
      colors: [
        Colors.transparent,
        Color.fromRGBO(255, 255, 46, nightPercentage > 0 ? nightPercentage : 0),
      ],
      stops: [0.5, 0.4],
    );
    canvas.drawCircle(
        Offset.zero.translate(size.width / 1.5, size.height / 6),
        70,
        Paint()
          ..strokeWidth = 30
          ..strokeCap = StrokeCap.round
          ..shader = moonGradient.createShader(moon)
          ..blendMode = BlendMode.hardLight);
  }

  get calculateSessionPecentage {
    var sectionVal = ((percentage * 100) - ((percentage * 100) % 25)).toInt();
    return (percentage - (sectionVal / 100)) / 0.25;
  }

  _drawSmallLand(Canvas canvas, Size size) {
    var land = Path();
    var mountainShaderContainer =
        Offset.zero.translate(0, size.height / 2) & size;
    var mountainGradient = LinearGradient(
      begin: Alignment.bottomLeft,
      end: Alignment.topRight,
      colors: [
        Color.lerp(Color(0xFF00A1BE), Colors.red, percentage),
        Color.lerp(Color(0xFF00A1BE), Colors.red, percentage)
      ],
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
          ..color = Colors.greenAccent
          ..shader = mountainGradient.createShader(mountainShaderContainer));
  }

  _parabolicYValue(xVal) {
    const a = 0;
    const b = 1;
    var yVal = (-4 * (-0.9) / ((a - b) * (a - b))) *
        ((xVal * xVal) - ((a + b) * xVal) + (a * b));
    return yVal;
  }

  @override
  void paint(Canvas canvas, Size size) {
    _drawSky(canvas, size);
    _drawSun(canvas, size);
    _drawSea(canvas, size);
    _drawMountain(canvas, size);
    _drawSmallMountain(canvas, size);
    _drawLand(canvas, size);
    _drawSmallLand(canvas, size);
    _drawMoon(canvas, size);
  }

  @override
  bool shouldRepaint(PanoramicPainter oldDelegate) => false;
}
