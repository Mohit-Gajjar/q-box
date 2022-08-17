import 'package:flutter/material.dart';

class LevelUpTestGuideLines extends StatelessWidget {
  const LevelUpTestGuideLines({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Level Up Test Guidelines'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
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
            )
          ],
        ),
      ),
    );
  }
}
