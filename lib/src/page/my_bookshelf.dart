import 'dart:convert';
import 'package:bookscan_1/src/app.dart';
import 'package:bookscan_1/src/controller/auth_controller.dart';
import 'package:bookscan_1/src/helper/app_bar.dart';
import 'package:bookscan_1/src/page/login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../controller/bookshelf_controller.dart';
import '../model/book_shelf_model.dart';

class MyBookShelf extends StatelessWidget {
  final String? id, qrCode;

  MyBookShelf({Key? key, this.id, this.qrCode}) : super(key: key);

  final AuthController authController = Get.find();
  final App app = App();
  final BookShelfController bookShelfController = Get.find();

  final RxList<Book> books = <Book>[].obs;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(),
      body: Obx(() {
        if (authController.isLoggedIn.value) {
          print('isLoggedIn = true');
          if (bookShelfController.books.isNotEmpty) {
            print('1');
            return Column(
              children: [
                logOutBtn(),
                Expanded(child: myBookShelfMain(context)),
              ],
            );
          } 
          else {
            //데이터가 로딩 중인 경우
            print('2');
            bookShelfController.fetchBooks();
            return Center(child: CircularProgressIndicator());
            
          }
        } else {
          print('isLoggedIn = false');
          return Stack(
            children: [
              dialogMs(),
            ],
          );
        }
      }),
    );
  }

  Widget logOutBtn() {
    return SizedBox(
      height: 40,
      width: 100,
      child: TextButton(
        child: Text('로그아웃'),
        onPressed: () {
          authController.logout();
          showDialog(
            context: Get.overlayContext!,
            builder: (context) => StatefulBuilder(
              builder: ((context, setState) => AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(32.0)),
                ),
                contentPadding: EdgeInsets.only(top: 0),
                content: Text('로그아웃되었습니다.'),
              )),
            ),
          );
        },
      ),
    );
  }

  Widget dialogMs() {
    return AlertDialog(
      content: Text('로그인이 필요한 서비스입니다. \n 로그인 하시겠습니까?'),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            app.controller.pageIndex.value = 0;
          },
          child: Text('닫기'),
        ),
      ],
    );
  }

  Widget myBookShelfMain(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 15,
        mainAxisSpacing: 15,
      ),
      itemCount: books.length,
      itemBuilder: (BuildContext context, int index) {
        return _buildBookItem(books[index]);
      },
    );
  }

  Widget _buildBookItem(Book book) {
    return Card(
      elevation: 5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            book.book_cover,
            height: 170,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              book.book_title,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  // Future<void> fetchBooks() async {
  //   try {
  //     final response = await http.get(Uri.parse("http://10.101.97.210:3000/shelfbooks"));
  //     if (response.statusCode == 200) {
  //       final List<dynamic> data = json.decode(response.body);

  //       // 가공된 도서 목록을 저장할 리스트
  //       List<Book> processedBooks = [];

  //       // 데이터를 가공
  //       for (var item in data) {
  //         if (item is Map<String, dynamic>) {
  //           // 필요한 정보 추출
  //           String bookTitle = item['book_title'] ?? '';
  //           String bookCover = item['book_cover'] ?? '';

  //           // Book 객체로 변환 후 리스트에 추가
  //           processedBooks.add(Book(book_cover: bookCover, book_title: bookTitle));
  //         }
  //       }
  //       // 가공된 도서 목록을 Observable 리스트에 할당
  //       books.assignAll(processedBooks);
  //       print('책정보받음');
  //     } else {
  //       throw Exception('서버 응답이 200이 아닙니다. 상태 코드: ${response.statusCode}');
  //     }
  //   } catch (error) {
  //     print('데이터 가져오기 실패: $error');
  //   }
  // }
}

