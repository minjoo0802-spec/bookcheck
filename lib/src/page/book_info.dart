import 'package:bookscan_1/src/app.dart';
import 'package:bookscan_1/src/page/login.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

class BookInfo extends StatefulWidget {
  _BookInfo createState() => _BookInfo();
}

class _BookInfo extends State<BookInfo> {
  _BookInfo();

  String _bookName = "변경되기 전!";
  final String _url = "http://192.168.25.5:3000";

  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }

  Widget _bookInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // 책 표지 이미지
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Container(
                width: 100,
                height: 150,
                decoration: BoxDecoration(
                    image: const DecorationImage(
                        image: NetworkImage(
                            'https://image.aladin.co.kr/product/32575/8/cover500/k642935143_1.jpg'))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    child: Text(
                      "제목 : $_bookName",
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                  Container(
                    child: Text(
                      "작가 : ",
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                  Container(
                    child: Text(
                      "출판사 : ",
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                  Container(
                    child: Text(
                      "판매가 : ",
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                  Container(
                    child: Text(
                      "줄거리 : ",
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20, left: 20),
          child: Text(
            "\u{1F4DA} 장르별 유사 책",
            style: TextStyle(fontSize: 18),
          ),
        ),
      ],
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

  Widget _backButton(BuildContext context) {
    return Container(
      child: FloatingActionButton.small(
        child: const Text("<<"),
        onPressed: () {
          Navigator.pop(context);
        },
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

  Widget _getRequestBtn(BuildContext context) {
    return Container(
      child: FloatingActionButton.small(
        child: const Text(""),
        onPressed: () async {
          http.Response _res = await http.get(Uri.parse("$_url/"));
          print(_res.body); //해리포터
          setState(() {
            _bookName = _res.body;
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Column(
        //crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _bookInfo(),
          Expanded(child: _bookSimilar()),
          _backButton(context),
          _addBook(context),
          _getRequestBtn(context),
        ],
      ),
    );
  }
}
