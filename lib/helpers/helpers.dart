import 'package:flutter/material.dart';

class HelperFunctions {
  static Color getColor(int id) {
    Color temp = Colors.grey;
    switch (id) {
      case 0:
        temp = Colors.grey.withOpacity(0.6);
        break;
      case 1:
        temp = Colors.green;
        break;
      case 2:
        temp = Colors.orange;
        break;
      case -1:
        temp = Colors.red;
        break;
    }
    return temp;
  }

  static Color getColorTests(int id) {
    Color temp = Colors.grey;
    switch (id) {
      case 0:
        temp = Colors.grey.withOpacity(0.6);
        break;
      case 1:
        temp = Colors.green;
        break;
      case 2:
        temp = Colors.purple;
        break;
      case -1:
        temp = Colors.red;
        break;
    }
    return temp;
  }

  static Color getColortestsLevel(String key) {
    Color temp = Colors.grey;
    switch (key) {
      case 'easy':
        temp = Colors.green;
        break;
      case 'medium':
        temp = Colors.orange;
        break;
      case 'hard':
        temp = Colors.red;
        break;
    }
    return temp;
  }

  static TextStyle textstyle() {
    return const TextStyle(
      fontSize: 17.0,
      fontWeight: FontWeight.w500,
    );
  }

  static TextStyle textstyleSolution() {
    return const TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.w500,
    );
  }

  static TextStyle textstyleWhite() {
    return const TextStyle(
      fontSize: 17.0,
      fontWeight: FontWeight.w500,
      color: Colors.white,
    );
  }

  static TextStyle textStyleCard() {
    return const TextStyle(
      fontSize: 19.0,
      fontWeight: FontWeight.bold,
    );
  }
}
