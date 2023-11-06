import 'package:get/get.dart';

// import 'bottom_nav_controller.dart';

enum PageName {
  BookInfo,
}

class BackPageController extends GetxController {
  RxInt pageIndex = 0.obs;
  List<int> bottomHistory = [0];

  void changePageNav(int value, {bool hasGesture = true}) {
    var page = PageName.values[value];
    _changePage(value, hasGesture: hasGesture);
    pageIndex(value);
  }

  void _changePage(int value, {bool hasGesture = true}) {
    pageIndex(value);
    //뒤로가기 버튼으로 페이지 이동시에는 리스트에 추가 x
    if (!hasGesture) return;
    if (bottomHistory.contains(value)) {
      bottomHistory.remove(value);
    }
    bottomHistory.add(value);
    // print(bottomHistory);
  }
}
