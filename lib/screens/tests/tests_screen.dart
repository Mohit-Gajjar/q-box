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
    // TODO: impliment dynamic exam guidelines acording to the course choosen. 
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: Dimensions.width10 * 1.5,
              vertical: Dimensions.height10 * 3),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Tests',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: Dimensions.height10 * 3,
              ),
              Padding(
                padding: EdgeInsets.all(Dimensions.padding20),
                child: CustomButtonFull(
                  backColor: Colors.purple,
                  onTaphandler: () {
                    Navigator.of(context)
                        .pushNamed(LevelUpTestsScreen.routeName);
                  },
                  text: 'Level up series',
                ),
              ),
              //  SizedBox(
              //   height: 24,
              // ),
              Padding(
                padding: EdgeInsets.all(Dimensions.padding20),
                child: CustomButtonFull(
                  backColor: Colors.orange,
                  onTaphandler: () {
                    Navigator.of(context)
                        .pushNamed(FullLengthTestsScreen.routeName);
                  },
                  text: 'Full Length Tests',
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
