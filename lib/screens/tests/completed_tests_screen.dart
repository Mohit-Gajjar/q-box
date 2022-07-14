import 'package:flutter/material.dart';

import './test_solutions.dart';

class CompletedTestsScreen extends StatelessWidget {
  const CompletedTestsScreen({Key? key}) : super(key: key);
  static const String routeName = '/completed-tests-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: FittedBox(
          child: Text(
            'Completed Tests',
            style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 30.0),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10.0),
                child: ListTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  tileColor: Colors.yellow,
                  trailing: const Icon(Icons.keyboard_arrow_right_rounded),
                  title: const Text('Test Name 1'),
                  onTap: () {
                    Navigator.of(context)
                        .pushNamed(TestSolutionsScreen.routeName);
                  },
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10.0),
                child: ListTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  tileColor: Colors.yellow,
                  trailing: const Icon(Icons.keyboard_arrow_right_rounded),
                  title: const Text('Test Name 2'),
                  onTap: () {
                    Navigator.of(context)
                        .pushNamed(TestSolutionsScreen.routeName);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
