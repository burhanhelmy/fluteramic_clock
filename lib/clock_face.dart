import 'package:fluteramic_clock/panoramic/panoramic.dart';
import 'package:fluteramic_clock/time_date.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ClockFace extends StatefulWidget {
  @override
  _ClockFaceState createState() => _ClockFaceState();
}

class _ClockFaceState extends State<ClockFace> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Panoramic(),
        // TimeDate(),
      ]),
    );
  }
}
