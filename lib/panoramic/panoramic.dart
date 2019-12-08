import 'package:fluteramic_clock/panoramic/panoramic_painter.dart';
import 'package:flutter/material.dart';

class Panoramic extends StatefulWidget {
  @override
  _PanoramicState createState() => _PanoramicState();
}

class _PanoramicState extends State<Panoramic>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  double _percentage = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 100),
      vsync: this,
    )..repeat();
  }

  @override
  Widget build(BuildContext context) {
    // return AnimatedBuilder(
    //   animation: _controller,
    //   builder: (BuildContext context, Widget child) {
    return CustomPaint(
      painter: PanoramicPainter(_percentage),
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: <Widget>[
                  Text(
                    'AM',
                    style: TextStyle(color: Colors.white, fontSize: 30),
                  ),
                  Expanded(
                    child: Slider(
                      onChanged: (double newPercentage) {
                        setState(() => {_percentage = newPercentage});
                      },
                      value: _percentage,
                    ),
                  ),
                  Text(
                    'PM',
                    style: TextStyle(color: Colors.white, fontSize: 30),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
    //   },
    // );
  }
}
