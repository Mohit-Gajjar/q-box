
import 'package:flutter/material.dart';

import '../../widgets/appbar_actions.dart';

class AboutCoursePage extends StatefulWidget {
  const AboutCoursePage({Key? key, required this.desc}) : super(key: key);
  final String desc;

  @override
  State<AboutCoursePage> createState() => _AboutCoursePageState();
}

class _AboutCoursePageState extends State<AboutCoursePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(196, 196, 196, 0.75),
        title: Text(
          "About Course",
          style: TextStyle(
              fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        actions: <Widget>[AppBarActions2()],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Text(widget.desc),
        ),
      ),
    );
  }
}
