import 'package:flutter/material.dart';

import '../../utilities/dimensions.dart';

class LevelUpTestGuideLines extends StatefulWidget {
  const LevelUpTestGuideLines({Key? key}) : super(key: key);

  @override
  State<LevelUpTestGuideLines> createState() => _LevelUpTestGuideLinesState();
}

class _LevelUpTestGuideLinesState extends State<LevelUpTestGuideLines> {
   bool agree = false;
   void _doSomething() {
    // Do something
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Level Up Test Guidelines'),
      ),
      body: SingleChildScrollView(
        child: Column(
           mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             Padding(
               padding: const EdgeInsets.only(top: 9, left: 15, bottom: 6),
               child: Text(
                    'Exam Guidelines', style: TextStyle(color: Color.fromARGB(255, 194, 23, 10), fontSize: 17, fontWeight: FontWeight.w400),
                    ),
             ),
            ListTile(
              title: Text(
                  "1. As you are aware, all the examinations (FLT & Level up) are conducted by QRIOCTYBOX's R&D in online mode."),
            ),
            ListTile(
              title: Text(
                  "2. Level up series: In these exams, we will follow the rules of QRIOCTYBOX R&D. Where three section are available and each level has 30 questions, for level 'A' clearing marks 75℅, level 'B' clearing marks 65℅ and level 'C' 55℅. At first students will clear the level A then B & C. A has basic level question then B has moderate level and C has critical thinking level."),
            ),
            ListTile(
              title: Text(
                  "3. MCQs: To answer a question, the candidates need to choose one option corresponding to the correct answer or the most appropriate answer."),
            ),
            ListTile(
              title: Text(
                  "4. Correct answer or the most appropriate answer: Four marks (+4)."),
            ),
            ListTile(
              title: Text(
                  "5. Any incorrect option marked will be given minus one mark (-1)."),
            ),
            ListTile(
              title: Text(
                  "6. Any incorrect option marked will be given minus one mark (-1)."),
            ),
            ListTile(
              title: Text(
                  "7. Unanswered Marked for Review will be given no mark (0)"),
            ),
             SizedBox(
                                  height: Dimensions.height10 * 2,
                                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Material(
              child: Checkbox(
                    value: agree,
                    onChanged: (value) {
                      setState(() {
                        agree = value ?? false;
                      });
                    },
              ),
            ),
             const Text(
              'I have read all the guidelines',
              overflow: TextOverflow.ellipsis,
            ),
             ],
                ),
                
                 Padding(
                   padding: const EdgeInsets.only(left: 260, bottom: 13),
                   child: ElevatedButton(
            child: const Text('    Start Test     '),
            onPressed: agree ? _doSomething : null,
            ),
                 ),
          ],
        ),
      ),
    );
  }
}
