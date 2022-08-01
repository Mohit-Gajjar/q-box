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

  final PageController _pageController = PageController();

  Container page1(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: widget.tests.length,
        itemBuilder:(context, index)=> Column(
          children: [
            Container(
              height: Dimensions.height10 * 8,
              decoration: BoxDecoration(
                color: Colors.yellow,
                borderRadius: BorderRadius.circular(Dimensions.borderRadius15),
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
        ),
      ),
    );
  }

  Column page2(BuildContext context) {
    return Column(
      children: [
        Container(
          height: Dimensions.height10 * 50,
          decoration: BoxDecoration(
            color: Colors.yellow,
            borderRadius: BorderRadius.circular(Dimensions.borderRadius15),
          ),
          child: Center(
            child: Text(
              'Test Guidelines',
              style: HelperFunctions.textStyleCard(),
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
            profileRadius: Dimensions.width10,
          ),
        ],
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
