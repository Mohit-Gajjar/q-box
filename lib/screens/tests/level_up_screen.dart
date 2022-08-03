import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/utilities/dimensions.dart';

import '../../helpers/helpers.dart';
import '../../initFunctions.dart';
import '../../widgets/custom_button.dart';

class LevelUpTestsScreen extends StatefulWidget {
  LevelUpTestsScreen({Key? key}) : super(key: key);
  static const String routeName = '/level-up-tests-screen';

  @override
  State<LevelUpTestsScreen> createState() => _LevelUpTestsScreenState();
}

class _LevelUpTestsScreenState extends State<LevelUpTestsScreen> {
  String subjectName = '';
  String teacherName = '';

  final Map<String, String> _chapter1 = const {
    'Level 1': 'easy',
    'Level 2': 'easy',
    'Level 3': 'medium',
  };

  final Map<String, String> _chapter2 = const {
    'Level 1': 'easy',
    'Level 2': 'medium',
    'Level 3': 'hard',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Level Up Tests',
          style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
              left: Dimensions.width10 * 1.5,
              right: Dimensions.width10 * 1.5,
              top: Dimensions.height10 * 3),
          child: Column(
            children: [
              Row(
                children: [
                  const Spacer(),
                  CustomButton(
                    backColor: Colors.green,
                    text: subjectName == '' ? 'Select Subject' : subjectName,
                    onTapHandler: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                                title: Center(child: Text("Subjects")),
                                content: StreamBuilder<QuerySnapshot>(
                                  stream: FirebaseFirestore.instance
                                      .collection('levelUpTest')
                                      .snapshots(), // path to collection of documents that is listened to as a stream
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
                                        // Map<String, dynamic> data = document
                                        //     .data()! as Map<String, dynamic>;
                                        return GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              subjectName = document.id;
                                            });
                                          },
                                          child: ListTile(
                                            title: Text(document.id),
                                          ),
                                        );
                                      }).toList(), // casts to list for passing to children parameter
                                    );
                                  },
                                ));
                          });
                    },
                  ),
                  const Spacer(),
                  // CustomButton(
                  //   backColor: Colors.green,
                  //   onTapHandler: () {
                  //     showDialog(
                  //         context: context,
                  //         builder: (BuildContext context) {
                  //           return AlertDialog(
                  //             title: Center(child: Text("Teachers")),
                  //             content: StreamBuilder<QuerySnapshot>(
                  //               stream: FirebaseFirestore.instance
                  //                   .collection('teachers')
                  //                   .snapshots(), // path to collection of documents that is listened to as a stream
                  //               builder: (context,
                  //                   AsyncSnapshot<QuerySnapshot> snapshot) {
                  //                 if (snapshot.hasError) {
                  //                   return Text('Something went wrong');
                  //                 }
                  //                 if (snapshot.connectionState ==
                  //                     ConnectionState.waiting) {
                  //                   return Center(
                  //                       child: CircularProgressIndicator());
                  //                 }
                  //                 return ListView(
                  //                   shrinkWrap: true,
                  //                   physics: ClampingScrollPhysics(),
                  //                   children: snapshot.data!.docs
                  //                       .map((DocumentSnapshot document) {
                  //                     // Map<String, dynamic> data = document
                  //                     //     .data()! as Map<String, dynamic>;
                  //                     return GestureDetector(
                  //                       onTap: () {
                  //                         setState(() {
                  //                           teacherName = document.id;
                  //                         });
                  //                       },
                  //                       child: ListTile(
                  //                         title: Text(document.id),
                  //                       ),
                  //                     );
                  //                   }).toList(),
                  //                 );
                  //               },
                  //             ),
                  //           );
                  //         });
                  //   },
                  //   text: teacherName == '' ? 'Select Teacher' : teacherName,
                  // ),
                  // const Spacer()
                ],
              ),
              SizedBox(
                height: Dimensions.height10 * 2,
              ),
              LevelUpSeriesCard(chapter1: _chapter1),
              SizedBox(
                height: Dimensions.height10 * 2,
              ),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(Dimensions.borderRadius5 * 3),
                ),
                color: Colors.white,
                elevation: 4.0,
                margin:
                    EdgeInsets.symmetric(horizontal: Dimensions.width10 * 1.5),
                child: IgnorePointer(
                  ignoring: true,
                  child: ExpansionTile(
                    childrenPadding: EdgeInsets.only(
                      bottom: Dimensions.height10 * 1.5,
                      left: Dimensions.width10 * 2,
                      right: Dimensions.width10 * 2,
                    ),
                    title: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: Dimensions.width10 * 1.5),
                      child: Text('Chapter 2  (Locked)'),
                    ),
                    children: _chapter2.entries
                        .map((entry) => ListTile(
                              title: Text(
                                entry.key,
                                style: const TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              leading: CircleAvatar(
                                  backgroundColor:
                                      HelperFunctions.getColortestsLevel(
                                          entry.value),
                                  radius: Dimensions.borderRadius12),
                              enabled: true,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    Dimensions.borderRadius5 * 3),
                              ),
                              onTap: () {},
                              trailing: const Icon(
                                  Icons.keyboard_arrow_right_rounded),
                            ))
                        .toList(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LevelUpSeriesCard extends StatelessWidget {
  const LevelUpSeriesCard({
    Key? key,
    required Map<String, String> chapter1,
  })  : _chapter1 = chapter1,
        super(key: key);

  final Map<String, String> _chapter1;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Dimensions.borderRadius12),
      ),
      color: Colors.white,
      elevation: 4.0,
      margin: EdgeInsets.symmetric(horizontal: Dimensions.width10 * 1.5),
      child: ExpansionTile(
        childrenPadding: EdgeInsets.only(
            bottom: Dimensions.height10 * 1.5,
            left: Dimensions.width10 * 2,
            right: Dimensions.width10 * 2),
        title: Padding(
          padding: EdgeInsets.symmetric(horizontal: Dimensions.width10 * 1.5),
          child: Text('Chapter 1'),
        ),
        children: _chapter1.entries
            .map((entry) => ListTile(
                  title: Text(
                    entry.key,
                    style: const TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  leading: CircleAvatar(
                      backgroundColor:
                          HelperFunctions.getColortestsLevel(entry.value),
                      radius: Dimensions.borderRadius5 * 2),
                  enabled: true,
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(Dimensions.borderRadius5 * 3),
                  ),
                  onTap: () {},
                  trailing: const Icon(Icons.keyboard_arrow_right_rounded),
                ))
            .toList(),
      ),
    );
  }
}

class GetTestName extends StatelessWidget {
  final DocumentReference list;
  GetTestName({Key? key, required this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
        future: list.get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          var data = snapshot.data!.data() as Map<String, dynamic>;
          if (snapshot.connectionState == ConnectionState.waiting)
            return Container();
          if (snapshot.hasError) {
            print(snapshot.error);
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          bool flag = false;
          for(int i=0;i<gTrialCourse.length;i++){

            if(data['cid']==gTrialCourse[i]['cid']){
              flag = true;
            }
          }
          for(int i=0;i<gPurchasedCourse.length;i++){
            if(data['cid']==gPurchasedCourse[i]['cid']){
              flag = true;
            }
          }
          print("${data['cid']} -- $flag");
          return(flag)? ListTile(
            title: data['subjectName'],
          ):SizedBox(width: 0,height: 0,);
        });
  }
}
