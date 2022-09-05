import 'package:flutter/material.dart';
import 'package:notes_app/utilities/dimensions.dart';
import 'package:notes_app/widgets/appbar_actions.dart';

import './test_start_screen.dart';

import '../../helpers/helpers.dart';
import '../../widgets/custom_button.dart';

class LiveTestsScreen extends StatefulWidget {
  LiveTestsScreen({Key? key, required this.tests}) : super(key: key);
  final List tests;
  static const String routeName = '/live-tests-screen';

  @override
  State<LiveTestsScreen> createState() => _LiveTestsScreenState();
}

class _LiveTestsScreenState extends State<LiveTestsScreen> {
  String fltJEE = """
  1.As you are aware, all the examinations (FLT & Level up) are conducted by QRIOCTYBOX's R&D in online mode.\n
  2.Full-Length test (FLT): The test is 3.00 hours in duration and the Test contains 90 multiple-choice questions (four options with a single correct answer) from Physics, Chemistry, and Mathematics where the total marks are 360. \n
  3.MCQs: To answer a question, the candidates need to choose one option corresponding to the correct answer or the most appropriate answer. \n
  4.Correct answer or the most appropriate answer: Four marks (+4).\n
  5.Any incorrect option marked will be given minus one mark (-1).\n
  6.Unanswered Marked for Review will be given no mark (0).\n
  """;
  String fltNEET = """
  1.As you are aware, all the examinations (FLT & Level up) are conducted by QRIOCTYBOX's R&D in online mode.\n
  2.Full-Length test (FLT): The test is 3.00 hours in duration and the Test contains 180 multiple-choice questions (four options with a single correct answer) from Physics, Chemistry, and Biology (Botany and Zoology), where the total marks are 720.\n
  3.MCQs: To answer a question, the candidates need to choose one option corresponding to the correct answer or the most appropriate answer. \n
  4.Correct answer or the most appropriate answer: Four marks (+4).\n
  5.Any incorrect option marked will be given minus one mark (-1).\n
  6.Unanswered Marked for Review will be given no mark (0).\n
  """;
  String levelUp = """
  1.	As you are aware, all the examinations (FLT & Level up) are conducted by QRIOCTYBOX's R&D in online mode.\n
  2.Level up series: In these exams, we will follow the rules of QRIOCTYBOX R&D. Where three section are available and each level has 30 questions, for level 'A' clearing marks 75℅, level 'B' clearing marks 65℅ and level 'C' 55℅. At first students will clear the level A then B & C. A .has basic level question then B has moderate level and C has critical thinking level.\n
  3.MCQs: To answer a question, the candidates need to choose one option corresponding to the correct answer or the most appropriate answer. \n
  4.Correct answer or the most appropriate answer: Four marks (+4).\n
  5.Any incorrect option marked will be given minus one mark (-1).\n
  6.Unanswered Marked for Review will be given no mark (0).\n
  """;

  final PageController _pageController = PageController();

  Container page1(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: widget.tests.length,
        itemBuilder: (context, index) {
          if (widget.tests.isNotEmpty) {
            return Column(
              children: [
                Container(
                  height: Dimensions.height10 * 8,
                  decoration: BoxDecoration(
                    color: Colors.deepPurple,
                    borderRadius:
                        BorderRadius.circular(Dimensions.borderRadius15),
                  ),
                  child: Center(
                    child: Text(
                      widget.tests[index],
                      style: HelperFunctions.textStyleCard(),
                    ),
                  ),
                ),
                SizedBox(
                  height: Dimensions.height10 * 2.5,
                ),
                Align(
                  alignment: Alignment.center,
                  child: CustomButton(
                    backColor: Theme.of(context).primaryColor,
                    onTapHandler: () {
                      _pageController.animateToPage(2,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeIn);
                    },
                    text: 'Take Test',
                  ),
                )
              ],
            );
          } else {
            return Center(
              child: Text("No Live Tests Going on"),
            );
          }
        },
      ),
    );
  }

  Column page2(BuildContext context) {
    return Column(
      children: [
        Container(
          height: Dimensions.height10 * 50,
          decoration: BoxDecoration(
            color: Colors.deepPurple,
            borderRadius: BorderRadius.circular(Dimensions.borderRadius15),
          ),
          child: Center(
            child: Text(
              fltJEE,
              style: HelperFunctions.textStyleCard(),
              overflow: TextOverflow.fade,
            ),
          ),
        ),
        SizedBox(
          height: Dimensions.height10 * 3.5,
        ),
        Align(
          alignment: Alignment.center,
          child: CustomButton(
            backColor: Theme.of(context).primaryColor,
            onTapHandler: () {
              Navigator.of(context).pushNamed(TestStartScreen.routeName);
            },
            text: 'Start Test',
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: FittedBox(
          child: Text(
            'Live Tests',
            style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
        ),
        actions: [
          AppBarProfileIcon(
            profileRadius: Dimensions.width15,
          ),
        ],
      ),
      bottomSheet: Container(
        height: 40,
        child: Center(child: Text("Swipe right --> to see guidelines")),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 30.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height - 130,
                  child: PageView(
                    controller: _pageController,
                    children: [
                      page1(context),
                      page2(context),
                    ],
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

/*
Container(
                        height: 80,
                        decoration: BoxDecoration(
                          color: Colors.yellow,
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Center(
                          child: Text(
                            'Test Name',
                            style: HelperFunctions.textStyleCard(),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: CustomButton(
                          backColor: Colors.grey,
                          onTaphandler: () {},
                          text: 'Take test',
                        ),
                      )
*/
