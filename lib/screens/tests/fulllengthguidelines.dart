import 'package:flutter/material.dart';
class FullLengthTestsGuidelines extends StatelessWidget {
  const FullLengthTestsGuidelines({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Full Length Tests Guidelines'),
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
                  "2. Full-Length test (FLT): The test is 3.00 hours in duration and the Test contains 90 multiple-choice questions (four options with a single correct answer) from Physics, Chemistry, and Mathematics where the total marks are 360. "),
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
