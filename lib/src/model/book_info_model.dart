import 'dart:convert';
import 'dart:ffi';

class BookInfoItem {
  final String title;
  final String writer;
  final String publisher;
  final int price;
  final String summary;
  final String cover;
  final int rating;
  //final double rating;

  BookInfoItem(
    {required this.title,
    required this.writer,
    required this.publisher,
    required this.price,
    required this.summary,
    required this.cover,
    required this.rating,
    }
  );

  factory BookInfoItem.fromJson(Map<String, dynamic> json) {
    return BookInfoItem(
      title: json['title'],
      writer: json['writer'],
      publisher: json['publisher'],
      price: json['price'],
      summary: json['summary'],
      cover: json['cover'],
      rating: json['rating'],
    );
  }
}

List<BookInfoItem> postFromJson(String str) {
  // JSON 데이터를 파싱하여 Post 목록을 반환합니다.

  final jsonData = json.decode(str);
  if (jsonData is List) {
    return jsonData.map((item) => BookInfoItem.fromJson(item)).toList();
  } else if (jsonData is Map) {
    // 처리할 JSON 데이터가 목록이 아닌 경우, Post 하나를 반환할 수도 있습니다.
    return [BookInfoItem.fromJson(jsonData as Map<String, dynamic>)];
  } else {
    // 처리할 수 없는 형태의 JSON 데이터인 경우 빈 목록 반환
    return [];
  }
}