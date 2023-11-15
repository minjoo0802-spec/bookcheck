import 'package:bookscan_1/src/controller/auth_controller.dart';
import 'package:bookscan_1/src/helper/app_bar.dart';
import 'package:bookscan_1/src/page/login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../app.dart';
import '../connect/server.dart';
import '../model/book_info_model.dart';

class BookInfo extends StatefulWidget {
  final String? id, qrCode;
  const BookInfo({this.id, this.qrCode});

  @override
  _BookInfo createState() => _BookInfo(id: id, qrCode: qrCode);
}

class _BookInfo extends State<BookInfo> {
  final String? id;
  final String? qrCode;

  // BookInfo({key}) {}
  final AuthController authController = Get.find();

  final ServerConnect _server = ServerConnect();

  App app = App();

  _BookInfo({required this.id, required this.qrCode});

  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }

  Widget _bookInfo() {
    return Center(
      child: FutureBuilder<BookInfoItem>(
        future: _server.fetchBookInfo(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            print("Error: ${snapshot.error}");
            return Text("Error : ${snapshot.error}");
          } else {
            final bookInfo = snapshot.data;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: SizedBox(
                    height: 70,
                    width: 350,
                    child: Text(
                      '\" ${bookInfo!.title.toString()} \"',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          backgroundColor: Colors.black12),
                    ),
                  ),
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 15,
                    ),
                    Container(
                        width: 100,
                        height: 150,
                        child: Image.network(bookInfo.cover)),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                            height: 40,
                            width: 250,
                            child: Text(
                              '작가  : ${bookInfo.writer}',
                              style: TextStyle(
                                  fontSize: 15, fontFamily: 'basic_fonts'),
                            )),
                        SizedBox(
                          height: 40,
                          width: 250,
                          child: Text(
                            '출판사: ${bookInfo.publisher}',
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                        Text(
                          '판매가: ${bookInfo.price} 원',
                          style: TextStyle(fontSize: 15),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          '평점: ${bookInfo.rating}',
                          style: TextStyle(fontSize: 15),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15.0, left: 15),
                  child: SizedBox(
                      width: 350,
                      height: 200,
                      child: Text(
                        '줄거리: ${bookInfo.summary}',
                        style: TextStyle(fontSize: 15),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 10),
                  child: Text(
                    '\u{1F4DA} 유사한 책들',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
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
      body: GestureDetector(
        onTap: () {
          _launchInBrowser(toLaunch);
        },
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Padding(
            padding: EdgeInsets.only(top: 10),
            child: Row(
              children: [
                Container(
                  width: 120,
                  height: 150,
                  decoration: BoxDecoration(
                      image: const DecorationImage(
                          image: NetworkImage(
                              'https://image.aladin.co.kr/product/32575/8/cover500/k642935143_1.jpg'))),
                ),
                //SizedBox(width: 10,),
                Container(
                  width: 120,
                  height: 150,
                  decoration: BoxDecoration(
                      image: const DecorationImage(
                          image: NetworkImage(
                              'https://image.aladin.co.kr/product/32649/26/cover500/8954695973_1.jpg'))),
                ),
                Container(
                  width: 120,
                  height: 150,
                  decoration: BoxDecoration(
                      image: const DecorationImage(
                          image: NetworkImage(
                              'https://image.aladin.co.kr/product/32591/29/cover500/k352935549_2.jpg'))),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _addBook(BuildContext context) {
    //final arguments = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    return FloatingActionButton.small(
        child: const Text("+"),
        onPressed: () {
          if (authController.isLoggedIn.value == true) {
            // Navigator.push(
            //   context, MaterialPageRoute(builder: (context) => LoginPage(id: id, qrCode: qrCode,),
            //   settings: RouteSettings(arguments: {'name': "BookInfo -> Login"})));
            // Navigator.pop(context);
            _server.sendUserData(id, qrCode);
            // print('id : ${arguments?['id']}');
            print('id : $id');
            app.controller.pageIndex.value = 3;
          } else {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => LoginPage(
                          id: id,
                          qrCode: qrCode,
                        ),
                    settings:
                        RouteSettings(arguments: {'name': "BookInfo -> Login"})
                    // settings: RouteSettings(arguments: {'name': "BookInfo -> Login", 'qrCode': qrCode})));
                    ));
            //print('qrcode : $qrCode');
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    // final arguments = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
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
