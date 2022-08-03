import 'package:flutter/material.dart';

import '../../widgets/appbar_actions.dart';

class TeacherReviewScreen extends StatefulWidget {
  const TeacherReviewScreen({Key? key}) : super(key: key);

  @override
  State<TeacherReviewScreen> createState() => _TeacherReviewScreenState();
}

class _TeacherReviewScreenState extends State<TeacherReviewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(196, 196, 196, 0.75),
        title: Text(
          "Teacher Review",
          style: TextStyle(
              fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        actions: <Widget>[AppBarActions2()],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Hey! wanna review Teacher? "),
                  IconButton(onPressed: (){}, icon: Icon(Icons.arrow_right_alt, color: Colors.black,))
                ],
              ),
              tileColor: Colors.black12,
            )
          ],
        ),
      ),
    );
  }
}
