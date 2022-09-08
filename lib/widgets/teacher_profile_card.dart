import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:notes_app/utilities/dimensions.dart';

import '../screens/batches/teacher_details_screen.dart';
import 'custom_button.dart';

class TeacherProfileCard extends StatefulWidget {
  const TeacherProfileCard(
      {Key? key, required this.collectionPath, 
      required this.batch
      })
      : super(key: key);

  final String collectionPath;
  final String batch;

  @override
  State<TeacherProfileCard> createState() => _TeacherProfileCardState();
}

class _TeacherProfileCardState extends State<TeacherProfileCard> {
  User? user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    int startIndex = widget.collectionPath.indexOf("(");
    int endIndex = widget.collectionPath.indexOf(")", startIndex + 1);
    final collectionPath = (startIndex == -1)
        ? "${widget.collectionPath}/informationToShowStudent"
        : "${widget.collectionPath.substring(startIndex + 1, endIndex)}/informationToShowStudent";
    print("----->>> ${collectionPath}");
    return StreamBuilder(
        stream:
            FirebaseFirestore.instance.collection(collectionPath).snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          return (snapshot.hasData)
              ? Container(
                  height: 330,
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                      horizontal: Dimensions.width10 * 1.5,
                      vertical: Dimensions.height10 * 2),
                  margin: EdgeInsets.symmetric(vertical: Dimensions.height10),
                  decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Stack(
                    children: [
                      Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Image.network(snapshot.data!.docs[0]['profilePic'],),
                        ),
                        Container(
                          height: 380,
                          width: 2,
                          color: Colors.grey
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Teacher Name :   ${snapshot.data!.docs[0]['name']}",
                                 
                                  style: const TextStyle(
                                      fontSize: 17.0, fontWeight: FontWeight.normal),
                                ),
                                 SizedBox(
                                  height: Dimensions.height10 * 1,
                                ),
                                Text("Qualification   :     ${snapshot.data!.docs[0]['qualification']}",
                                 style: const TextStyle(
                                        fontSize: 17.0, fontWeight: FontWeight.normal),
                                ),
                                SizedBox(
                                  height: Dimensions.height10 * 1,
                                ),
                                // Align(
                                //   alignment: Alignment.center,
                                //   child: Text(
                                //     "experience : ${snapshot.data!.docs[0]['experience']}",
                                //     style: const TextStyle(
                                //         fontSize: 15.0, fontWeight: FontWeight.bold),
                                //   ),
                                // ),
                                Text(
                                    "Experience     :      ${snapshot.data!.docs[0]['experience']}",
                                    style: const TextStyle(
                                        fontSize: 17.0, fontWeight: FontWeight.normal),
                                  ),
                                SizedBox(
                                  height: Dimensions.height10 * 1,
                                ),
                                Text(
                                  "Subjects         :  ${snapshot.data!.docs[0]['subjectExpertise']}",
                                  overflow: TextOverflow.fade,
                                  style: const TextStyle(
                                      fontSize: 17.0, fontWeight: FontWeight.normal),
                                              
                                ),
                                SizedBox(
                                height: Dimensions.height10 * 1,
                                ),
                                Container(
                                  width: Dimensions.screenWidth/1.7,
                                  child: Text(
                                    "Languages     :   ${snapshot.data!.docs[0]['teachingLanguage']}",
                                    overflow: TextOverflow.fade,
                                    style: const TextStyle(
                                        fontSize: 17.0, fontWeight: FontWeight.normal),
                                  ),
                                ),
                                const Spacer(),
                              ],
                            ),
                          ),
                        ),
                      ],
                                        ),
                      Align(alignment: Alignment.bottomRight,
                        child: CustomButton(
                          backColor: Colors.pink,
                          onTapHandler: () async {
                            await FirebaseFirestore.instance
                                .collection("users")
                                .doc(user?.email)
                                .set({
                              "followedTeachers": FieldValue.arrayUnion(
                                  [snapshot.data!.docs[0]['email']])
                            }, SetOptions(merge: true)).then((value) {
                              Fluttertoast.showToast(msg: "Followed!");
                            });
                            Navigator.of(context).pushNamed(
                                TeacherDetailsScreen.routeName,
                                arguments: {
                                  // 'batchName': widget.batch,
                                  'teacher': snapshot.data!.docs[0]['name'],
                                });
                          },
                          text: 'Follow',
                        ),
                      )
                    ]
                  ),
                )
              : Center(
                  child: Text("NOT FOUND"),
                );
        });
  }
}
