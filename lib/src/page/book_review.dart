import 'package:bookscan_1/src/helper/app_bar.dart';
import 'package:flutter/material.dart';

class BookReviewPage extends StatefulWidget {
  @override
  _BookReviewPageState createState() => _BookReviewPageState();
}

class _BookReviewPageState extends State<BookReviewPage> {
  double _rating = 0.0;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PageAppBar(),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('책 제목'),
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
              onPressed: () {
                // 작성한 독후감을 저장하거나 처리하는 로직을 추가
                // _titleController.text: 제목
                // _rating: 평점
                // _contentController.text: 독후감 내용
              },
              child: Text('작성 완료'),
            ),
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
