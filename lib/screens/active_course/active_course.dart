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

  Widget purchasedListTile() {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: purchasedCourse.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: purchasedCourse.length == 0
                ? Text("0")
                : Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                                "ID : ${purchasedCourse[index]['cid']}  |  " +
                                    purchasedCourse[index]['courseName']
                                        .toString()),
                          ),
                          Text(
                              "duration : ${purchasedCourse[index]['duration']}")
                        ],
                      ),
                      Text("Amount paid : ${purchasedCourse[index]['amount']}"),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                              "Date of purchase : ${purchasedCourse[index]['dateOfPurchase']}")
                        ],
                      )
                    ],
                  ),
            onTap: (() {}),
          );
        });
  }

  Widget trialListTile() {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: trialCourse.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: trialCourse.length == 0
                ? Text("0")
                : Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                                "ID : ${trialCourse[index]['cid']}  |  " +
                                    trialCourse[index]['courseName']),
                          ),
                          const SizedBox(width: 10),
                          Text("Duration : 7 DAYS")
                        ],
                      ),
                      Text("TRIAL COURSE"),
                    ],
                  ),
            onTap: (() {}),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Active Courses'),
        ),
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Purchased Course : "),
              purchasedListTile(),
              Text("Trial Course : "),
              trialListTile()
            ],
          ),
        ));
  }
}
