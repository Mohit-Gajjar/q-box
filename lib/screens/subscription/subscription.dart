import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:notes_app/screens/payments/payment_option.dart';

class SubscriptionPage extends StatefulWidget {
  const SubscriptionPage({Key? key}) : super(key: key);

  @override
  State<SubscriptionPage> createState() => _SubscriptionPageState();
}

class _SubscriptionPageState extends State<SubscriptionPage> {
  String userEmail = "";
  @override
  void initState() {
    getUserEmail();

    super.initState();
  }

  List selectedCourses = [];
  String dateOfJoin = "";
  getUserEmail() async {
    final User user = await FirebaseAuth.instance.currentUser!;
    setState(() {
      userEmail = user.email!;
    });
    print(userEmail);
    checkSelectedCourses();
  }

  void checkSelectedCourses() async {
    FirebaseFirestore.instance
        .collection('users')
        .doc(userEmail)
        .get()
        .then((value) {
      Map<String, dynamic>? data = value.data();
      setState(() {
        selectedCourses = data!['selectedCourse'] as List;
        dateOfJoin = data['dateOfJoin'];
      });
      print(selectedCourses);
      print(dateOfJoin);
    });
  }

  bool trialChecker() {
    int days = DateTime.now().difference(DateTime.parse(dateOfJoin)).inDays;
    if (days >= 7) return false;
    return true;
  }

  bool showPayment(String mode) {
    if (!trialChecker() && mode == "unpaid") return true;
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Text(
            "Selected Courses",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        selectedCourses.length == 0
            ? Center(
                child: Text("No Courses Selected"),
              )
            : Expanded(
                child: ListView.builder(
                    itemCount: selectedCourses.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text("${index + 1}). " +
                            selectedCourses[index].toString().split("@")[0]),
                        onTap: (() {
                          (showPayment(selectedCourses[index]
                                  .toString()
                                  .split("@")[1]))
                              ? Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => PaymentOption(
                                            courseName: selectedCourses[index],
                                          )))
                              : Fluttertoast.showToast(msg: "Can be accessed");
                        }),
                      );
                    }),
              )
      ],
    ));
  }
}
