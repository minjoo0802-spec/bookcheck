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
              crossAxisCount: 3,
              childAspectRatio: 1 / 1.7,
              children: <Widget>[
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
                          child: Text("sample1"),
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
                          child: Text("sample1"),
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
                          child: Text("sample1"),
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
}
