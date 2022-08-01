import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:notes_app/utilities/dimensions.dart';

import '../screens/batches/teacher_details_screen.dart';
import 'custom_button.dart';

class TeacherProfileCard extends StatefulWidget {
  const TeacherProfileCard(
      {Key? key, required this.collectionPath, required this.batch})
      : super(key: key);

  final String collectionPath;
  final String batch;

  @override
  State<TeacherProfileCard> createState() => _TeacherProfileCardState();
}

class _TeacherProfileCardState extends State<TeacherProfileCard> {
   FirebaseAuth _auth = FirebaseAuth.instance;

  User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    int startIndex = widget.collectionPath.indexOf("(");
    int endIndex = widget.collectionPath.indexOf(")", startIndex + 1);
    final collectionPath = (startIndex==-1)
        ?"${widget.collectionPath}/informationToShowStudent"
        :"${widget.collectionPath.substring(startIndex + 1, endIndex)}/informationToShowStudent";
    print("----->>> ${collectionPath}");
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection(collectionPath).snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
       return (snapshot.hasData)?
           Container(
            height: 300,
            width: double.infinity,
            padding: EdgeInsets.symmetric(
                horizontal: Dimensions.width10 * 1.5,
                vertical: Dimensions.height10 * 2),
            margin: EdgeInsets.symmetric(vertical: Dimensions.height10),
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        snapshot.data!.docs[0]['name']
                        ,
                        style:
                        const TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: 10,),
                      Text("${snapshot.data!.docs[0]['qualification']}")
                    ],
                  ),
                ),
                SizedBox(
                  height: Dimensions.height10 * 2,
                ),

                Align(
                  alignment: Alignment.center,
                  child: Text(
                    "experience : ${snapshot.data!.docs[0]['experience']}"
                    ,
                    style:
                    const TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: Dimensions.height10 * 2,
                ),

                Align(
                  alignment: Alignment.center,
                  child: Text(
                    "subjects : ${snapshot.data!.docs[0]['subjectExpertise']}"
                    ,
                    style:
                    const TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: Dimensions.height10 * 2,
                ),

                Align(
                  alignment: Alignment.center,
                  child: Text(
                    "languages : ${snapshot.data!.docs[0]['teachingLanguage']}"
                    ,
                    style:
                    const TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold),
                  ),
                ),
                const Spacer(),
                CustomButton(
                  backColor: Colors.pink,
                  onTapHandler: () async{
                    await FirebaseFirestore.instance.collection("users").doc(user?.email).set(
                        {"followedTeachers":FieldValue.arrayUnion([snapshot.data!.docs[0]['name']])},
                        SetOptions(merge: true)
                    ).then((value){
                      Fluttertoast.showToast(msg: "Followed!");
                    });
                    Navigator.of(context).pushNamed(
                        TeacherDetailsScreen.routeName,
                        arguments: {
                          'batchName': widget.batch,
                          'teacher': snapshot.data!.docs[0]['name'],
                        });
                  },
                  text: 'Follow',
                )
              ],
            ),
          )
           : Center(child: Text("NOT FOUND"),);
        }
    );
  }
}
