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
    getPurchasedCourse();
    getTrialCourses();
  }

  List purchasedCourse = [];
  List trialCourse = [];
  void getPurchasedCourse() async {
    FirebaseFirestore.instance
        .collection('users')
        .doc(userEmail)
        .get()
        .then((value) {
      Map<String, dynamic>? data = value.data();
      setState(() {
        purchasedCourse = data!['purchasedCourse'] as List;
      });
      print(purchasedCourse);
    });
  }

  void getTrialCourses() async {
    FirebaseFirestore.instance
        .collection('users')
        .doc(userEmail)
        .get()
        .then((value) {
      Map<String, dynamic>? data = value.data();
      setState(() {
        trialCourse = data!['trialCourse'] as List;
      });
      print(trialCourse);
    });
  }

  Widget purchasedListTile(){
    return ListView.builder(
      shrinkWrap: true,
        itemCount: purchasedCourse.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("ID : ${purchasedCourse[index]['cid']}  |  " +
                        purchasedCourse[index]['courseName'].toString()),
                    Text("duration : ${purchasedCourse[index]['duration']}")
                  ],
                ),
                Text("Amount paid : ${purchasedCourse[index]['amount']}"),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text("Date of purchase : ${purchasedCourse[index]['dateOfPurchase']}")
                  ],
                )
              ],
            ),
            onTap: (() {
            }),
          );
        });
  }

  Widget trialListTile(){
    return ListView.builder(
      shrinkWrap: true,
        itemCount: trialCourse.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("ID : ${trialCourse[index]['cid']}  |  " +
                        trialCourse[index]['courseName']),
                    Text("Duration : 7 DAYS")
                  ],
                ),
                Text("TRIAL COURSE"),
              ],
            ),
            onTap: (() {
            }),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Active Courses'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Purchased Course : "),
            purchasedListTile(),
            Text("Trial Course : "),
            trialListTile()
          ],
        )
    );
  }
}
