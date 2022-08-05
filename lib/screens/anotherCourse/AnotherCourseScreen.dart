
import 'package:flutter/material.dart';

import '../../widgets/appbar_actions.dart';

class AnotherCourseScreen extends StatefulWidget {
  const AnotherCourseScreen({Key? key}) : super(key: key);

  @override
  State<AnotherCourseScreen> createState() => _AnotherCourseScreenState();
}

class _AnotherCourseScreenState extends State<AnotherCourseScreen> {
  final List<String> _dropdownValues = ["Select Course","Test nEET 1", "Test JEE 2"];
  String selectedVal = "Select Course";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(196, 196, 196, 0.75),
        title: Text(
          "Add New Course",
          style: TextStyle(
              fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        actions: <Widget>[AppBarActions2()],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                border: Border.all(
                    color: Colors.black87, style: BorderStyle.solid, width: 0.80),
              ),
              child: DropdownButton(
                items: _dropdownValues
                    .map((value) => DropdownMenuItem(
                          child: Text(value),
                          value: value,
                        ))
                    .toList(),
                onChanged: (String? value) {
                  setState(() {
                    selectedVal=value!;
                  });
                },
                isExpanded: false,
                value: selectedVal,
              ),
            ),
            SizedBox()
          ],
        ),
      ),
    );
  }
}
