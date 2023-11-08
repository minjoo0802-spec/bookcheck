import 'package:bookscan_1/src/helper/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class BookReviewPage extends StatefulWidget {
  @override
  _BookReviewPageState createState() => _BookReviewPageState();
}

class _BookReviewPageState extends State<BookReviewPage> {
  double _rating = 0.0;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  Color backgroundColor = Color.fromRGBO(255, 220, 210, 1);

  void changeBackgroundColor(Color color) {
    setState(() {
      backgroundColor = color;
    });
  }

  @override
  Widget build(BuildContext context) {
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
                              'https://image.aladin.co.kr/product/32575/8/cover500/k642935143_1.jpg'))),
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
                        controller: _titleController,
                        decoration: InputDecoration(
                          hintText: '책 제목을 입력하세요',
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
                // 작성한 독후감을 저장하거나 처리하는 로직을 추가
                // _titleController.text: 제목
                // _rating: 평점
                // _contentController.text: 독후감 내용
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
