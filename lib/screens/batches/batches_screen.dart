import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/initFunctions.dart';
import 'package:notes_app/utilities/dimensions.dart';

import './batch_details_screen.dart';
import '../../widgets/batch_name_tile.dart';

class BatchesScreen extends StatefulWidget {
  const BatchesScreen({Key? key}) : super(key: key);
  static const String routeName = '/batches-screen';

  @override
  State<BatchesScreen> createState() => _BatchesScreenState();
}

class _BatchesScreenState extends State<BatchesScreen> {
  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() async {
    FirebaseFirestore.instance.collection('batches').get().then((value) {
      print(value.docs[0].data());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: Dimensions.width10 * 1.5,
              vertical: Dimensions.height10 * 3),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Batches ',
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: Dimensions.height10 * 2,
                ),
                StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('batches')
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasError) {
                        return Text('Something went wrong');
                      }
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      }

                      return ListView.builder(
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            Map<String, dynamic>? data =
                            snapshot.data!.docs[index].data()
                            as Map<String, dynamic>;
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
                            return(flag)? BatchNameListTile(
                              batchName: data['batchName'] as String,
                              onTapHandler: () {
                                Navigator.of(context).pushNamed(
                                    BatcheDetailsScreen.routeName,
                                    arguments: {
                                      'batchName': data['batchName'],
                                      'teachers': data['teachers'].toList(),
                                    });
                              },
                            ):SizedBox(height: 0,width: 0,);
                          },
                          itemCount: snapshot.data!.docs.length);
                      // return ListView(
                      //   shrinkWrap: true,
                      //   physics: ClampingScrollPhysics(),
                      //   children: snapshot.data!.docs
                      //       .map((DocumentSnapshot document) {
                      //     Map<String, dynamic> data =
                      //         document.data()! as Map<String, dynamic>;
                      //     return data.isNotEmpty
                      //         ? BatchNameListTile(
                      //             batchName: data['title'],
                      //             onTapHandler: () async {
                      //               List<TeacherModel> teachersData = [];
                      //               for (var teacher in data['teachers']) {
                      //                 final snapshot = await teacher.get();

                      //                 if (snapshot.exists) {
                      //                   var data = snapshot.data()
                      //                       as Map<String, dynamic>;
                      //                   teachersData
                      //                       .add(TeacherModel.fromJson(data));
                      //                 }
                      //               }
                      //               Navigator.of(context).pushNamed(
                      //                   BatcheDetailsScreen.routeName,
                      //                   arguments: {
                      //                     'batchName': data['title'],
                      //                     'teachers': teachersData,
                      //                   });
                      //             })
                      //         : Center(
                      //             child: Text("No Batches"),
                      //           );
                      //   }).toList(),
                      // );
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
