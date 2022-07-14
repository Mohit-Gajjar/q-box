import 'package:flutter/material.dart';

class CustomButtonFull extends StatelessWidget {
  const CustomButtonFull({
    Key? key,
    required this.backColor,
    required this.onTaphandler,
    required this.text,
  }) : super(key: key);

  final Color backColor;
  final String text;
  final Function onTaphandler;

  TextStyle _textstyleWhite() {
    return const TextStyle(
      fontSize: 17.0,
      fontWeight: FontWeight.w500,
      color: Colors.white,
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTaphandler();
      },
      child: Material(
        elevation: 4.0,
        borderRadius: BorderRadius.circular(8.0),
        child: Container(
          width: MediaQuery.of(context).size.width - (30),
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: backColor,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: _textstyleWhite(),
          ),
        ),
      ),
    );
  }
}
