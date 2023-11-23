import 'package:bookscan_1/src/helper/app_bar.dart';
import 'package:bookscan_1/src/page/my_bookshelf.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:get/get.dart';

import '../connect/server.dart';
import '../model/book_shelf_model.dart';


Color backgroundColor = Color.fromRGBO(255, 220, 210, 1);

class BookReportWritePage extends StatefulWidget {
  final int index;

  BookReportWritePage({required this.index});

  @override
  _BookReportWritePageState createState() => _BookReportWritePageState();
}

class _BookReportWritePageState extends State<BookReportWritePage> {
  double _rating = 0.0;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  final ServerConnect _server = ServerConnect();
  RxList<Book> books = <Book>[].obs;


  void changeBackgroundColor(Color color) {
    setState(() {
      backgroundColor = color;
    });
  }

  @override
  Widget build(BuildContext context) {
    //print(books[widget.index].book_title.toString());
    return Scaffold(
      appBar: PageAppBar(),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 100,
                  height: 150,
                  decoration: BoxDecoration(
                      image: const DecorationImage(
                          image: NetworkImage(
                              'https://image.aladin.co.kr/product/16839/4/cover/k492534773_1.jpg'))),
                ),
                SizedBox(width: 20,),
                Container(
                  height: 150,
                  width: 200,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Text('책 제목'),
                      ),
                      TextFormField(
                        enabled: false,
                        controller: _titleController,
                        decoration: InputDecoration(
                          hintText: "아몬드"
                        ),
                      ),
                      SizedBox(height: 16.0),
                      Text('평점'),
                      RatingBar(
                        rating: _rating,
                        onRatingChanged: (newRating) {
                          setState(() {
                            _rating = newRating;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            Text('독후감 내용'),
            TextFormField(
              controller: _contentController,
              maxLines: 5,
              decoration: InputDecoration(
                hintText: '독후감 내용을 입력하세요',
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
              onPressed: () {
                _server.sendUserIDIsbnReport(id, qrCode, _contentController.text.toString());
                print('id: $id, qrCode: $qrCode, report:${_contentController.text.toString()}');
              },
              child: Text('작성 완료',),
            ),
            SizedBox(height: 20,),
                ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context, 
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("배경색 선택"),
                          content: SingleChildScrollView(
                            child: ColorPicker(
                              pickerColor: backgroundColor,
                              onColorChanged: changeBackgroundColor,
                              pickerAreaHeightPercent: 0.8,
                            ),
                          ),
                          actions: <Widget>[
                            FloatingActionButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              })
                          ],
                        );
                      });
                }, 
                child: Text("배경색 변경"),),


          ],
          
        ),
      ),
    );
  }
}

class RatingBar extends StatelessWidget {
  final double rating;
  final ValueChanged<double> onRatingChanged;

  RatingBar({required this.rating, required this.onRatingChanged});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(5, (index) {
        final filled = index < rating;
        return InkWell(
          onTap: () => onRatingChanged(index + 1.0),
          child: Icon(
            filled ? Icons.star : Icons.star_border,
            color: filled ? Colors.yellow : Colors.grey,
          ),
        );
      }),
    );
  }
}
