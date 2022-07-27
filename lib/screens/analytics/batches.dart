// ignore_for_file: prefer_const_constructors

import 'package:draw_graph/draw_graph.dart';
import 'package:draw_graph/models/feature.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/screens/tabs_screen.dart';

class FullLengthTest extends StatefulWidget {
  const FullLengthTest({Key? key}) : super(key: key);

  @override
  State<FullLengthTest> createState() => _FullLengthTestState();
}

class _FullLengthTestState extends State<FullLengthTest> {
  final List<Feature> features = [
    Feature(
      color: Colors.blue,
      data: [0, 0.2, 0.1, 0.2, 0.6, 0.4, 0.5],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Full Length Tests",
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, TabsScreen.routeName);
              },
              icon: Icon(Icons.home)),
        ],
        backgroundColor: Colors.white70,
      ),
      // backgroundColor: Colors.green,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          LineGraph(
            features: features,
            size: Size(620, 450),
            labelX: ['mon', 'tue', 'wed', 'thu', 'fri', 'sat', 'sun'],
            labelY: ['25%', '50%', '75%', '100%', '125%', '200%'],
            // showDescription: true,
            graphColor: Colors.black87,
          ),
          SizedBox(
            height: 50,
            width: 80,
          )
        ],
      ),
    );
  }
}
