import 'package:flutter/material.dart';

class FreeClasses extends StatefulWidget {
  const FreeClasses({Key? key}) : super(key: key);

  @override
  State<FreeClasses> createState() => _FreeClassesState();
}

class _FreeClassesState extends State<FreeClasses> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('FreeClasses'),
      ),
    );
  }
}