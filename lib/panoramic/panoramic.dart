import 'package:fluteramic_clock/panoramic/panoramic_painter.dart';
import 'package:flutter/material.dart';

class Panoramic extends StatefulWidget {
  @override
  _PanoramicState createState() => _PanoramicState();
}

class _PanoramicState extends State<Panoramic>
    with SingleTickerProviderStateMixin {
  AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: const Duration(seconds: 20), vsync: this)
          ..repeat();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (BuildContext context, Widget child) {
        return CustomPaint(
          painter: PanoramicPainter(controller.value),
          child: Container(),
        );
      },
    );
  }
}
