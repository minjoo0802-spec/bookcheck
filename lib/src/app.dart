import 'package:bookscan_1/src/page/book_info.dart';
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
      // ignore: sort_child_properties_last
      child: Obx(
        () => Scaffold(
          appBar: AppBar(
            title: Image.asset(
              'assets/images/app_bar_icon/logo.png',
              width: 55,
              height: 55,
            ),
            centerTitle: true,
          ),
          body: IndexedStack(
            index: controller.pageIndex.value,
            children: [
              Navigator(
                onGenerateRoute: (routeSettings) {
                  return MaterialPageRoute(
                      builder: (context) => const CodeScan());
                },
              ),
              TimeLine(),
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
                label: 'Camera',
              ),
              BottomNavigationBarItem(
                icon: ImageData(IconsPath.listOff),
                activeIcon: ImageData(IconsPath.listOn),
                label: 'TimeLine',
              ),
              BottomNavigationBarItem(
                icon: ImageData(IconsPath.starOff),
                activeIcon: ImageData(IconsPath.starOn),
                label: 'Shop',
              ),
              BottomNavigationBarItem(
                icon: ImageData(IconsPath.heartOff),
                activeIcon: ImageData(IconsPath.heartOn),
                label: 'MyBook',
              ),
            ],
          ),
        ),
      ),
      onWillPop: controller.willPopAction,
    );
  }
}
