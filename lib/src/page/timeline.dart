import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../components/image_data.dart';

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
  return SizedBox(
    height: 400,
    child: Container(
      child: ListView.separated(
        scrollDirection: Axis.vertical,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            leading: Icon(Icons.person),
            title: Text("11"),
            subtitle: Text("22"),
          );
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(),
        itemCount: 10,
      ),
    ),
  );
}
