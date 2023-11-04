import 'dart:convert';

import 'package:bookscan_1/src/model/list_item_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ListItemController extends GetxController {
  final listItems = <ListItem>[].obs;

  Future<void> fetchPosts() async {
    final response =
        await http.get(Uri.parse('http://192.168.25.5:3000/posts'));
    if (response.statusCode == 200) {
      final List<ListItem> data = postFromJson(response.body);
      listItems.assignAll(data);
    }
  }
}
