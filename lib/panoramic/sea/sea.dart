import 'package:flutter/material.dart';
import 'sea_painter.dart';

class Sea extends StatefulWidget {
  @override
  _SeaState createState() => _SeaState();
}

class _SeaState extends State<Sea> {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: SeaPainter(),
      child: Container(
        // margin: EdgeInsets.only(top: MediaQuery.of(context).size.height / 2),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height / 2,
      ),
    );
  }
}
