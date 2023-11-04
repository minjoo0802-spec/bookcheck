import 'dart:convert';

class ListItem {
  final String title;
  final String userName;
  final int like;
  final int reple;

  ListItem(
      {required this.title,
      required this.userName,
      required this.like,
      required this.reple});

  factory ListItem.fromJson(Map<String, dynamic> json) {
    return ListItem(
      title: json['title'],
      userName: json['userName'],
      like: json['like'],
      reple: json['reple'],
    );
  }
}

List<ListItem> postFromJson(String str) {
  // JSON 데이터를 파싱하여 Post 목록을 반환합니다.

  final jsonData = json.decode(str);
  if (jsonData is List) {
    return jsonData.map((item) => ListItem.fromJson(item)).toList();
  } else if (jsonData is Map) {
    // 처리할 JSON 데이터가 목록이 아닌 경우, Post 하나를 반환할 수도 있습니다.
    return [ListItem.fromJson(jsonData as Map<String, dynamic>)];
  } else {
    // 처리할 수 없는 형태의 JSON 데이터인 경우 빈 목록 반환
    return [];
  }
}
