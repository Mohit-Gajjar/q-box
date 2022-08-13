import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:notes_app/provider/get_user_details.dart';
import 'package:notes_app/helpers/auth_path.dart';
import 'package:notes_app/screens/anotherCourse/AnotherCourseScreen.dart';
import 'package:notes_app/screens/doubtSolving.dart';
import 'package:notes_app/screens/followedTeachers/followedTeachersScreen.dart';
import 'package:notes_app/screens/analytics/analytic.dart';
import 'package:notes_app/utilities/dimensions.dart';
import 'package:notes_app/widgets/appbar_actions.dart';

import 'active_course/active_course.dart';

class Profile extends StatefulWidget {
  static String routeName = "profile";

  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final user = FirebaseAuth.instance.currentUser;
  final userProfileUrlRef = FirebaseStorage.instance.ref();

  Future<void> _signOut() async {
    await _auth.signOut();
  }

// TODO: Parents Teacher meeting page missing
  Future uploadProfile() async {
    String? errorMessage;
    final results = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      allowedExtensions: ['jpg', 'png'],
      type: FileType.custom,
    );
    if (results == null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('No File Selected'),
      ));
      return null;
    }
    final path = results.files.single.path;
    final fileName = results.files.single.name;
    File file = File(path!);
    String userEmail = user!.email.toString();
    final userProfileUrl =
        userProfileUrlRef.child('users/${userEmail}/UserProfile/${fileName}');
    await userProfileUrl.putFile(file).snapshotEvents.listen((taskSnapshot) {
      switch (taskSnapshot.state) {
        case TaskState.running:
          break;
        case TaskState.paused:
          // ...;
          break;
        case TaskState.success:
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('successfully uploaded')));
          break;
        case TaskState.canceled:
          // ...
          break;
        case TaskState.error:
          print(taskSnapshot.toString());
          break;
      }
    });
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userEmail)
          .update({
            'profileImageName': fileName,
          })
          .then((value) => print("User Added"))
          .catchError((error) => print("Failed to add user: $error"));
    } on FirebaseAuthException catch (error) {
      switch (error.code) {
        case "too-many-requests":
          errorMessage = "Too many requests";
          break;
        case "operation-not-allowed":
          errorMessage = "Signing in with Email and Password is not enabled.";
          break;
        default:
          errorMessage = "An undefined Error happened.";
      }
      Fluttertoast.showToast(msg: errorMessage);
    }
  }

  @override
  void initState() {
    // getDocId();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Account',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(
              horizontal: Dimensions.padding20 / 2,
              vertical: Dimensions.padding20),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: Dimensions.padding20),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: Dimensions.width10 * 12,
                        height: Dimensions.width10 * 10,
                        child: Stack(
                          children: [
                            AppBarProfileIcon(
                              profileRadius: Dimensions.width10 * 5,
                            ),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: Container(
                                width: 30,
                                height: 30,
                                alignment: Alignment.topLeft,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      Dimensions.width10 * 1.5),
                                  color: Colors.white,
                                ),
                                child: IconButton(
                                  onPressed: () async {
                                    await uploadProfile();
                                  },
                                  icon: Icon(Icons.add),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: Dimensions.width10,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GetUserName(documentId: user!.email.toString()),
                          Text(
                            "${user?.email.toString()}",
                            style: TextStyle(
                              fontWeight: FontWeight.w200,
                              fontSize: 15,
                            ),
                          ),
                          TextButton(
                              onPressed: () {},
                              child: Text('Manage Your Google Account'))
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              ListTile(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Analytics()));
                },
                leading: Icon(
                  Icons.person,
                ),
                title: Text('Analytics'),
              ),
              // ListTile(
              //   leading: Icon(
              //     Icons.settings,
              //   ),
              //   title: Text('Coins'),
              // ),
              ListTile(
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ActiveCourses())),
                leading: Icon(
                  Icons.class_,
                ),
                title: Text('Active Courses'),
              ),
              ListTile(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AnotherCourseScreen())),
                leading: Icon(
                  Icons.add_box_rounded,
                ),
                title: Text('Add another course'),
              ),
              ListTile(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DoubtSolvingScreen())),
                leading: Icon(
                  Icons.add_box_rounded,
                ),
                title: Text('Doubt Solving'),
              ),
              ListTile(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => FollowedTeachersScreen())),
                leading: Icon(
                  Icons.follow_the_signs_rounded,
                ),
                title: Text('Followed Teachers'),
              ),
              ListTile(
                leading: Icon(
                  Icons.settings,
                ),
                title: Text('Settings'),
              ),
              ListTile(
                leading: Icon(
                  Icons.reviews,
                ),
                title: Text('Teacher Review'),
              ),
              ListTile(
                leading: Icon(
                  Icons.note,
                ),
                title: Text('Blogs'),
              ),
              MaterialButton(
                onPressed: () async {
                  await _signOut();
                  Navigator.pushNamedAndRemoveUntil(
                      context, AuthPath.routeName, (route) => false);
                },
                color: Theme.of(context).primaryColor,
                child: Text('Sign Out'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
