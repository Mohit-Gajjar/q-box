import 'package:flutter/material.dart';

class SubjectView extends StatelessWidget {
  const SubjectView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Subject View',
            style: TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.bold,
            ),
          ),
          elevation: 5,
          shadowColor: Colors.yellowAccent,
        ),
        body: const Center(
          child: Text('Progress'),
        ),
      ),
    );
  }
}
