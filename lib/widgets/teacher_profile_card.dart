import 'package:flutter/material.dart';
import 'package:notes_app/utilities/dimensions.dart';

import 'custom_button.dart';

class TeacherProfileCard extends StatelessWidget {
  const TeacherProfileCard(
      {Key? key, required this.text, required this.onTaphandler})
      : super(key: key);

  final String text;
  final Function onTaphandler;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      width: double.infinity,
      padding: EdgeInsets.symmetric(
          horizontal: Dimensions.width10 * 1.5,
          vertical: Dimensions.height10 * 2),
      margin: EdgeInsets.symmetric(vertical: Dimensions.height10),
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Column(
        children: [
          SizedBox(
            height: Dimensions.height10 * 8,
          ),
          Align(
            alignment: Alignment.center,
            child: Text(
              text,
              style:
                  const TextStyle(fontSize: 19.0, fontWeight: FontWeight.w500),
            ),
          ),
          const Spacer(),
          CustomButton(
            backColor: Colors.pink,
            onTapHandler: () {
              onTaphandler();
            },
            text: 'Follow',
          )
        ],
      ),
    );
  }
}
