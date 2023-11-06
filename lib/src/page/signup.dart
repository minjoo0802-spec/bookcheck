import 'package:bookscan_1/src/helper/login_background.dart';
import 'package:bookscan_1/src/page/login.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();

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
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            backgroundColor: Color.fromRGBO(255, 220, 210, 1)),
        onPressed: (() {
          if (_formKey.currentState!.validate() != 0) {
            // print(_idController.text.toString());
            Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginPage()));
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
                key: _formKey,
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
              // _formKey를 통해 변한 상태를 가져올 수 있음
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextFormField(
                    controller: _idController,
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
