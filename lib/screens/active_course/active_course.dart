import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ActiveCourses extends StatefulWidget {
  const ActiveCourses({Key? key}) : super(key: key);

  @override
  State<ActiveCourses> createState() => _ActiveCoursesState();
}

class _ActiveCoursesState extends State<ActiveCourses> {
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
    getSelectedCourses();
  }

  List selectedCourses = [];
  void getSelectedCourses() async {
    FirebaseFirestore.instance
        .collection('users')
        .doc(userEmail)
        .get()
        .then((value) {
      Map<String, dynamic>? data = value.data();
      setState(() {
        selectedCourses = data!['selectedCourse'] as List;
      });
      print(selectedCourses);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Active Courses'),
        ),
        body: ListView.builder(
            itemCount: selectedCourses.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(selectedCourses[index].toString().split("@")[0]),
                onTap: (() {
                }),
              );
            }));
  }
}
