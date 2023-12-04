import 'package:bookscan_1/src/helper/app_bar.dart';
import 'package:bookscan_1/src/page/post_detail_screen.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import '../model/list_item_model.dart';

class TimeLinePage extends StatelessWidget {
  //final ListItemController controller = Get.put(ListItemController());
  TimeLinePage({super.key}) {
    // controller.fetchPosts();
    // controller.onInit();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: MainAppBar(),
      body: SingleChildScrollView(
        child: Column(
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
                      ),
                    ),
                  ),
                  Container(
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                        image: NetworkImage(
                            'https://img.freepik.com/premium-vector/international-book-day-social-post-banner-template_657902-420.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                        image: NetworkImage(
                            'https://4.bp.blogspot.com/-5SCJTyJb7Zg/XDOP2MV_pUI/AAAAAAAAV-g/HBAyOHd_4XQZ_RVNqX6wcUbrugi2-SGPgCLcBGAs/s1600/Book%2BBanners%2Bby%2BThe%2BBook%2BKhaleesi.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
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
              height: 490,
              child: ListView(
                children: List.generate(5, (index) {
                  ListItem list = listItem[index];
                  return GestureDetector(
                    onTap: () {
                      _handleItemClick(context, index);
                    },
                    child: SizedBox(
                      height: 100,
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(4),
                            child: Image.network(list.img),
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
                                    list.title,
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 5),
                                  child: Text(list.userName),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 8),
                                  child: Row(
                                    children: [
                                      Text('좋아요 수 ${list.like}'),
                                      SizedBox(width: 100),
                                      Text('댓글 수 ${list.reple}'),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleItemClick(BuildContext context, int index) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => PostDetailScreen(
                  index: index,
                )));
  }
}
