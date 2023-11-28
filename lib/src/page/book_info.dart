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
                            child: RichText(
                              text: TextSpan(
                                style: DefaultTextStyle.of(context).style,
                                children: [
                                  TextSpan(
                                    text: '작가  : ',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextSpan(
                                    text: bookInfo.writer,
                                    style: TextStyle(fontSize: 15),
                                  )
                                ]
                              )
                            )),
                        SizedBox(
                          height: 40,
                          width: 250,
                          child: RichText(
                            text: TextSpan(
                              style: DefaultTextStyle.of(context).style,
                              children: [
                                TextSpan(
                                  text: '출판사 : ',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                TextSpan(
                                  text: bookInfo.publisher,
                                  style: TextStyle(fontSize: 15),
                                ),
                              ]
                            ),
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            style: DefaultTextStyle.of(context).style,
                            children: [
                              TextSpan(
                                text: '판매가 : ',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextSpan(
                                text: bookInfo.price.toString(),
                                style: TextStyle(fontSize: 15),
                              )
                            ]
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        RichText(
                          text: TextSpan(
                            style: DefaultTextStyle.of(context).style,
                            children: [
                              TextSpan(
                                text: '평점 : ',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextSpan(
                                text: bookInfo.rating.toString(),
                                style: TextStyle(fontSize: 15),
                              ),
                            ]
                          ),
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
                      child: RichText(
                        text: TextSpan(
                          style: DefaultTextStyle.of(context).style,
                          children: [
                            TextSpan(
                              text: '줄거리 : ',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                              text: bookInfo.summary,
                              style: TextStyle(fontSize: 15),
                            )
                          ]
                        ),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 10),
                  child: Column(
                    children: [
                      
                       _bookSimilar(),
                    ],
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

    return SizedBox(
      width: 400,
      height: 200,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '\u{1F4DA} 추천 책',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            GestureDetector(
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
                                    'https://image.aladin.co.kr/product/32881/55/cover200/k392936211_1.jpg'))),
                      ),
                      //SizedBox(width: 10,),
                      Container(
                        width: 120,
                        height: 150,
                        decoration: BoxDecoration(
                            image: const DecorationImage(
                                image: NetworkImage(
                                    'https://image.aladin.co.kr/product/27877/5/cover200/k692835315_2.jpg'))),
                      ),
                      Container(
                        width: 120,
                        height: 150,
                        decoration: BoxDecoration(
                            image: const DecorationImage(
                                image: NetworkImage(
                                    'https://image.aladin.co.kr/product/32875/68/cover200/k612936112_1.jpg'))),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _addBook(BuildContext context) {
    //final arguments = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    return FloatingActionButton(
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
        child: const Text("+"),
        onPressed: () {
          if (authController.isLoggedIn.value == true) {
            _server.sendUserData(id, qrCode);
            print('id : $id');
            print('qrCode : $qrCode');
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
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    // final arguments = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    return Scaffold(
      appBar: PageAppBar(),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image:  AssetImage(
                'assets/images/my_bookshelf_image/bookshelf_back.avif'),
            fit: BoxFit.cover,
                      
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Column(
            children: [
              _bookInfo(),
            ],
          ),
        ),
        
      ),
      floatingActionButton: _addBook(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
