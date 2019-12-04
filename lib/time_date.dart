import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TimeDate extends StatefulWidget {
  @override
  _TimeDateState createState() => _TimeDateState();
}

class _TimeDateState extends State<TimeDate> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '12:12',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 300,
                  fontWeight: FontWeight.w900,
                  shadows: [
                    Shadow(
                      color: Colors.black26,
                      blurRadius: 100,
                    )
                  ]),
            ),
            Text(
              '12 Dec 12',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 80,
                  fontWeight: FontWeight.w900,
                  shadows: [
                    Shadow(
                      color: Colors.black,
                      blurRadius: 1,
                    )
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}
