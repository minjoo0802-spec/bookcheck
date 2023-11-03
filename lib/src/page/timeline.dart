import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class TimeLine extends StatefulWidget {
  const TimeLine({super.key});

  @override
  State<TimeLine> createState() => _TimeLineState();
}

class Report {
  int age;
  String name;

  Report(this.age, this.name);
}

late final Report _report;



class _TimeLineState extends State<TimeLine> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(2.0),
          child: Column(
            children: <Widget>[
              AdBanner(),
              CommunityList(),
            ],
          ),
        ),
      ),
    );
  }
}

Widget AdBanner() {
  return Container(
    padding: EdgeInsets.all(10),
    child: CarouselSlider(
      items: [
        Container(
          height: 200,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                image: AssetImage('assets/images/ad_banner_image/banner_1.png'),
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
  );
}


Widget CommunityList() {
  String _bookName = "해리포터";
  String _writer = "책벌레";
  int _like = 0;
  int _reple = 0;

  return SingleChildScrollView(
    scrollDirection: Axis.vertical,
    child: SizedBox(
      height: 500,
      child: Container(
        child: ListView.separated(
          scrollDirection: Axis.vertical,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              height: 100,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Image.network('https://image.aladin.co.kr/product/32575/8/cover500/k642935143_1.jpg'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Text('$_bookName', style: TextStyle(fontSize: 20),),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: Text('$_writer'),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 35),
                          child: Row(
                            children: [
                              Text('좋아요 수 $_like'),
                              SizedBox(width: 100),
                              Text('댓글 수 $_reple'),
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
          separatorBuilder: (BuildContext context, int index) => const Divider(),
          itemCount: 10,
        ),
      ),
    ),
  );
}
