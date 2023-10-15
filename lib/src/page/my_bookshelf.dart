import 'package:flutter/material.dart';

class MyBookShelf extends StatefulWidget {
  const MyBookShelf({super.key});

  @override
  State<MyBookShelf> createState() => _MyBookShelfState();
}

class _MyBookShelfState extends State<MyBookShelf> {
  final List<Map> booktool = [];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        child: Scaffold(
          body: GridView.count(
              primary: false,
              padding: const EdgeInsets.all(20),
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
              crossAxisCount: 2,
              childAspectRatio: 1 / 1.3,
              children: <Widget>[
                Container(
                  child: Text("11"),
                ),
              ]),
        ),
      ),
    );
  }
}
