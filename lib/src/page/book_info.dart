import 'dart:convert';

import 'package:bookscan_1/src/controller/book_info_controller.dart';
import 'package:bookscan_1/src/helper/app_bar.dart';
import 'package:bookscan_1/src/page/book_info.dart';
import 'package:bookscan_1/src/page/login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

import '../model/book_info_model.dart';

class BookInfo extends StatefulWidget {
  const BookInfo({super.key});

  @override
  _BookInfo createState() => _BookInfo();
}

class _BookInfo extends State<BookInfo> {
  //final BookInfoController controller = Get.put(BookInfoController());
  BookInfo({key}) {
    // controller.fetchBookInfo();
    // controller.onInit();
  }
  _BookInfo();

    Future<BookInfoItem> fetchBookInfo() async {
    final response =
      await http.post(Uri.parse("http://10.101.97.210:3000/book_info"));
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return BookInfoItem.fromJson(data);
    }
    else {
      throw Exception('Failed to load book info');
    }
  }

  // String _bookName = "변경되기 전!";

  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }

  Widget _bookInfo() {
    String _ImgUrl =
        'https://image.aladin.co.kr/product/32575/8/cover500/k642935143_1.jpg';
    
    //final item = controller.listItems[0];
    

    return Center(
      child: FutureBuilder<BookInfoItem> (
        future: fetchBookInfo(),
        builder:(context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            print("Error: ${snapshot.error}");
            return Text("Error : ${snapshot.error}");
          } else {
            final bookInfo = snapshot.data;
            return Column (
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('제목: ${bookInfo!.title.toString()}'),
                Text('작가: ${bookInfo.writer}'),
                Text('출판사: ${bookInfo.publisher}'),
                Text('판매가: \$${bookInfo.price.toStringAsFixed(2)}'),
                Text('줄거리: ${bookInfo.summary}'),
              ],
            );
          }
        },
      ),
    );
  
  }
  

  Widget _bookSimilar() {
    final Uri toLaunch = Uri(scheme: 'https', host: 'www.10x10.co.kr');

    return Scaffold(
      body: GridView.count(
        primary: false,
        padding: const EdgeInsets.all(20),
        crossAxisSpacing: 15,
        mainAxisSpacing: 15,
        crossAxisCount: 3,
        childAspectRatio: 1 / 1.5,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              _launchInBrowser(toLaunch);
            },
            child: Container(
              child: Column(
                children: [
                  Container(
                    width: 100,
                    height: 150,
                    decoration: BoxDecoration(
                        image: const DecorationImage(
                            image: NetworkImage(
                                'https://image.aladin.co.kr/product/32575/8/cover500/k642935143_1.jpg'))),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _addBook(BuildContext context) {
    return Container(
      child: FloatingActionButton.small(
        child: const Text("+"),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => LoginPage()));
        },
      ),
    );
  }

  // Widget _getRequestBtn(BuildContext context) {
  //   return Container(
  //     child: FloatingActionButton.small(
  //       child: const Text(""),
  //       onPressed: () async {
  //         http.Response _res = await http.get(Uri.parse("$_url/"));
  //         print(_res.body); //해리포터
  //         setState(() {
  //           _bookName = _res.body;
  //           print(_bookName);
  //         });
  //       },
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PageAppBar(),
      body: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Column(
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _bookInfo(),
            Expanded(child: _bookSimilar()),
            _addBook(context),
            //_getRequestBtn(context),
          ],
        ),
      ),
    );
  }
}
