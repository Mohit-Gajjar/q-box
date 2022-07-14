import 'package:flutter/material.dart';
import 'package:notes_app/utilities/dimensions.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    required this.backColor,
    required this.onTapHandler,
    required this.text,
  }) : super(key: key);

  final Color backColor;
  final String text;
  final Function onTapHandler;

  TextStyle _textStyleWhite() {
    return TextStyle(
      fontSize: 17.0,
      fontWeight: FontWeight.w500,
      color: Colors.white,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 2 - (30),
      child: Material(
        color: backColor,
        elevation: 4,
        borderRadius: BorderRadius.circular(Dimensions.borderRadius5),
        child: MaterialButton(
          minWidth: MediaQuery.of(context).size.width / 2 - (30),
          onPressed: () {
            onTapHandler();
          },
          child: FittedBox(
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: _textStyleWhite(),
            ),
          ),
        ),
      ),
    );
  }
}
