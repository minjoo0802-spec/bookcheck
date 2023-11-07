import 'dart:convert';

import 'package:http/http.dart' as http;

class ServerConnect {
  final Uri _url = Uri.parse("http://10.101.97.210:3000");

  Future<void> sendData(String? data) async {
    try {

      final Map<String, dynamic> requestData = {
        'data': data,
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

}