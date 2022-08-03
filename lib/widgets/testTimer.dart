import 'dart:async';

import 'package:flutter/material.dart';

class TestTimer extends StatefulWidget {
  @override
  _TestTimerState createState() => _TestTimerState();
}

class _TestTimerState extends State<TestTimer> with SingleTickerProviderStateMixin{
  late AnimationController _animationController;
  final interval = const Duration(seconds: 1);

  final int timerMaxSeconds = 400;

  Color timerColor = Colors.black;
  bool blink=false;

  int currentSeconds = 0;

  String get timerText =>
      '${((timerMaxSeconds - currentSeconds) ~/ 60).toString().padLeft(2, '0')}: ${((timerMaxSeconds - currentSeconds) % 60).toString().padLeft(2, '0')}';
  late Timer myTimer;
  startTimeout() {
    var duration = interval;
    myTimer = Timer.periodic(duration, (timer) {
      setState(() {
        print(timer.tick);
        currentSeconds = timer.tick;
        if (timer.tick >= timerMaxSeconds) timer.cancel();
        if((timerMaxSeconds - currentSeconds) ~/ 60 <=5){
          timerColor = Colors.red;
          blink=true;
        }
      });
    });
  }

  @override
  void initState() {
    _animationController =
    new AnimationController(vsync: this, duration: Duration(milliseconds: 700));
    _animationController.repeat(reverse: true);
    startTimeout();
    super.initState();
  }

  @override
  void dispose() {
    myTimer.cancel();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return (blink)?FadeTransition(opacity: _animationController,child: Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Icon(Icons.timer, color: timerColor,),
        SizedBox(
          width: 5,
        ),
        Text(timerText, style: TextStyle(color: timerColor),)
      ],
    ),):Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Icon(Icons.timer, color: timerColor,),
        SizedBox(
          width: 5,
        ),
        Text(timerText, style: TextStyle(color: timerColor),)
      ],
    );
  }
}