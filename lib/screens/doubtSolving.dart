// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../widgets/appbar_actions.dart';

class DoubtSolvingScreen extends StatefulWidget {
  const DoubtSolvingScreen({Key? key}) : super(key: key);

  @override
  State<DoubtSolvingScreen> createState() => _DoubtSolvingScreenState();
}

class _DoubtSolvingScreenState extends State<DoubtSolvingScreen> {
  //launch url
  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    //TODO: implement dynamic links for each course related doubt solving links
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black12,
        title: Text(
          "Doubt Solving",
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
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextButton(
                      onPressed: () {
                        _launchURL("https://t.me/mathematicsqrioctybox");
                      },
                      child: Text('Mathematics')),
                  TextButton(
                      onPressed: () {
                        _launchURL("https://t.me/physicsqrioctybox");
                      },
                      child: Text('Physics')),
                  TextButton(
                      onPressed: () {
                        _launchURL("https://t.me/chemistryqrioctybox");
                      },
                      child: Text('Chemistry'))
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(28.0),
            child: ListTile(
              title: Text("Group Link Here for NEET "),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextButton(
                      onPressed: () {
                        _launchURL("https://t.me/biologyqrioctybox");
                      },
                      child: Text('Biology')),
                  TextButton(
                      onPressed: () {
                        _launchURL("https://t.me/physicsqrioctybox");
                      },
                      child: Text('Physics')),
                  TextButton(
                      onPressed: () {
                        _launchURL("https://t.me/chemistryqrioctybox");
                      },
                      child: Text('Chemistry'))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
