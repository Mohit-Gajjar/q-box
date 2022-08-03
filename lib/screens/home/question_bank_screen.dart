import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/screens/home/practice_screen.dart';
import 'package:notes_app/screens/payments/payment_option.dart';
import 'package:notes_app/utilities/dimensions.dart';
import '../../initFunctions.dart';
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
                StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('practice')
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasError) {
                        return Text('Something went wrong!');
                      }
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      }
                      return ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            Map<String, dynamic> data =
                                snapshot.data!.docs[index].data()!
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

                            return (flag)?ListTile(
                              title: Text(data['subject']),
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text('Select Chapter'),
                                        content: Container(
                                            width: Dimensions.height10,
                                            child: StreamBuilder(
                                                stream: FirebaseFirestore.instance.collection('practice').where("subject", isEqualTo: data['subject']).snapshots(),
                                                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                                  return snapshot.hasData
                                                      ? ListView.builder(
                                                          shrinkWrap: true,
                                                          physics: ClampingScrollPhysics(),
                                                          itemCount: snapshot.data!.docs.length,
                                                          itemBuilder: (BuildContext context, int index) {
                                                            Map<String, dynamic> data1 = snapshot.data!
                                                                        .docs[index]
                                                                        .data()! as Map<String, dynamic>;
                                                            return ListTile(
                                                                title: Text(data1[
                                                                    'chapter']),
                                                                onTap: () {
                                                                  Navigator.push(
                                                                      context,
                                                                      MaterialPageRoute(
                                                                          builder: (context) => Practice(
                                                                              subjectName: data['subject'],
                                                                              chapter: data1['chapter'])));
                                                                });
                                                          },
                                                        )
                                                      : Center(
                                                          child:
                                                              CircularProgressIndicator());
                                                })),
                                      );
                                    });
                              },
                            ):SizedBox(height: 0,width: 0,);
                          });
                    }),
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
