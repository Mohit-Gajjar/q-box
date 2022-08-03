import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

List gPurchasedCourse = [];
List gTrialCourse = [];
void getPurchasedCourse() async {
  String? userEmail = await FirebaseAuth.instance.currentUser?.email;
  await FirebaseFirestore.instance
      .collection('users')
      .doc(userEmail)
      .get()
      .then((value) {
    Map<String, dynamic>? data = value.data();
      gPurchasedCourse = data!['purchasedCourse'] as List;
  });
}

void getTrialCourses() async {
  String? userEmail = await FirebaseAuth.instance.currentUser?.email;
  await FirebaseFirestore.instance
      .collection('users')
      .doc(userEmail)
      .get()
      .then((value) {
    Map<String, dynamic>? data = value.data();
      gTrialCourse = data!['trialCourse'] as List;
  });
}