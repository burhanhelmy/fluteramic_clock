import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class PanoramicPainter extends CustomPainter {
  double percentage;
  PanoramicPainter(this.percentage);

  _drawSky(Canvas canvas, Size size) {
    var sky = Offset.zero & Size(size.width, size.height / 2);
    var skyGradient = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Color.lerp(Color(0xFFB1EAFF), Colors.indigo, percentage),
        Color.lerp(Color(0xFFA6FFEF), Colors.red, percentage)
      ],
      stops: [0, 1],
    );
    canvas.drawRect(
      sky,
      Paint()..shader = skyGradient.createShader(sky),
    );
  }

  _drawSun(Canvas canvas, Size size) {
    var sun = Offset.zero & size;
    var sunGradient = RadialGradient(
      center: Alignment((percentage) - 0.25,
          _parabolicYValue(percentage) + 0.2), // added offset
      radius: 1 - (0.5 * percentage),
      colors: [
        Color.lerp(Color(0xFFFFFFFF), Colors.red, percentage),
        Color.lerp(Color(0xFFFFC400), Colors.transparent, percentage),
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
    print(xVal.toString() + ',' + yVal.toString());
    return yVal;
  }

  _drawShip(Canvas canvas, Size size) {
    var sea = Offset.zero.translate(size.width * 0.8, size.height * 0.7) &
        Size(size.width * 0.08, size.height * 0.04);

    var seaGradient = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [Color(0xFFFFFFFF), Color(0xFFFFFFFFF)],
      stops: [0, .8],
    );
    canvas.drawRect(
      sea,
      Paint()..shader = seaGradient.createShader(sea),
    );
  }

// TODO:Remove debug text
  _drawDebugText(Canvas canvas, Size size) {
    final textStyle = TextStyle(
      color: Colors.black,
      fontSize: 30,
    );
    final textSpan = TextSpan(
      text: percentage.toString(),
      style: textStyle,
    );
    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout(
      minWidth: 0,
      maxWidth: size.width,
    );
    final offset = Offset(50, 100);
    textPainter.paint(canvas, offset);
  }

  @override
  void paint(Canvas canvas, Size size) {
    _drawSky(canvas, size);
    _drawSun(canvas, size);
    _drawSea(canvas, size);
    _drawMountain(canvas, size);
    // _drawShip(canvas, size);
    _drawSmallMountain(canvas, size);
    _drawLand(canvas, size);
    _drawSmallLand(canvas, size);
    // _drawDebugText(canvas, size);
  }

  @override
  bool shouldRepaint(PanoramicPainter oldDelegate) => false;
}
