import 'package:flutter/material.dart';
import 'package:notes_app/utilities/dimensions.dart';

class CategoryStyle extends StatelessWidget {
  final String title;
  final String OnTapRoute;
  CategoryStyle({Key? key, required this.title, required this.OnTapRoute})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, OnTapRoute);
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: Dimensions.width10 / 2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.borderRadius12 * 2),
          color: Theme.of(context).primaryColor,
        ),
        alignment: Alignment.center,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: Dimensions.width10 * 1.5),
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
