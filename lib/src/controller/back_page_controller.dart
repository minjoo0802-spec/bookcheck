import 'package:get/get.dart';

import 'bottom_nav_controller.dart';

class BackPageController extends GetxController {
  Future<bool> onWillPop() async {
    // 현재 페이지의 인덱스를 가져옵니다.
    int currentPageIndex = Get.find<BottomNavController>().pageIndex.value;

    // 만약 현재 페이지가 첫 번째 페이지(0번 페이지)가 아닌 경우
    // 이전 페이지로 이동하고 뒤로가기 액션을 처리합니다.
    if (currentPageIndex > 0) {
      Get.find<BottomNavController>().changeBottomNav(currentPageIndex - 1);
      return false; // 뒤로가기 액션을 처리하므로 false를 반환
    }

    // 현재 페이지가 첫 번째 페이지인 경우 앱을 종료합니다.
    return true; // 앱 종료
  }
}
