import 'package:flutter/material.dart';
import 'package:notes_app/screens/teacher/teacherReview.dart';
import 'package:notes_app/widgets/teacher_profile_card.dart';

import '../../widgets/appbar_actions.dart';

class TeacherProfileScreen extends StatefulWidget {
  const TeacherProfileScreen({Key? key, required this.collectionPath, required this.batchName}) : super(key: key);
  final String collectionPath;
  final String batchName;

  @override
  State<TeacherProfileScreen> createState() => _TeacherProfileScreenState();
}

class _TeacherProfileScreenState extends State<TeacherProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(196, 196, 196, 0.75),
        title: Text(
          "Teacher Profile",
          style: TextStyle(
              fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        actions: <Widget>[AppBarActions2()],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TeacherProfileCard(collectionPath: widget.collectionPath, batch: widget.batchName),

            ),
            TextButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>TeacherReviewScreen()));
            }, child: Text("Review"))
          ],
        ),
      ),
    );
  }
}
