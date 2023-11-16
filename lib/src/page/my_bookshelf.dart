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
            print('받은 데이터 띄우기');
            return Column(
              children: [
                logOutBtn(),
                myBookShelfMain(context),
              ],
            );
          } 
          else {
            //데이터가 로딩 중인 경우
            print('로딩 중...');
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
    return Expanded(
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 15,
          mainAxisSpacing: 15,
        ),
        itemCount: books.length,
        itemBuilder: (BuildContext context, int index) {
          return _buildBookItem(books[index]);
        },
      ),
    );
  }

  Widget _buildBookItem(Book book) {
    print('book_cover : ${book.book_cover}');
    print('book_title : ${book.book_title}');
    return Card(
      elevation: 5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            book.book_cover,
            // "https://image.aladin.co.kr/product/28642/70/cover/k152835653_1.jpg",
            height: 170,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              book.book_title,
              //"11",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
    
  }
  
  
}

