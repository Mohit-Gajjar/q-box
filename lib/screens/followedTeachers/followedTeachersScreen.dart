import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/screens/teacher/TeacherProfileScreen.dart';

class FollowedTeachersScreen extends StatefulWidget {
  const FollowedTeachersScreen({Key? key}) : super(key: key);

  @override
  State<FollowedTeachersScreen> createState() => _FollowedTeachersScreenState();
}

class _FollowedTeachersScreenState extends State<FollowedTeachersScreen> {
  String userEmail = "";
  @override
  void initState() {
    getUserEmail();

    super.initState();
  }

  getUserEmail() async {
    final User user = await FirebaseAuth.instance.currentUser!;
    setState(() {
      userEmail = user.email!;
    });
    getFollowedTeachers();
  }

  List followedTeachersList = [];
  void getFollowedTeachers() async {
    FirebaseFirestore.instance
        .collection('users')
        .doc(userEmail)
        .get()
        .then((value) {
      Map<String, dynamic>? data = value.data();
      setState(() {
        followedTeachersList = data!['followedTeachers'] as List;
      });
      print(followedTeachersList);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Followed Teachers'),
        ),
        body: ListView.builder(
            itemCount: followedTeachersList.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(followedTeachersList[index].toString().split("@")[0]),
                onTap: (() {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>TeacherProfileScreen(
                    collectionPath: "teachers/${followedTeachersList[index]}",
                    batchName: "",
                  )));
                }),
              );
            }));
  }
}
