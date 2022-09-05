import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/screens/tests/levelupguidelines.dart';
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
  String chapterName = '';
  bool _isSelectedChapter = false;
  String? _selectChapter;
  String? _selectSubject;
  // bool _isChapter1 =  false;
  bool _ischapu = false;

  final Map<String, String> _chapter1 = const {
    'Level 1  ': 'easy',
    'Level 2  ': 'easy',
    'Level 3  ': 'medium',
  };

  final Map<String, String> _chapter2 = const {
    'Level 1 ': 'easy',
    'Level 2 ': 'medium',
    'Level 3 ': 'hard',
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
        actions: [
          IconButton(
              onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: ((context) => LevelUpTestGuideLines()))),
              icon: Icon(Icons.info_outline))
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 19),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Container(
                          height: 50,
                          width: Dimensions.width10 * 19,
                          padding: EdgeInsets.symmetric(
                            horizontal: 5.0,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15.0),
                            border: Border.all(
                                color: Colors.black12,
                                style: BorderStyle.solid,
                                width: 0.80),
                          ),
                          child: StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection('chapter')
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return const Center(
                                  child: CupertinoActivityIndicator(),
                                );
                              }

                              return Container(
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton(
                                    icon: const Visibility(
                                        visible: true,
                                        child: Icon(Icons.keyboard_arrow_down)),
                                    value: _selectSubject,
                                    // isDense: true,
                                    items: snapshot.data!.docs
                                        .map((DocumentSnapshot doc) {
                                      Map<String, dynamic> data =
                                          doc.data() as Map<String, dynamic>;
                                      return DropdownMenuItem<String>(
                                          value: data['subject'],
                                          child: Text(data['subject']));
                                    }).toList(),
                                    hint: const Text("Select Subject"),
                                    onChanged: (value) {
                                      setState(() {
                                        _selectSubject = value as String?;
                                      });
                                    },
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    Container(
                      height: 50,
                      width: Dimensions.width10 * 19,
                      padding: EdgeInsets.symmetric(
                        horizontal: 6.0,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.0),
                        border: Border.all(
                            color: Colors.black12,
                            style: BorderStyle.solid,
                            width: 0.80),
                      ),
                      child: StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('chapter')
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return const Center(
                              child: CupertinoActivityIndicator(),
                            );
                          }

                          return Container(
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton(
                                icon: const Visibility(
                                    visible: true,
                                    child: Icon(Icons.keyboard_arrow_down)),
                                value: _selectChapter,
                                // isDense: true,
                                items: snapshot.data!.docs
                                    .map((DocumentSnapshot doc) {
                                  Map<String, dynamic> data =
                                      doc.data() as Map<String, dynamic>;
                                  return DropdownMenuItem<String>(
                                      value: data['chapter'],
                                      child: Text(data['chapter']));
                                }).toList(),
                                hint: const Text("Select Chapter"),
                                onChanged: (value) {
                                  setState(() {
                                    _selectChapter = value as String?;
                                    _ischapu = true;
                                  });
                                },
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),

                SizedBox(
                  height: 10,
                ),
                _ischapu == false
                    ? Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              Dimensions.borderRadius5 * 3),
                        ),
                        color: Colors.white,
                        elevation: 0.8,
                        margin: EdgeInsets.symmetric(
                            horizontal: Dimensions.width10 * 0.8),
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
                                  horizontal: Dimensions.width10 * 1),
                              child: Text('Complete Test Series  '),
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
                                          backgroundColor: HelperFunctions
                                              .getColortestsLevel(entry.value),
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
                      )
                    : SizedBox(
                        // height: Dimensions.height10 * 1,
                      ),
                LevelUpSeriesCard1(chapter1: _chapter1),
                SizedBox(
                  height: Dimensions.height10 * 3,
                ),
                // _isSelectedChapter == true ?
                     LevelUpSeriesCard2(chapter2: _chapter2)
                    // : SizedBox()

                // Card(
                //   shape: RoundedRectangleBorder(
                //     borderRadius:
                //         BorderRadius.circular(Dimensions.borderRadius5 * 3),
                //   ),
                //   color: Colors.white,
                //   elevation: 4.0,
                //   margin:
                //       EdgeInsets.symmetric(horizontal: Dimensions.width10 * 1.5),
                //   child: IgnorePointer(
                //     ignoring: true,
                //     child: ExpansionTile(
                //       childrenPadding: EdgeInsets.only(
                //         bottom: Dimensions.height10 * 1.5,
                //         left: Dimensions.width10 * 2,
                //         right: Dimensions.width10 * 2,
                //       ),
                //       title: Padding(
                //         padding: EdgeInsets.symmetric(
                //             horizontal: Dimensions.width10 * 1.5),
                //         child: Row(
                //           children: [
                //             Text('Chapter 2   '),
                //             Icon(Icons.lock_outline, size: 20,)
                //           ],
                //         ),
                //       ),
                //       children: _chapter2.entries
                //           .map((entry) => ListTile(
                //                 title: Text(
                //                   entry.key,
                //                   style: const TextStyle(
                //                     fontSize: 16.0,
                //                     fontWeight: FontWeight.w500,
                //                   ),
                //                 ),
                //                 leading: CircleAvatar(
                //                     backgroundColor:
                //                         HelperFunctions.getColortestsLevel(
                //                             entry.value),
                //                     radius: Dimensions.borderRadius12),
                //                 enabled: true,
                //                 shape: RoundedRectangleBorder(
                //                   borderRadius: BorderRadius.circular(
                //                       Dimensions.borderRadius5 * 3),
                //                 ),
                //                 onTap: () {},
                //                 trailing: const Icon(
                //                     Icons.keyboard_arrow_right_rounded),
                //               ))
                //           .toList(),
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LevelUpSeriesCard1 extends StatelessWidget {
  const LevelUpSeriesCard1({
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
      elevation: 0.6,
      margin: EdgeInsets.symmetric(horizontal: Dimensions.width10 * 0.8, vertical: 5),
      child: ExpansionTile(
        childrenPadding: EdgeInsets.only(
            bottom: Dimensions.height10 * 8.5,
            left: Dimensions.width10 * 2,
            right: Dimensions.width10 * 2),
        title: Padding(
          padding: EdgeInsets.symmetric(horizontal: Dimensions.width10 * 1.5),
          child: Text('Chapter 1 '),
        ),
        children: _chapter1.entries
            .map((entry) => ListTile(
                  title: Row(
                    children: [
                      Text(
                        entry.key,
                        style: const TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Icon(
                        Icons.lock_outline,
                        size: 20,
                        color: Colors.red,
                      )
                    ],
                  ),
                  // leading: CircleAvatar(
                  //     backgroundColor:
                  //         HelperFunctions.getColortestsLevel(entry.value),
                  //     radius: Dimensions.borderRadius5 * 2),
                  // enabled: true,
                  // shape: RoundedRectangleBorder(
                  //   borderRadius:
                  //       BorderRadius.circular(Dimensions.borderRadius5 * 3),
                  // ),
                  onTap: () {},
                  trailing: const Icon(Icons.keyboard_arrow_right_rounded),
                ))
            .toList(),
      ),
    );
  }
}

class LevelUpSeriesCard2 extends StatelessWidget {
  const LevelUpSeriesCard2({
    Key? key,
    required Map<String, String> chapter2,
  })  : _chapter2 = chapter2,
        super(key: key);

  final Map<String, String> _chapter2;

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
            bottom: Dimensions.height10 * 8.5,
            left: Dimensions.width10 * 2,
            right: Dimensions.width10 * 2),
        title: Padding(
          padding: EdgeInsets.symmetric(horizontal: Dimensions.width10 * 1.5),
          child: Row(
            children: [
              Text('Chapter 2     '),
              Icon(
                Icons.lock_outline,
                size: 20,
              )
            ],
          ),
        ),
        children: _chapter2.entries
            .map((entry) => ListTile(
                  title: Row(
                    children: [
                      Text(
                        entry.key,
                        style: const TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Icon(
                        Icons.lock_outline,
                        size: 20,
                        color: Colors.red,
                      )
                    ],
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
          for (int i = 0; i < gTrialCourse.length; i++) {
            if (data['cid'] == gTrialCourse[i]['cid']) {
              flag = true;
            }
          }
          for (int i = 0; i < gPurchasedCourse.length; i++) {
            if (data['cid'] == gPurchasedCourse[i]['cid']) {
              flag = true;
            }
          }
          print("${data['cid']} -- $flag");
          return (flag)
              ? ListTile(
                  title: data['subjectName'],
                )
              : SizedBox(
                  width: 0,
                  height: 0,
                );
        });
  }
}
