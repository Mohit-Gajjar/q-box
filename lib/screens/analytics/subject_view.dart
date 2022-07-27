// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:notes_app/screens/home/home.dart';
import 'package:notes_app/screens/tabs_screen.dart';

class SubjectView extends StatefulWidget {
  SubjectView({Key? key}) : super(key: key);

  @override
  State<SubjectView> createState() => _SubjectViewState();
}

class _SubjectViewState extends State<SubjectView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Subject View",
            
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
        // backgroundColor: Image.asset("assets/badge.png"),
        body: SafeArea(
            child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    //'assets/background.avif'
                    'assets/badge.png',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    //'assets/background.avif'
                    'assets/line.png',
                  ),

                  // fit: BoxFit.non,
                ),
              ),
            ),
          ],
        )));
  }
}
