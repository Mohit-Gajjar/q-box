import 'package:flutter/material.dart';
import 'package:notes_app/utilities/dimensions.dart';

import '../../widgets/appbar_actions.dart';

class TotalMarksScreen extends StatefulWidget {
  const TotalMarksScreen({Key? key, required this.marks}) : super(key: key);
  final int marks;

  @override
  State<TotalMarksScreen> createState() => _TotalMarksScreenState();
}

class _TotalMarksScreenState extends State<TotalMarksScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(196, 196, 196, 0.75),
        title: Text(
          "QBox",
          style: TextStyle(
              fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        actions: <Widget>[AppBarActions()],
      ),
      body: SafeArea(
        child: Container(
          height: Dimensions.screenHeight,
          width: Dimensions.screenWidth,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Text((widget.marks>30)?"Congratulations":"Sorry", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
                  Text("You Got ${widget.marks}")
                ],
              ),
              Image.asset((widget.marks>30)?"assets/images/congrats.png":"assets/images/sorry.png", height: Dimensions.screenHeight/2, width: Dimensions.screenWidth/1.2,),
              SizedBox(height: 10,)
            ],
          ),
        ),

      ),
    );
  }
}
