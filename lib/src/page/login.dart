import 'dart:convert';
import 'package:bookscan_1/src/app.dart';
import 'package:bookscan_1/src/controller/auth_controller.dart';
import 'package:bookscan_1/src/helper/app_bar.dart';
import 'package:bookscan_1/src/helper/login_background.dart';
import 'package:bookscan_1/src/page/code_scan.dart';
import 'package:bookscan_1/src/page/signup.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();

  App app = App();

  late final bool isLoggedIn;

  final String _url = "http://10.101.97.210:3000"; // 현서꺼

  @override
  Widget build(BuildContext context) {
    Get.put(AuthController());
    final Size size = MediaQuery.of(context).size;


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
              final response = await sendLoginData(_idController.text, _pwController.text);
              if(response.body.toString() == "로그인에 성공하였습니다.") {
                print('로그인 성공');
                SharedPreferences prefs = await SharedPreferences.getInstance();
                await prefs.setString('token', 'user_token_here');
                // ignore: use_build_context_synchronously
                Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => CodeScan()));
                authController.login();
                app.controller.pageIndex.value = 3;
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
                key: _loginFormKey,
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
              // _loginFormKey를 통해 변한 상태를 가져올 수 있음
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

  Widget get _logoImage {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(top: 100, left: 70, right: 70),
        child: FittedBox(
          fit: BoxFit.contain,
          child: Text(""),
        ),
      ),
    );
  }
}