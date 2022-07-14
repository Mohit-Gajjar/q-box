import 'package:get/get.dart';

class Dimensions {
  static double screenHeight = Get.context!.height; //820 for my screen
  static double screenWidth = Get.context!.width; //410 for my screen

  static double height10 = screenHeight / 82;
  static double width10 = screenWidth / 41;
  static double width15 = (screenWidth / 41) * 1.5;

  static double padding20 = screenWidth / 20.5;

  static double borderRadius12 = screenHeight / 68.3333333333;
  static double borderRadius5 = screenHeight / 164;
  static double borderRadius15 = (screenHeight / 164) * 3;
}
