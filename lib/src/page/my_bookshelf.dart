import 'dart:convert';
import 'package:bookscan_1/src/app.dart';
import 'package:bookscan_1/src/controller/auth_controller.dart';
import 'package:bookscan_1/src/helper/app_bar.dart';
import 'package:bookscan_1/src/page/login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../connect/server.dart';
import '../controller/book_review_controller.dart';
import '../controller/bookshelf_controller.dart';
import '../model/book_shelf_model.dart';
import 'book_report_review.dart';
import 'book_review.dart';

class MyBookShelf extends StatelessWidget {
  final String? id, qrCode;

  MyBookShelf({Key? key, this.id, this.qrCode}) : super(key: key);

  final AuthController authController = Get.find();
  final App app = App();
  final BookShelfController bookShelfController = Get.find();

  final ServerConnect _server = ServerConnect();

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
          child: RefreshIndicator(
            onRefresh: () async {
              await bookShelfController.fetchBooks();
            },
            child: Obx(() {
              if (bookShelfController.books.isNotEmpty) {
                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15,
                  ),
                  itemCount: bookShelfController.books.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () async {
                        
                        //_server.sendUserIDIsbnReport("34", "11", "");
                        final response = await _server.sendUserIDIsbnReport("34", "9791156645719", "");
                        //print(response.body.toString());
                        // //bookReviewController.hasReview.value = false; //초기화
                        //print('qrCode : $qrCode');
                        if(response.body.toString() == "독후감을 등록할 수 있습니다!") {
                            Navigator.push(context,
                              MaterialPageRoute(builder: (context) => BookReviewPage()));
                        } else if(response.body.toString() == "해당 도서에 입력된 독후감이 있습니다.") {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => BookReportReviewPage()));
                        }
                      },
                      child: _buildBookItem(bookShelfController.books[index]),
                    );
                  },
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }),
          ),
        );
      }
  }

  // Future<void> checkReviewExistence(String response) async {
  //   if (response == "입력된 독후감이 있습니다.") {
  //     // 독후감이 이미 등록되어 있음
  //     print("이미 독후감이 등록되어 있습니다.");
  //     // 여기에 독후감 조회 페이지로 이동하는 코드 추가
  //     navigateToReviewPage();
  //   } else {
  //     // 독후감이 없음
  //     print("독후감이 없습니다. 독후감 작성 페이지로 이동합니다.");
  //     // 여기에 독후감 작성 페이지로 이동하는 코드 추가
  //     navigateToWriteReviewPage();
  //   }
  // }
  
  void navigateToWriteReviewPage(BuildContext context) {
    Navigator.push(context,
                      MaterialPageRoute(builder: (context) => BookReportReviewPage()));
  }
  
  void navigateToReviewPage(BuildContext context) {
    Navigator.push(context,
                      MaterialPageRoute(builder: (context) => BookReviewPage()));
  }


  Widget _buildBookItem(Book book) {
    //  print('book_cover : ${book.book_cover}');
    //  print('book_title : ${book.book_title}');
    return Card(
      elevation: 5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            book.book_cover,
            height: 180,
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


