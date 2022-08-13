import 'package:flutter/material.dart';
import 'package:notes_app/utilities/dimensions.dart';

import './full_length_tests_screen.dart';
import './level_up_screen.dart';
import '../../widgets/custom_button_full.dart';

class TestsScreen extends StatelessWidget {
  const TestsScreen({Key? key}) : super(key: key);
  static const String routeName = '/tests-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: Dimensions.width10 * 1.5,
              vertical: Dimensions.height10 * 3),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // Text(
              //   'Tests',
              //   style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              // ),
             
              // SizedBox(
              //   height: Dimensions.height10 * 3,
              // ),
            CustomButtonFull(
                  backColor: Colors.white,
                  onTaphandler: () {
                    Navigator.of(context)
                        .pushNamed(LevelUpTestsScreen.routeName);
                  },
                  text: 'Level up series',
                  // icon: Icon(Icons.arrow_back_ios),
                ),
               SizedBox(
                height: 10,
              ),
            CustomButtonFull(
                  backColor: Colors.white,
                  onTaphandler: () {
                    Navigator.of(context)
                        .pushNamed(FullLengthTestsScreen.routeName);
                  },
                  text: 'Full Length Tests',
                  //  icon: Icon(Icons.arrow_back_ios),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
