import 'package:flutter/material.dart';
import 'package:notes_app/utilities/dimensions.dart';
import 'package:notes_app/widgets/appbar_actions.dart';

import '../../helpers/helpers.dart';
import './completed_tests_screen.dart';
import './live_tests_screen.dart';

class FullLengthTestsScreen extends StatelessWidget {
  const FullLengthTestsScreen({Key? key}) : super(key: key);
  static const String routeName = '/full-length-screen';

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
                  Navigator.of(context).pushNamed(LiveTestsScreen.routeName);
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
                onTap: () => Navigator.of(context)
                    .pushNamed(CompletedTestsScreen.routeName),
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
