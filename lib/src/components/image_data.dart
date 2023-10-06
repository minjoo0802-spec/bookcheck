import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class ImageData extends StatelessWidget {
  String icon;
  //width 값을 받아도 안받아도 OK 디폴트값은 55
  final double? width;
  ImageData(this.icon, {Key? key, this.width=55}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(icon, width: width! / Get.mediaQuery.devicePixelRatio);
  }
}

class IconsPath{
  static String get cameraOff => 'assets/images/bottom_nav_icon/camera_off.png';
  static String get cameraOn => 'assets/images/bottom_nav_icon/camera_on.png';
  static String get listOff => 'assets/images/bottom_nav_icon/list_off.png';
  static String get listOn => 'assets/images/bottom_nav_icon/list_on.png';
  static String get starOff => 'assets/images/bottom_nav_icon/star_off.png';
  static String get starOn => 'assets/images/bottom_nav_icon/star_on.png';
  static String get heartOff => 'assets/images/bottom_nav_icon/heart_off.png';
  static String get heartOn => 'assets/images/bottom_nav_icon/heart_on.png';
}