import 'package:fluteramic_clock/panoramic/panoramic_painter.dart';
import 'package:flutter/material.dart';

class Panoramic extends StatefulWidget {
  @override
  _PanoramicState createState() => _PanoramicState();
}

class _PanoramicState extends State<Panoramic>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  double _percentage = 0;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
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
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 100.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "12:" +
                        (_percentage * 100).toInt().toString().padLeft(2, '0'),
                    style: TextStyle(
                        shadows: [
                          Shadow(color: Colors.white12, blurRadius: 100)
                        ],
                        color: Colors.white,
                        fontSize: 300,
                        fontWeight: FontWeight.w900),
                  ),
                  Text(
                    "AM",
                    style: TextStyle(
                        shadows: [
                          Shadow(color: Colors.white12, blurRadius: 100)
                        ],
                        color: Colors.white,
                        fontSize: 40,
                        fontWeight: FontWeight.w900),
                  ),
                ],
              ),
            ),
            Center(
              child: Text(
                "12 Dec 2020",
                style: TextStyle(
                    shadows: [Shadow(color: Colors.white12, blurRadius: 100)],
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.w800),
              ),
            ),
            Opacity(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Slider(
                        onChanged: (double newPercentage) {
                          setState(() => {
                                _percentage =
                                    newPercentage == 1 ? 0 : newPercentage
                              });
                        },
                        value: _percentage == 1 ? 0 : _percentage,
                      ),
                    ),
                  ],
                ),
              ),
              opacity: 0.1,
            ),
          ],
        ),
      ),
    );
    //   },
    // );
  }
}
