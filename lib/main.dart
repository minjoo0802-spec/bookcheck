import 'package:bookscan_1/src/binding/init_bindings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'src/app.dart';

void main() {
  runApp(MyApp(isLoggedIn: false,));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;

   const MyApp({Key? key, required this.isLoggedIn}) : super(key: key);

  // const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'basic_fonts',
        primarySwatch: Colors.blue,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          titleTextStyle: TextStyle(color: Colors.black),
        ),
      ),
      initialBinding: InitBinding(),
      home: App(),
      builder: (context, child) => MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
        child: child ?? Container(),
    ),);
  }
}
