import 'package:fluteramic_clock/panoramic/panoramic_painter.dart';
import 'package:flutter/material.dart';

class Panoramic extends StatefulWidget {
  @override
  _PanoramicState createState() => _PanoramicState();
}

class _PanoramicState extends State<Panoramic> {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: PanoramicPainter(),
      child: Container(),
    );
  }
}
