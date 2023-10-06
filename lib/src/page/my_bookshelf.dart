import 'package:flutter/material.dart';

class MyBookShelf extends StatefulWidget {
  const MyBookShelf({super.key});

  @override
  State<MyBookShelf> createState() => _MyBookShelfState();
}

class _MyBookShelfState extends State<MyBookShelf> {

  final List<Map> booktool = [
    
  ];


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        child: Scaffold(
          body: GridView.builder(
            itemCount: 12,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 1 /1.5,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,), 
            itemBuilder: (BuildContext context, int index) {
            return Container(
              color: Colors.black12,
              child: Text('Item : $index'),
            );
          }),
        ),
      ),
    );
  }
}