import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class CommunityController extends GetxController {
  final posts = <Post>[].obs;

  Future<void> fetchPosts() async {
    final response = await http.get(Uri.parse('http://10.101.34.99:3000/posts'));
    if (response.statusCode == 200) {
      final List<Post> data = postFromJson(response.body);
      posts.assignAll(data);
    }
  }
}

class Post {
  final int id;
  final String title;
  final String content;

  Post({required this.id, required this.title, required this.content});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      title: json['title'],
      content: json['content'],
    );
  }
}

List<Post> postFromJson(String str) {
  // JSON 데이터를 파싱하여 Post 목록을 반환합니다.
  
  final jsonData = json.decode(str);
  if (jsonData is List) {
    return jsonData.map((item) => Post.fromJson(item)).toList();
  } else if (jsonData is Map) {
    // 처리할 JSON 데이터가 목록이 아닌 경우, Post 하나를 반환할 수도 있습니다.
    return [Post.fromJson(jsonData as Map<String, dynamic>)];
  } else {
    // 처리할 수 없는 형태의 JSON 데이터인 경우 빈 목록 반환
    return [];
  }
}
