
import 'package:flutter/material.dart';

import '../../widgets/appbar_actions.dart';

class AnotherCourseScreen extends StatefulWidget {
  const AnotherCourseScreen({Key? key}) : super(key: key);

  @override
  State<AnotherCourseScreen> createState() => _AnotherCourseScreenState();
}

class _AnotherCourseScreenState extends State<AnotherCourseScreen> {
  final List<String> _dropdownValues = ["Select Course","Test NEET 1", "Test JEE 2"];
  String selectedVal = "Select Course";
  //TODO: Incomplete page, no functionlality after course selection.
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 55, left: 20, right: 20),
            child: Container(
              height: 50,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(horizontal: 30.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                border: Border.all(
                    color: Colors.black87, style: BorderStyle.solid, width: 0.80),
              ),
              child:  DropdownButton(
                     icon: Visibility (visible:true, child: Icon(Icons.keyboard_arrow_down)),
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
                    isExpanded: true,
                    value: selectedVal,
                  ),
                
              ),
            ),
          // SizedBox(),
           const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(right: 28),
                  child: Align(
                    heightFactor: 2,
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      onPressed: (){},
                    child: Text('   Buy Now   '),
                    ),
                  ),
                )
        ],
      ),
    );
  }
}
