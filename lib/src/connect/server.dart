import 'dart:convert';

import 'package:bookscan_1/src/model/book_info_model.dart';
import 'package:http/http.dart' as http;


class ServerConnect {
  final Uri _url = Uri.parse("http://10.101.86.210:3000");
  // isbn
  Future<void> sendBookData(String? isbn) async {
    try {
      final Map<String, dynamic> requestData = {
        'isbn': isbn,
      };
      final response = await http.post(
        Uri.parse("$_url/post"),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(requestData),
      );

      if (response.statusCode == 200) {
        print('Data sent successfully.');
        print('Response data: ${response.body}');
      } else {
        print('Failed to send data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error sending data: $e');
    }
  }

  // 내 책장 띄우기
  Future<void> sendUserData(String? id, String? isbn) async {
    try {
      final Map<String, dynamic> requestData = {
        'id': id,
        'isbn': isbn,
      };
      final response = await http.post(
        Uri.parse("$_url/addbookshelf"),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(requestData),
      );

      if (response.statusCode == 200) {
        print('Data sent successfully.');
        print('Response data: ${response.body}');
      } else {
        print('Failed to send data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error sending data: $e');
    }
  }

  // 책 정보 띄우기
  Future<BookInfoItem> fetchBookInfo() async {
    final response = await http.post(Uri.parse("$_url/book_info"));
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return BookInfoItem.fromJson(data);
    } else {
      throw Exception('Failed to load book info');
    }
  }

  Future<http.Response> sendUserIDIsbnReport(String? id, String? isbn, String? report) async {
    try {
      final Map<String, dynamic> requestData = {
        'id': id,
        'isbn': isbn,
        'report' : report
      };
      final response = await http.post(
        Uri.parse("$_url/report"),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(requestData),
      );

      if (response.statusCode == 200) {
        print('Data sent successfully.');
        print('Response data: ${response.body}');
      } else {
        print('Failed to send data. Status code: ${response.statusCode}');
      }

      return response;
      
    } catch (e) {
      print('Error sending data: $e');
      throw e;
    }
  }

  // 로그인
  Future<http.Response> sendLoginData(String? id, String? pw) async {
    try {
      final Map<String, dynamic> requestData = {
        'id': id,
        'pw': pw,
      };
      final response = await http.post(
        Uri.parse("$_url/login"),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(requestData),
      );

      if (response.statusCode == 200) {
        print('Data sent successfully.');
        print('Response data: ${response.body}');
        //_loginResponse = response.body;
      } else {
        print('Failed to send data. Status code: ${response.statusCode}');
        //_loginResponse = "로그인에 실패하였습니다.";
      }
      return response;
    } catch (e) {
      print('Error sending data: $e');
      return http.Response('Error: $e', 500);
      //_loginResponse = "오류 발생: $e";
    }
  }

  // 회원가입
  Future<http.Response> sendSignupData(
      String? name, String? id, String? pw) async {
    try {
      final Map<String, dynamic> requestData = {
        'name': name,
        'id': id,
        'pw': pw,
      };
      final response = await http.post(
        Uri.parse("$_url/register"),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(requestData),
      );

      if (response.statusCode == 200) {
        print('Data sent successfully.');
        print('Response data: ${response.body}');
      } else {
        print('Failed to send data. Status code: ${response.statusCode}');
      }
      return response;
    } catch (e) {
      print('Error sending data: $e');
      return http.Response('Error : $e', 500);
    }
  }
}
