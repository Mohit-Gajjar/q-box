import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/utilities/dimensions.dart';
import 'package:notes_app/widgets/appbar_actions.dart';

import '../../helpers/helpers.dart';
import '../../initFunctions.dart';
import './completed_tests_screen.dart';
import './live_tests_screen.dart';

class FullLengthTestsScreen extends StatefulWidget {
  const FullLengthTestsScreen({Key? key}) : super(key: key);
  static const String routeName = '/full-length-screen';

  @override
  State<FullLengthTestsScreen> createState() => _FullLengthTestsScreenState();
}

class _FullLengthTestsScreenState extends State<FullLengthTestsScreen> {
  List liveTest = [];

  List cmptTest=[];
  @override
  void initState() {
    getFullLengthTests();
    super.initState();
  }

  void getFullLengthTests(){
    FirebaseFirestore.instance.collection("fullLengthTest").get().then((docSnapshot){
      docSnapshot.docs.forEach((snapshot) {
        var data = snapshot.data();
        // print(snapshot.data()['id']);
        // QuestionModel qn = new QuestionModel(
        //     id : snapshot.data()['id'],
        //     question : snapshot.data()['question'],
        //     description : snapshot.data()['description'],
        //     // answers :
        //     // json['answers'] != null ? new Answers.fromJson(json['answers']) : null,
        //     // multipleCorrectAnswers : json['multiple_correct_answers'],
        //     // correctAnswers : json['correct_answers'] != null
        //     //     ? new CorrectAnswers.fromJson(json['correct_answers'])
        //     //     : null,
        //     correctAnswer : snapshot.data()['correct_answer'],
        //     explanation : snapshot.data()['explanation'],
        //     tip : snapshot.data()['tip'],
        //     tags : snapshot.data()['tags'].cast<String>(),
        //     category : snapshot.data()['category'],
        //     difficulty : snapshot.data()['difficulty'],
        //     chapterName : snapshot.data()['chapterName']
        // );
        // print(qn.difficulty);
        if(DateTime.now().difference(DateTime.parse(data['examTime'])).inDays < 3){
              cmptTest.add(data["testName"]);
        }
        else{
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
          if(flag)liveTest.add(data["testName"]);
        }
      });

    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: FittedBox(
          child: Text(
            'Full Length Tests',
            style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
        ),
        actions: [
          AppBarProfileIcon(
            profileRadius: Dimensions.width10,
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
              left: Dimensions.width15,
              right: Dimensions.width15,
              top: Dimensions.height10 * 3),
          child: Column(
            children: [
              InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>LiveTestsScreen(tests: liveTest)));
                },
                child: Container(
                  height: Dimensions.height10 * 20,
                  decoration: BoxDecoration(
                    color: Colors.yellow,
                    borderRadius:
                        BorderRadius.circular(Dimensions.borderRadius15),
                  ),
                  child: Center(
                    child: Text(
                      'Live Tests',
                      style: HelperFunctions.textStyleCard(),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: Dimensions.height10 * 2,
              ),
              GestureDetector(
                onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context)=>CompletedTestsScreen(tests: cmptTest))),

                child: Container(
                  height: Dimensions.height10 * 20,
                  decoration: BoxDecoration(
                    color: Colors.yellow,
                    borderRadius:
                        BorderRadius.circular(Dimensions.borderRadius15),
                  ),
                  child: Center(
                    child: Text(
                      'Completed Tests',
                      style: HelperFunctions.textStyleCard(),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
