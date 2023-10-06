import 'package:flutter/material.dart';

class Shop extends StatelessWidget {
  const Shop({super.key});

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
                childAspectRatio: 1 / 1.5,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
              ),
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  color: Colors.black12,
                  child: Text('11'),
                );
              }),
        ),
      ),
    );
  }
}

class PhotoItem {
  final String image;
  final String name;
  PhotoItem(this.image, this.name);
}
