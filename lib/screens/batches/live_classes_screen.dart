import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:notes_app/models/live.dart';
import 'package:notes_app/utilities/dimensions.dart';
import 'package:notes_app/widgets/appbar_actions.dart';

import '../../initFunctions.dart';

class LiveClassesScreen extends StatelessWidget {
  static const String routeName = '/live-classes-screen';
  const LiveClassesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leadingWidth: 14 * Dimensions.width10,
        leading: Padding(
          padding: EdgeInsets.only(left: Dimensions.width10),
          child: FittedBox(
            fit: BoxFit.fitWidth,
            child: Text(
              'Live Classes',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        actions: <Widget>[
          AppBarActions(),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            left: Dimensions.padding20 * (3 / 4),
            right: Dimensions.padding20 * (3 / 4),
            top: Dimensions.padding20,
          ),
          child: StreamBuilder(
            stream:
                FirebaseFirestore.instance.collection('liveVideos').snapshots(),
            builder:
                ((BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              // print(snapshot.data!.docs[0].data());
              return snapshot.hasData
                  ? ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        Map<String, dynamic> data = snapshot.data!.docs[index]
                            .data() as Map<String, dynamic>;
                        bool isLive = data['live'] as bool;
                        bool flag = true;
                        int k = 0;
                        int j = 0;
                        // ignore: unnecessary_null_comparison
                        if (gTrialCourse != null && gPurchasedCourse != null) {
                         
                            k = gTrialCourse.length;
                            j = gPurchasedCourse.length;
                        }
                        for (int i = 0; i < k; i++) {
                          if (data['cid'] == gTrialCourse[i]['cid']) {
                            flag = true;
                          }
                        }
                        for (int i = 0; i < j; i++) {
                          if (data['cid'] == gPurchasedCourse[i]['cid']) {
                            flag = true;
                          }
                        }
                        print("${data['cid']} -- $flag");
                        return (flag)
                            ? ListTile(
                                onTap: () {
                                  if (isLive) {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => JoinMeeting(
                                                  nameText: data['title'],
                                                  roomText: snapshot
                                                      .data!.docs[index].id,
                                                  subjectText: data['course'],
                                                )));
                                  } else
                                    Fluttertoast.showToast(
                                        msg: "Live Class not started");
                                },
                                title: Text(
                                  data['title'],
                                ),
                                subtitle: Text("Course: " +
                                    data['course'] +
                                    "Chapter: " +
                                    data['chapter']),
                              )
                            : SizedBox(height: 0, width: 0);
                      })
                  : Center(
                      child: CircularProgressIndicator(),
                    );
            }),
          ),
        ),
      ),
    );
  }
}
