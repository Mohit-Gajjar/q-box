import 'package:flutter/material.dart';

import './test_solutions.dart';

class CompletedTestsScreen extends StatefulWidget {
  const CompletedTestsScreen({Key? key, required this.tests}) : super(key: key);
  static const String routeName = '/completed-tests-screen';
  final List tests;

  @override
  State<CompletedTestsScreen> createState() => _CompletedTestsScreenState();
}

class _CompletedTestsScreenState extends State<CompletedTestsScreen> {
  @override
  Widget build(BuildContext context) {
    //TODO:  Impliment the completed tests backend service, currently it is just a mockup 
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
          child: ListView.builder(
            itemCount: widget.tests.length,
            itemBuilder: (context, index)=>Container(
            margin: const EdgeInsets.symmetric(vertical: 10.0),
            child: Card(
              elevation: 3,
              child: ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  
                ),
                tileColor: Colors.white,
                trailing: const Icon(Icons.keyboard_arrow_right_rounded),
                title: Text(widget.tests[index]),
                onTap: () {
                  Navigator.of(context)
                      .pushNamed(TestSolutionsScreen.routeName);
                },
              ),
            ),
          ),)
        ),
      ),
    );
  }
}
