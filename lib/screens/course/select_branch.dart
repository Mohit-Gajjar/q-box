import 'package:flutter/material.dart';

class SelectBranch extends StatefulWidget {
  final String branch;
  const SelectBranch({Key? key, required this.branch}) : super(key: key);

  @override
  State<SelectBranch> createState() => _SelectBranchState();
}

class _SelectBranchState extends State<SelectBranch> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Branch'),
      ),
      body: Center(
        child: Text(widget.branch),
      ),
    );
  }
}
