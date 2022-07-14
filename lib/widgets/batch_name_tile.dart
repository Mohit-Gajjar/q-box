import 'package:flutter/material.dart';

class BatchNameListTile extends StatelessWidget {
  const BatchNameListTile({
    Key? key,
    required this.batchName,
    required this.onTapHandler,
  }) : super(key: key);

  final String batchName;
  final Function onTapHandler;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text(
        batchName,
        style: const TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.w500,
        ),
      ),
      enabled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      onTap: () {
        onTapHandler();
      },
      trailing: const Icon(Icons.keyboard_arrow_right_rounded),
    );
  }
}
