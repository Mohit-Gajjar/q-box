import 'package:flutter/material.dart';

import '../../widgets/appbar_actions.dart';

class TeacherReviewScreen extends StatefulWidget {
  const TeacherReviewScreen({Key? key}) : super(key: key);

  @override
  State<TeacherReviewScreen> createState() => _TeacherReviewScreenState();
}

class _TeacherReviewScreenState extends State<TeacherReviewScreen> {
  
  // TODO: paste the link for teacher review form
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 70),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ListTile(
              title: Container(
                height: 50,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7.0),
                  border: Border.all(
                      color: Colors.black12, style: BorderStyle.solid, width: 0.80),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Hey! wanna review Teacher? "),
                    IconButton(onPressed: (){}, icon: Icon(Icons.arrow_right_alt, color: Colors.black,))
                  ],
                ),
              ),
              // tileColor: Colors.black12,
            )
          ],
        ),
      ),
    );
  }
}
