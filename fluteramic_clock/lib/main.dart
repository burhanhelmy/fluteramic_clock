import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'clock_face.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'MONT',
      ),
      home: ClockFace(),
    );
  }
}
