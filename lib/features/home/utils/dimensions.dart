import 'package:get/get.dart';

class Dimensions {
  static double screenHeight = Get.context!.height;
  static double screenWidth = Get.context!.width;

  static double pageView = screenHeight / (6.444444 - 3.555556);
  // 640 : 180 = 3.555556
  static double pageViewContainer = screenHeight / 3.555556;
  static double pageViewTextContainer = screenHeight / 6.444444;

  // 640 : 10 = 64
  // dynamic height padding and margin
  static double height10 = screenHeight / 64;
  static double height20 = screenHeight / 32;
  static double height15 = screenHeight / 42.67;

  // dynamic width padding and margin
  static double width10 = screenWidth / 64;
  static double width20 = screenWidth / 32;
  static double width15 = screenWidth / 42.67;

  static double font20 = screenHeight / 32;
  static double font12 = screenHeight / 53.33;

  static double radius20 = screenHeight / 32;
  static double radius5 = screenHeight / 128;
  static double radius30 = screenHeight / 21.33;
}
