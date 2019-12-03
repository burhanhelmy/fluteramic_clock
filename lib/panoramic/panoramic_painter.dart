import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class PanoramicPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var sky = Offset.zero & Size(size.width, size.height / 2);
    ;
    var skyGradient = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [Colors.blue, Colors.cyan],
      stops: [0, 1.0],
    );

    var sun = Offset.zero & size;
    var sunGradient = RadialGradient(
      center: const Alignment(0.7, -.1),
      radius: 0.4,
      colors: [
        const Color(0xFFFFFFFF),
        const Color.fromRGBO(245, 242, 66, 0.6),
        Colors.transparent
      ],
      stops: [0.2, 0.2, 1],
    );

    var sea = Offset.zero.translate(0, size.height / 2) & size;
    var seaGradient = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [Colors.blueGrey, Colors.blue],
      stops: [0, .8],
    );

    canvas.drawRect(
      sky,
      Paint()..shader = skyGradient.createShader(sky),
    );
    canvas.drawRect(
        sun,
        Paint()
          ..shader = sunGradient.createShader(sun)
          ..blendMode = BlendMode.hardLight);
    canvas.drawRect(
      sea,
      Paint()..shader = seaGradient.createShader(sea),
    );

    var mountainPath = Path();
    mountainPath.moveTo(0, size.height * 0.6);
    mountainPath.lineTo(size.width * 0.15, size.height * 0.3);
    mountainPath.quadraticBezierTo(size.width * 0.2, size.height * 0.2,
        size.width * 0.25, size.height * 0.3);
    mountainPath.lineTo(size.width * 0.6, size.height);
    mountainPath.lineTo(0, size.height);
    mountainPath.close();
    canvas.drawPath(mountainPath, Paint()..color = Colors.green);

    var smallMountainPath = Path();
    smallMountainPath.moveTo(size.width * 0.4, size.height * 0.6);
    smallMountainPath.lineTo(size.width * 0.45, size.height * 0.5);
    smallMountainPath.quadraticBezierTo(size.width * 0.5, size.height * 0.44,
        size.width * 0.55, size.height * 0.55);
    smallMountainPath.lineTo(size.width * 0.8, size.height);
    smallMountainPath.lineTo(size.width * 0.6, size.height);
    smallMountainPath.close();
    // mountainPath.close();

    canvas.drawPath(smallMountainPath, Paint()..color = Colors.greenAccent);
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
