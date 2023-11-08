import 'package:bookscan_1/src/page/code_scan.dart';
import 'package:bookscan_1/src/controller/bottom_nav_controller.dart';
import 'package:bookscan_1/src/page/my_bookshelf.dart';
import 'package:bookscan_1/src/page/shop.dart';
import 'package:bookscan_1/src/page/timeline.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'components/image_data.dart';

class App extends GetView<BottomNavController> {
  const App({super.key});
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: controller.willPopAction,
      child: Obx(
        () => Scaffold(
          body: IndexedStack(
            index: controller.pageIndex.value,
            children: [
              WillPopScope(
                onWillPop: () async {
                  int currentPageIndex = controller.pageIndex.value;

                  if (currentPageIndex > 0) {
                    controller.changeBottomNav(currentPageIndex - 1);
                    return false;
                  }

                  return true;
                },
                child: Navigator(
                  onGenerateRoute: (routeSettings) {
                    return MaterialPageRoute(
                        builder: (context) => CodeScan());
                  },
                ),
              ),
              TimeLinePage(),
              Shop(),
              MyBookShelf(),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            currentIndex: controller.pageIndex.value,
            onTap: controller.changeBottomNav,
            elevation: 0,
            items: [
              BottomNavigationBarItem(
                icon: ImageData(IconsPath.cameraOff),
                activeIcon: ImageData(IconsPath.cameraOn),
                label: '카메라',
              ),
              BottomNavigationBarItem(
                icon: ImageData(IconsPath.listOff),
                activeIcon: ImageData(IconsPath.listOn),
                label: '독후감',
              ),
              BottomNavigationBarItem(
                icon: ImageData(IconsPath.starOff),
                activeIcon: ImageData(IconsPath.starOn),
                label: '포인트샵',
              ),
              BottomNavigationBarItem(
                icon: ImageData(IconsPath.heartOff),
                activeIcon: ImageData(IconsPath.heartOn),
                label: '내 책장',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
