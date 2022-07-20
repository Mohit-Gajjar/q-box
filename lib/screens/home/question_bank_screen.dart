import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/screens/home/practice_screen.dart';
import 'package:notes_app/utilities/dimensions.dart';
import '../../widgets/custom_button.dart';

class QuestionsBank extends StatefulWidget {
  const QuestionsBank({Key? key}) : super(key: key);
  static const String routeName = '/home-screen';

  @override
  State<QuestionsBank> createState() => _QuestionsBankState();
}

class _QuestionsBankState extends State<QuestionsBank> {
  String subjectName = '';
  String chapter = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: Dimensions.screenHeight - Dimensions.height10 * 16,
            padding: EdgeInsets.symmetric(
                horizontal: Dimensions.width15,
                vertical: Dimensions.height10 * 2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Question Bank',
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: Dimensions.height10 * 2,
                ),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(Dimensions.borderRadius15),
                  ),
                  color: Colors.white,
                  elevation: 4.0,
                  borderOnForeground: false,
                  margin: EdgeInsets.symmetric(horizontal: Dimensions.width15),
                  child: ExpansionTile(
                    childrenPadding: EdgeInsets.only(
                        bottom: Dimensions.height10 * 1.5,
                        left: Dimensions.width10 * 2,
                        right: Dimensions.width10 * 2),
                    title: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: Dimensions.width15),
                      child: Text(
                          subjectName == '' ? 'Select Subject' : subjectName),
                    ),
                    children: [
                      Container(
                        height: Dimensions.height10 * 17,
                        child: SingleChildScrollView(
                          child: StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection('practice')
                                .snapshots(),
                            builder: (context,
                                AsyncSnapshot<QuerySnapshot> snapshot) {
                              if (snapshot.hasError) {
                                return Text('Something went wrong');
                              }
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                              return ListView(
                                shrinkWrap: true,
                                physics: ClampingScrollPhysics(),
                                children: snapshot.data!.docs
                                    .map((DocumentSnapshot document) {
                                  Map<String, dynamic> data =
                                      document.data()! as Map<String, dynamic>;
                                  return ListTile(
                                    onTap: () {
                                      setState(() {
                                        subjectName = data['subject'];
                                      });
                                    },
                                    title: Text(data['subject']),
                                  );
                                }).toList(), // casts to list for passing to children parameter
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: Dimensions.height10 * 2,
                ),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(Dimensions.borderRadius15),
                  ),
                  color: Colors.white,
                  elevation: 4.0,
                  borderOnForeground: false,
                  margin: EdgeInsets.symmetric(horizontal: Dimensions.width15),
                  child: ExpansionTile(
                    childrenPadding: EdgeInsets.only(
                        bottom: Dimensions.height10 * 1.5,
                        left: Dimensions.width10 * 2,
                        right: Dimensions.width10 * 2),
                    title: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: Dimensions.width15),
                      child: Text(chapter == '' ? 'Select Chapter' : chapter),
                    ),
                    children: [
                      Container(
                        height: Dimensions.height10 * 17,
                        child: SingleChildScrollView(
                          child: StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection('practice')
                                .where("subject", isEqualTo: subjectName)
                                .snapshots(),
                            builder: (context,
                                AsyncSnapshot<QuerySnapshot> snapshot) {
                              if (snapshot.hasError) {
                                return Text('Something went wrong');
                              }
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                              return ListView(
                                shrinkWrap: true,
                                physics: ClampingScrollPhysics(),
                                children: snapshot.data!.docs
                                    .map((DocumentSnapshot document) {
                                  Map<String, dynamic> data =
                                      document.data()! as Map<String, dynamic>;
                                  return ListTile(
                                    onTap: () {
                                      setState(() {
                                        chapter = data['chapter'];
                                      });
                                    },
                                    title: Text(data['chapter']),
                                  );
                                }).toList(), // casts to list for passing to children parameter
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                Align(
                  alignment: Alignment.centerRight,
                  child: CustomButton(
                    backColor: const Color(0xff0CBC8B),
                    onTapHandler: () async {
                      if (subjectName.isNotEmpty && chapter.isNotEmpty) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Practice(
                                    subjectName: subjectName,
                                    chapter: chapter)));
                      }
                    },
                    text: 'Practice',
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
