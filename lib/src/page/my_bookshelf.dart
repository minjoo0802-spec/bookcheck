import 'package:bookscan_1/src/app.dart';
import 'package:bookscan_1/src/controller/auth_controller.dart';
import 'package:bookscan_1/src/helper/app_bar.dart';
import 'package:bookscan_1/src/page/book_report_review.dart';
import 'package:bookscan_1/src/page/book_review.dart';
import 'package:bookscan_1/src/page/code_scan.dart';
import 'package:bookscan_1/src/page/login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class MyBookShelf extends StatefulWidget {
  
  const MyBookShelf({Key? key}) : super(key: key);
  

  @override
  State<MyBookShelf> createState() => _MyBookShelfState();
  
}

class _MyBookShelfState extends State<MyBookShelf> {
  
  //final AuthController authController = Get.put(AuthController());
  final AuthController authController = Get.find();

  final List<Map> booktool = [];
  
  App app = App();

  Widget loginbtn() {
    
    return TextButton(
      onPressed: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => LoginPage()));
        Get.to(LoginPage());
    }, 
    child: Text('로그인하기'));
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
            context: context, 
            builder: (context) => StatefulBuilder(
              builder: ((context, setState) => 
              AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(32.0)), 
                ),
                contentPadding: EdgeInsets.only(top: 0),
                content: Text('로그아웃되었습니다.'),
              ))));
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
          Navigator.push(context,
            MaterialPageRoute(builder: (context) => LoginPage(),
            settings: RouteSettings(arguments: "MyBookShelf -> Login")));
        },
        child: Text('로그인')),
      TextButton(
        onPressed: () {
          app.controller.pageIndex.value = 0;
          // Navigator.push(context, 
          //   MaterialPageRoute(builder: (context) => CodeScan()));
        }, 
        child: Text('닫기')),
      ],
    );
  }

  Widget bookshelfSample() {
    return SizedBox(
      height: 500,
      width: 500,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        child: Scaffold(
          body: GridView.count(
              primary: false,
              padding: const EdgeInsets.all(20),
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
              crossAxisCount: 3,
              childAspectRatio: 1 / 1.7,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BookReviewPage()));
                  },
                  child: Container(
                    decoration: BoxDecoration(
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
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10)),
                          child: Image(
                            image: AssetImage(
                                'assets/images/my_bookshelf_image/book_sample.jpg'),
                            fit: BoxFit.fill,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 6),
                          child: Text("sample1"),
                        )
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    showDialog(context: context, builder: (context) {
                      return Dialog(child: BookReportReviewPage());
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
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
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10)),
                          child: Image(
                            image: AssetImage(
                                'assets/images/my_bookshelf_image/book_sample.jpg'),
                            fit: BoxFit.fill,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 6),
                          child: Text("sample2"),
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  child: Container(
                    decoration: BoxDecoration(
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
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10)),
                          child: Image(
                            image: AssetImage(
                                'assets/images/my_bookshelf_image/book_sample.jpg'),
                            fit: BoxFit.fill,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 6),
                          child: Text("sample3"),
                        )
                      ],
                    ),
                  ),
                ),
              ]),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    //Get.put(AuthController());
    return Scaffold(
      appBar: MainAppBar(),
      body: Obx(() {
        if(authController.isLoggedIn.value) {
          print('isLoggedIn = ture');
          return Column(
            children: [
              logOutBtn(),
              bookshelfSample(),
            ],
          );
        } else {
          print('isLoggedIn = false');
          return Stack(
            children: [
              //loginbtn(),
              dialogMs(),]);
         }
      }),
    );    
  }
}
