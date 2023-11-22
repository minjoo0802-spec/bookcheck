import 'package:bookscan_1/src/helper/app_bar.dart';
import 'package:flutter/material.dart';

import 'book_report_write.dart' as book;

class BookReportReviewPage extends StatefulWidget {
  const BookReportReviewPage({super.key});

  @override
  _BookReportReviewPageState createState() => _BookReportReviewPageState();
}

class _BookReportReviewPageState extends State<BookReportReviewPage> {
  Color backgroundColor = Color(0xFFFFDCD2);

  // void changeBackgroundColor(Color color) {
  //   setState(() {
  //     backgroundColor = color;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500,
      width: 300,
      child: Scaffold(
        appBar: PageAppBar(),
        backgroundColor: book.backgroundColor,
        body: Center(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                ),
                Text(
                  "책 제목",
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "작성자",
                  style: TextStyle(fontSize: 15),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                    width: 200,
                    height: 300,
                    decoration: BoxDecoration(
                        border: Border(
                      left: BorderSide(color: Colors.black, width: 1),
                      right: BorderSide(color: Colors.black, width: 1),
                      top: BorderSide(color: Colors.black, width: 1),
                      bottom: BorderSide(color: Colors.black, width: 1),
                    )),
                    child: Center(child: Text("독후감 내용"))),
              ]),
        ),
      ),
    );
  }
}
