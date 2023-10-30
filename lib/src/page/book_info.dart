import 'package:bookscan_1/src/app.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class BookInfo extends StatelessWidget {
  const BookInfo({super.key});

  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }

  Widget _bookInfo() {
    return Row(
      children: [],
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
        crossAxisCount: 2,
        childAspectRatio: 1 / 1.3,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              _launchInBrowser(toLaunch);
            },
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.7),
                      spreadRadius: 0,
                      blurRadius: 0,
                      offset: Offset(0, 3),
                    )
                  ]),
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10)),
                    child: Image(
                        image: AssetImage(
                            'assets/images/pointshop_image/item1.jpg'),
                        fit: BoxFit.fill),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 6),
                    child: Text("2024 별별일상 다이어리 (날짜형)"),
                  )
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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _bookInfo(),
        Expanded(child: _bookSimilar()),
        _backButton(context),
      ],
    );
  }
}
