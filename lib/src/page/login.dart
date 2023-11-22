import 'package:bookscan_1/src/app.dart';
import 'package:bookscan_1/src/controller/auth_controller.dart';
import 'package:bookscan_1/src/helper/app_bar.dart';
import 'package:bookscan_1/src/helper/login_background.dart';
import 'package:bookscan_1/src/page/book_info.dart';
import 'package:bookscan_1/src/page/my_bookshelf.dart' as mybookshelf;
import 'package:bookscan_1/src/page/signup.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../connect/server.dart';
import '../controller/bookshelf_controller.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key, this.id, this.qrCode});

  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();
  final GlobalKey _stackKey = GlobalKey();
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();
  final BookShelfController bookShelfController = Get.find();
  

  App app = App();

  final ServerConnect _server = ServerConnect();
  final String? id;
  final String? qrCode;

  //final BookShelfController bookShelfController = Get.find();

  @override
  Widget build(BuildContext context) {
    Get.put(AuthController());
    final Size size = MediaQuery.of(context).size;

    final arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;

    Widget _authButton(Size size) {
      final AuthController authController = Get.find();
      return Positioned(
        left: size.width * 0.15,
        right: size.width * 0.1,
        bottom: 0,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              backgroundColor: Color.fromRGBO(255, 220, 210, 1)),
          onPressed: (() async {
            // ignore: unrelated_type_equality_checks
            if (_loginFormKey.currentState!.validate() != 0) {
              final response = await _server.sendLoginData(
                  _idController.text, _pwController.text);
              if (response.body.toString() == "로그인에 성공하였습니다.") {
                print('로그인 성공');
                if (arguments?['name'] == "BookInfo -> Login") {
                  // ignore: use_build_context_synchronously
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            BookInfo(id: _idController.text, qrCode: qrCode),
                      ));
                  mybookshelf.id = _idController.text;
                  mybookshelf.qrCode = qrCode;
                  //bookShelfController.fetchBooks();
                  _server.sendUserData(_idController.text, qrCode);
                  // ignore: use_build_context_synchronously
                  authController.login();
                  print('11');
                  bookShelfController.fetchBooks(_idController.text, qrCode);
                  print('22');
                  app.controller.pageIndex.value = 3;
                }
              } else if (response.body.toString() == "로그인 정보가 일치하지 않습니다.") {
                print('로그인 실패');
              } else {
                print('오류 발생');
              }
            }
          }),
          child: Text(
            "로그인",
            style: TextStyle(color: const Color.fromARGB(255, 71, 71, 71)),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: PageAppBar(),
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          CustomPaint(
            size: size,
            painter: LoginBackground(),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              //_logoImage,
              Stack(
                key: _stackKey,
                children: <Widget>[
                  _inputForm(size),
                  _authButton(size),
                ],
              ),
              Container(
                height: size.height * 0.1,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SignUpPage()));
                },
                child: const Text(
                  "계정이 없으시다면, 여기를 클릭해주세요.",
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              Container(
                height: size.height * 0.05,
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _inputForm(Size size) {
    return Padding(
      padding: EdgeInsets.all(size.width * 0.05),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 6,
        child: Padding(
          padding:
              const EdgeInsets.only(left: 12, right: 12, top: 12, bottom: 32),
          child: Form(
              
              key: _loginFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextFormField(
                    controller: _idController,
                    decoration: const InputDecoration(
                        icon: Icon(Icons.account_circle), labelText: "아이디"),
                    validator: (value) {
                      if (value!.length < 1) return 'Please input correct ID.';
                      // if (value == null) {
                      //   return "Please input correct ID.";
                      // }
                      return value;
                    },
                  ),
                  TextFormField(
                    obscureText: true,
                    controller: _pwController,
                    decoration: const InputDecoration(
                        icon: Icon(Icons.vpn_key), labelText: "비밀번호"),
                    validator: (value) {
                      if (value!.length < 1) return 'Please input correct PW.';
                      // if (value == null) {
                      //   return "Please input correct PW.";
                      // }
                      return null;
                    },
                  ),
                  Container(
                    height: 8,
                  ),
                  Padding(
                      padding: const EdgeInsets.only(top: 5, left: 40),
                      child: Text(
                        "Forgot Password",
                        style: TextStyle(color: Colors.grey),
                      )),
                ],
              )),
        ),
      ),
    );
  }
}
