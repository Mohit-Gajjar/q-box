import 'package:flutter/material.dart';
import 'package:notes_app/screens/analytics/subject_view.dart';
import 'package:notes_app/screens/analytics/batches.dart';
import 'package:notes_app/screens/analytics/practice.dart';
import 'package:notes_app/screens/analytics/tests.dart';

class Analytics extends StatefulWidget {
  const Analytics({
    Key? key,
  }) : super(key: key);
  @override
  State<Analytics> createState() => _AnalyticsState();
}

class _AnalyticsState extends State<Analytics> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Analytics"),
        ),
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                ListTile(
                  onTap: () => Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SubjectView())),
                  title: const Text("Subject View"),
                  trailing: const Icon(Icons.arrow_right_alt),
                ),
                ListTile(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const FullLengthTest())),
                  title: const Text("Full Length Tests"),
                  trailing: const Icon(Icons.arrow_right_alt),
                ),
                ListTile(
                  onTap: () => Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LadderBoard())),
                  title: const Text("Ladder Board"),
                  trailing: const Icon(Icons.arrow_right_alt),
                ),
                ListTile(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DigitalPracticeBook())),
                  title: const Text("DPB"),
                  trailing: const Icon(Icons.arrow_right_alt),
                ),
              ],
            ),
          ),
        ));
  }
}
