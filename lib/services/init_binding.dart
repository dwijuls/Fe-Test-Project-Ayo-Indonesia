import 'package:fetestproject/controller/main_controller.dart';
import 'package:get/get.dart';

class InitBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(MainController());
  }
}