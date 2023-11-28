import 'dart:convert';
import 'package:bookscan_1/src/app.dart';
import 'package:bookscan_1/src/controller/auth_controller.dart';
import 'package:bookscan_1/src/helper/app_bar.dart';
import 'package:bookscan_1/src/page/login.dart';
import 'package:bookscan_1/src/page/my_bookshelf.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../connect/server.dart';
import '../controller/book_review_controller.dart';
import '../controller/bookshelf_controller.dart';
import '../model/book_shelf_model.dart';
import 'book_report_review.dart';
import 'book_report_write.dart';
import 'my_bookshelf.dart';


late String? id, qrCode;

class MyBookShelf extends StatelessWidget {
  
  MyBookShelf({Key? key}) : super(key: key);

  final AuthController authController = Get.find();
  final App app = App();
  final BookShelfController bookShelfController = Get.find();

  //final ServerConnect _server = ServerConnect();

  final RxList<Book> books = <Book>[].obs;

  final BookReviewController bookReviewController = BookReviewController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: MainAppBar(),
      body: Obx(() {
        if (authController.isLoggedIn.value) {
          print('isLoggedIn = true');
          if (bookShelfController.books.isNotEmpty) {
            print('받은 데이터 띄우기');
            return Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('assets/images/my_bookshelf_image/bookshelf_back.avif')
                )
              ),
              child: Column(
                children: [
                  logOutBtn(),
                  myBookShelfMain(context),
                ],
              ),
            );
          } 
          else {
            //데이터가 로딩 중인 경우
            print('로딩 중...');
            bookShelfController.fetchBooks(id);
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
          child: RefreshIndicator(
            onRefresh: () async {
              await bookShelfController.fetchBooks(id);
            },
            child: Obx(() {
              if (bookShelfController.books.isNotEmpty) {
                return Padding(
                  padding: EdgeInsets.all(10),
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 15,
                      mainAxisSpacing: 15,
                      childAspectRatio: 0.65,
                    ),
                    itemCount: bookShelfController.books.length,
                    itemBuilder: (BuildContext context, int index) {
                      Book book = bookShelfController.books[index];
                      return GestureDetector(
                        onTap: () async {
                          print(book.book_report);
                            Navigator.push(context,
                              MaterialPageRoute(builder: (context) => BookReportWritePage(index: index)));
                        },
                        child: Container(
                          decoration : BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.7),
                                spreadRadius: 0,
                                blurRadius: 0,
                                offset: Offset(0, 3),
                              )
                            ]),
                          child: _buildBookItem(bookShelfController.books[index])),
                      );
                    },
                  ),
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }),
          ),
        );
      }
  }


Widget _buildBookItem(Book book) {
  int maxTitleLength = 8;

  String truncatedTitle = book.book_title.length > maxTitleLength
      ? '${book.book_title.substring(0, maxTitleLength)}...'
      : book.book_title;

  return Card(
    elevation: 0,
    child: ListView(
      scrollDirection: Axis.vertical,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10)),
          child: Image.network(
            book.book_cover,
            height: 150,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            truncatedTitle,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            maxLines: 1,
            overflow: TextOverflow.ellipsis, //초과시 ...으로 표시
          ),
        ),
      ],
    ),
  );
}


