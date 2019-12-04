import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class PanoramicPainter extends CustomPainter {
  int percentage;
  PanoramicPainter(this.percentage);

  _drawSky(Canvas canvas, Size size) {
    var sky = Offset.zero & Size(size.width, size.height / 2);
    var skyGradient = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [Color(0xFFB1EAFF), Color(0xFFA6FFEF)],
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
      center: const Alignment(0.4, -.8),
      radius: 1,
      colors: [
        const Color(0xFFFFFFFF),
        const Color(0xFFFFC400),
        Colors.transparent,
        Colors.transparent
      ],
      stops: [0.1, 0.05, 0.15, 1],
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
      colors: [Color(0xFF268F92), Color(0xFF00484B)],
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
      colors: [Color(0xFF6E8300), Colors.green],
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
      colors: [Color(0xFFA0BE00), Color(0xFFA0BE00)],
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
      colors: [Color(0xFFE7FFFD), Color(0xFFE7FFFD)],
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
      colors: [Color(0xFF00A1BE), Color(0xFF00A1BE)],
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
  }

  @override
  SemanticsBuilderCallback get semanticsBuilder {
    return (Size size) {
      // Annotate a rectangle containing the picture of the sun
      // with the label "Sun". When text to speech feature is enabled on the
      // device, a user will be able to locate the sun on this picture by
      // touch.
      // var rect = Offset.zero & size;
      // var width = size.shortestSide * 0.4;
      // rect = const Alignment(0.8, -0.9).inscribe(Size(width, width), rect);
      // return [
      //   CustomPainterSemantics(
      //     rect: rect,
      //     properties: SemanticsProperties(
      //       label: 'Sun',
      //       textDirection: TextDirection.ltr,
      //     ),
      //   ),
      // ];
    };
  }

  // Since this Sky painter has no fields, it always paints
  // the same thing and semantics information is the same.
  // Therefore we return false here. If we had fields (set
  // from the constructor) then we would return true if any
  // of them differed from the same fields on the oldDelegate.
  @override
  bool shouldRepaint(PanoramicPainter oldDelegate) => false;
  @override
  bool shouldRebuildSemantics(PanoramicPainter oldDelegate) => false;
}
