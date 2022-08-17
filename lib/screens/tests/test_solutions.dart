import 'package:flutter/material.dart';
import 'package:notes_app/utilities/dimensions.dart';

import '../../helpers/helpers.dart';

class TestSolutionsScreen extends StatelessWidget {
  const TestSolutionsScreen({Key? key}) : super(key: key);
  static const String routeName = '/test-solutions-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
              left: Dimensions.width15,
              right: Dimensions.width15,
              top: Dimensions.height10 * 3),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      'Test name',
                      style: TextStyle(
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    Spacer(),
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.close_rounded,
                        size: 28,
                        color: Theme.of(context).primaryColor,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: Dimensions.height10 * 2,
                ),
                Row(
                  children: [
                    Container(
                      height: Dimensions.height10 * 10,
                      width: MediaQuery.of(context).size.width / 2.5 - 30,
                      child: CircleAvatar(
                        child:
                            Icon(Icons.person, size: Dimensions.height10 * 6),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(Dimensions.padding20 / 2),
                      width: MediaQuery.of(context).size.width / 1.5 - 30,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Total No of Questions : ',
                            style: HelperFunctions.textstyleSolution(),
                          ),
                          Text(
                            'No of Questions  Attempted : ',
                            style: HelperFunctions.textstyleSolution(),
                          ),
                          Text(
                            'No of Correct Answers : ',
                            style: HelperFunctions.textstyleSolution(),
                          ),
                          Text(
                            'Total marks : ',
                            style: HelperFunctions.textstyleSolution(),
                          ),
                          Text(
                            'Marks Obtained : ',
                            style: HelperFunctions.textstyleSolution(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: Dimensions.height10 * 2,
                ),
                Container(
                  height: Dimensions.height10 * 45,
                  width: double.infinity,
                  padding: EdgeInsets.all(Dimensions.padding20 * 0.75),
                  decoration: BoxDecoration(
                    color: Colors.blueGrey[100],
                    borderRadius:
                        BorderRadius.circular(Dimensions.borderRadius15),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: Dimensions.height10 * 2,
                      ),
                      Text(
                        '1. Here goes the question Here goes the question Here goes the question Here goes the question',
                        style: HelperFunctions.textStyleCard(),
                      ),
                      SizedBox(
                        height: Dimensions.height10 / 2,
                      ),
                      for (int i = 0; i < 4; i++)
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Row(
                            children: [
                              Text(' ${i + 1}',
                                  style: HelperFunctions.textStyleCard()
                                  ),
                              SizedBox(
                                width: Dimensions.height10 * 1.2,
                              ),
                              // CircleAvatar(
                              //   backgroundColor:
                              //       i == 0 ? Colors.green : Colors.red,
                              //   radius: 10.0,
                              // )
                            ],
                          ),
                        ),
                      SizedBox(
                        height: Dimensions.height10,
                      ),
                      Text(
                        'Your answer : B',
                        style: HelperFunctions.textStyleCard(),
                      ),
                      SizedBox(
                        height: Dimensions.height10,
                      ),
                      Text(
                        'Explanation .... ',
                        style: HelperFunctions.textStyleCard(),
                      ),
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
