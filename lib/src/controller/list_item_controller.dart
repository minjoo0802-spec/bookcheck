import 'package:bookscan_1/src/model/list_item_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;


class ListItemController extends GetxController {
  final listItems = <ListItem>[].obs;

  Future<void> fetchPosts() async {
    final response =
        await http.get(Uri.parse("http://10.101.97.210:3000"));
    if (response.statusCode == 200) {
      final List<ListItem> data = postFromJson(response.body);
      listItems.assignAll(data);
    }
  }
}
