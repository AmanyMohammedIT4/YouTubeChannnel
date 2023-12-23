import 'dart:async';
import 'package:gard/views/control_view.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class SplashViewModel extends GetxController {
  @override
  void onInit() {
    super.onInit();
    Timer(Duration(seconds: 5), navigateToSecondPage);
  }
  // ...
   void navigateToSecondPage() {
    Get.offAll(() => ControlView());
  }
  // ...
}