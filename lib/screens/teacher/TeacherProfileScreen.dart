import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/models/teacherModel.dart';
import 'package:notes_app/screens/teacher/download_video.dart';
import 'package:notes_app/screens/teacher/teacherReview.dart';
import 'package:notes_app/widgets/teacher_profile_card.dart';

import '../../widgets/appbar_actions.dart';
import '../../widgets/home_display_screen.dart';

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
            },
             child: Text("Review")
             ),

                TextButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>DownloadVideo()));
            }, child: Text("Download Video", style: TextStyle(color: Colors.black,)
            )),
            SizedBox(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance.collection("teachers").where("email", isEqualTo: widget.collectionPath.split("/")[1]).snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  Map<String, dynamic>? data =
                  snapshot.data!.docs[0].data()
                  as Map<String, dynamic>;
                  var teach = TeacherModel.fromJson(data);
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: data["completedClasses"].length,
                    itemBuilder: (context,index)=>HomeDisplayScreen(
                      videoLink: teach.completedClasses![index]['videoLink'],
                      imageUrl: teach.completedClasses![index]['imageUrl'],
                      title: teach.completedClasses![index]['title'],
                      likes: int.parse(teach.completedClasses![index]['likes']),
                      teacherEmail: teach.email! ,
                      batchName: teach.completedClasses![index]['batchName'],
                    ),);
                }
              ),
            ),
            
          ],
        ),
      ),
    );
  }
}
