import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../components/message_popup.dart';

enum PageName { HOME, TIMELINE, SHOP, MYBOOKS }

class BottomNavController extends GetxController {
  RxInt pageIndex = 0.obs;
  List<int> bottomHistory = [0];

  void changeBottomNav(int value, {bool hasGesture = true}) {
    var page = PageName.values[value];
    switch (page) {
      case PageName.HOME:
      case PageName.TIMELINE:
      case PageName.SHOP:
      case PageName.MYBOOKS:
        _changePage(value, hasGesture: hasGesture);
        break;
    }
    pageIndex(value);
  }

  Future<bool> willPopAction() async {
    if (bottomHistory.length == 1) {
      // print('exit!');
      showDialog(
          context: Get.context!,
          builder: (context) => MessagePopup(
                message: '종료하시겠습니까?',
                okCallback: () {
                  exit(0);
                },
                cancelCallback: Get.back,
                title: '시스템',
              ));
      return true;
    } else {
      // print('goto before page!');
      bottomHistory.removeLast();
      var index = bottomHistory.last;
      //뒤로가기 버튼으로 페이지 이동시에는 리스트에 추가 x
      changeBottomNav(index, hasGesture: false);
      // print(bottomHistory);
      return false;
    }
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
