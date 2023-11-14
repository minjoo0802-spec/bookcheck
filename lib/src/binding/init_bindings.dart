import 'package:bookscan_1/src/controller/auth_controller.dart';
import 'package:get/get.dart';
import '../controller/bottom_nav_controller.dart';

class InitBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(BottomNavController(), permanent: true);
    Get.put(AuthController());
  }
}