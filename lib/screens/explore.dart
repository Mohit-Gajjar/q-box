import 'package:flutter/material.dart';
import 'package:notes_app/screens/tabs_screen.dart';

import '../utilities/dimensions.dart';

class Explore extends StatelessWidget {
  static String routeName = 'explore';
  const Explore({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(Dimensions.padding20),
        width: Dimensions.screenWidth,
        height: Dimensions.screenHeight,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/login_bg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Image.asset('assets/images/Group.png'),
            const Text(
              'Explore The App',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              "QRIOCTYBOX is an Ed-tech company that focuses on helping students to excel in exams through practice and learning. Q-BOX is India's only company to provide students with an unlimited plethora of practice questions with video solutions for every question. At Q-BOX, we believe 'practice makes a man perfect' hence dedicate our efforts to instill the same attitude in our students. So joining us will ensure you ace your exam with utmost confidence and will bring you success in a smart way! #keeppracticing.",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 12,
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.popAndPushNamed(context, TabsScreen.routeName);
              },
              child: Padding(
                padding: EdgeInsets.all(Dimensions.padding20 / 2),
                child: Container(
                  width: double.infinity,
                  height: 51,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius:
                        BorderRadius.circular(Dimensions.borderRadius5),
                  ),
                  child: const Center(
                    child: Text(
                      "Lets Start",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const Text(
              'Tutorials?',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        )),
      ),
    );
  }
}
