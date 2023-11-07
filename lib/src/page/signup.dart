import 'dart:convert';

import 'package:bookscan_1/src/helper/app_bar.dart';
import 'package:bookscan_1/src/helper/login_background.dart';
import 'package:bookscan_1/src/page/login.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SignUpPage extends StatelessWidget {
  SignUpPage({super.key});

  final GlobalKey<FormState> _signUpFormKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();
  final TextEditingController _confirmPwController = TextEditingController();

  final String _url = "http://10.101.97.210:3000";

  // String userName = '';
  // String userEmail = '';
  //String userPw = '';

// context => 앱이 돌아가는 정보
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    Widget _authButton(Size size) {
      return Positioned(
        left: size.width * 0.15,
        right: size.width * 0.1,
        bottom: 0,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              backgroundColor: Color.fromRGBO(255, 220, 210, 1)),
          onPressed: (() {
            if (_signUpFormKey.currentState!.validate() != 0) {
              // print(_idController.text.toString());
              if (_pwController.text == _confirmPwController.text) {
                print("비밀번호 같음");
                sendLoginData(_nameController.text, _idController.text,
                    _pwController.text);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginPage()));
              } else {
                print("비밀번호 다름");
              }
            }
          }),
          child: Text(
            "회원가입",
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
                key: _signUpFormKey,
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
                      MaterialPageRoute(builder: (context) => LoginPage()));
                },
                child: const Text(
                  "로그인 화면으로 돌아가기",
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

  Future<void> sendLoginData(String? name, String? id, String? pw) async {
    try {
      final Map<String, dynamic> requestData = {
        'name': name,
        'id': id,
        'pw': pw,
      };
      final response = await http.post(
        Uri.parse("$_url/register"),
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
              // _signUpFormKey를 통해 변한 상태를 가져올 수 있음
              key: _signUpFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                        icon: Icon(Icons.account_circle), labelText: "이름"),
                    validator: (value) {
                      if (value!.length < 1) return 'Please input correct ID.';
                      // if (value == null) {
                      //   return "Please input correct ID.";
                      // }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _idController,
                    decoration: const InputDecoration(
                        icon: Icon(Icons.account_circle), labelText: "아이디"),
                    validator: (value) {
                      if (value!.length < 1) return 'Please input correct ID.';
                      // if (value == null) {
                      //   return "Please input correct ID.";
                      // }
                      return null;
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
                  TextFormField(
                    obscureText: true,
                    controller: _confirmPwController,
                    decoration: const InputDecoration(
                        icon: Icon(Icons.vpn_key), labelText: "비밀번호 확인"),
                    validator: (value) {
                      if (value!.length < 1) return 'Please input correct PW.';
                      if (value != _pwController.text)
                        return '비밀번호가 일치하지 않습니다.';
                      // if (value == null) {
                      //   return "Please input correct PW.";
                      // }
                      return null;
                    },
                  ),
                  Container(
                    height: 8,
                  ),
                  // Padding(
                  //     padding: const EdgeInsets.only(top: 5, left: 40),
                  //     child: Text(
                  //       "Forgot Password",
                  //       style: TextStyle(color: Colors.grey),
                  //     )),
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

  // Widget get DrawerUpDown {
  //   return Drawer(
  //     child: ListView(
  //       children: <Widget>[
  //         UserAccountsDrawerHeader(
  //           accountName: Text('MinJoo'),
  //           accountEmail: Text('drgdrgdrg@naver.com')),
  //       ],
  //     ),
  //   );
  // }
}
