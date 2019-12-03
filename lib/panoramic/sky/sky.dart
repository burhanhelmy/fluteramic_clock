import 'package:fluteramic_clock/panoramic/sky/sky_painter.dart';
import 'package:flutter/material.dart';

class Sky extends StatefulWidget {
  @override
  _SkyState createState() => _SkyState();
}

class _SkyState extends State<Sky> {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: SkyPainter(),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height / 2,
      ),
    );
  }
}
