
import 'package:flutter/material.dart';

import '../widgets/appbar_actions.dart';

class DoubtSolvingScreen extends StatefulWidget {
  const DoubtSolvingScreen({Key? key}) : super(key: key);

  @override
  State<DoubtSolvingScreen> createState() => _DoubtSolvingScreenState();
}

class _DoubtSolvingScreenState extends State<DoubtSolvingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black12,
        title: Text(
          "Teacher Profile",
          style: TextStyle(
              fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        actions: <Widget>[AppBarActions2()],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(28.0),
            child: ListTile(
              title: Text("Group Link Here for JEE "),
              tileColor: Colors.black12,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(28.0),
            child: ListTile(
              title: Text("Group Link Here for NEET "),
              tileColor: Colors.black12,
            ),
          )
        ],
      ),
    );
  }
}
