// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import '../../widgets/appbar_actions.dart';

import '../../utilities/dimensions.dart';
class FullLengthTestsGuidelines extends StatefulWidget {
  const FullLengthTestsGuidelines({Key? key}) : super(key: key);

  @override
  State<FullLengthTestsGuidelines> createState() => _FullLengthTestsGuidelinesState();
}

class _FullLengthTestsGuidelinesState extends State<FullLengthTestsGuidelines> {
   bool agree = false;
   void _doSomething() {
    // Do something
  }
  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      appBar: AppBar(
        title: Text('Full Length Tests Guidelines'),
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
            ),
            
            
                    SizedBox(
                                  height: Dimensions.height10 * 5,
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
