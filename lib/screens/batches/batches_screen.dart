import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/models/teacherModel.dart';
import 'package:notes_app/utilities/dimensions.dart';

import './batch_details_screen.dart';
import '../../widgets/batch_name_tile.dart';

class BatchesScreen extends StatelessWidget {
  const BatchesScreen({Key? key}) : super(key: key);
  static const String routeName = '/batches-screen';

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
                      return ListView(
                        shrinkWrap: true,
                        physics: ClampingScrollPhysics(),
                        children: snapshot.data!.docs
                            .map((DocumentSnapshot document) {
                          Map<String, dynamic> data =
                              document.data()! as Map<String, dynamic>;
                          return data.isNotEmpty
                              ? BatchNameListTile(
                                  batchName: data['title'],
                                  onTapHandler: () async {
                                    List<TeacherModel> teachersData = [];
                                    for (var teacher in data['teachers']) {
                                      final snapshot = await teacher.get();

                                      if (snapshot.exists) {
                                        var data = snapshot.data()
                                            as Map<String, dynamic>;
                                        teachersData
                                            .add(TeacherModel.fromJson(data));
                                      }
                                    }
                                    Navigator.of(context).pushNamed(
                                        BatcheDetailsScreen.routeName,
                                        arguments: {
                                          'batchName': data['title'],
                                          'teachers': teachersData,
                                        });
                                  })
                              : Center(
                                  child: Text("No Batches"),
                                );
                        }).toList(),
                      );
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
