import 'package:flutter/material.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  Widget _backButton(BuildContext context) {
    return Container(
      child: FloatingActionButton.small(
        child: const Text("<<"),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FlutterLogo(size: 100),
              SizedBox(height: 20),
              SignupTextField(label: '이메일'),
              SizedBox(height: 20),
              SignupTextField(label: '비밀번호', obscureText: true),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // 회원가입 기능
                },
                child: Text('회원가입'),
              ),
              _backButton(context),
            ],
          ),
        ),
      ),
    );
  }
}

class SignupTextField extends StatelessWidget {
  final String label;
  final bool obscureText;

  SignupTextField({required this.label, this.obscureText = false});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(labelText: label),
      obscureText: obscureText,
    );
  }
}