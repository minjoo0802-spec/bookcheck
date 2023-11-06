import 'package:bookscan_1/src/controller/list_item_controller.dart';
import 'package:bookscan_1/src/helper/app_bar.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TimeLinePage extends StatelessWidget {
  final ListItemController controller = Get.put(ListItemController());
  TimeLinePage({super.key}) {
    controller.fetchPosts();
    controller.onInit();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            child: CarouselSlider(
              items: [
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                        image: AssetImage(
                            'assets/images/ad_banner_image/banner_1.png'),
                        fit: BoxFit.cover,
                      )),
                ),
              ],
              options: CarouselOptions(
                aspectRatio: 2.0,
                enlargeCenterPage: true,
                scrollDirection: Axis.horizontal,
                autoPlay: true,
              ),
            ),
          ),
          SizedBox(
            height: 400,
            child: Obx(() {
              if (controller.listItems.isEmpty) {
                return Center(child: CircularProgressIndicator());
              } else {
                return RefreshIndicator(
                  onRefresh: () => controller.fetchPosts(),
                  child: ListView.builder(
                    itemCount: controller.listItems.length,
                    itemBuilder: (context, index) {
                      final item = controller.listItems[index];
                      return SizedBox(
                        height: 100,
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(4),
                              child: Image.network(
                                  'https://image.aladin.co.kr/product/32575/8/cover500/k642935143_1.jpg'),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 5),
                                    child: Text(
                                      item.title,
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 5),
                                    child: Text(item.userName),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8),
                                    child: Row(
                                      children: [
                                        Text('좋아요 수 ${item.like}'),
                                        SizedBox(width: 100),
                                        Text('댓글 수 ${item.reple}'),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                );
              }
            }),
          ),
        ],
      ),
    );
  }
}
