import 'package:bookscan_1/src/app.dart';
import 'package:flutter/material.dart';

class BookInfo extends StatelessWidget {
  const BookInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        child: const Text("back"),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => const App()));
        },
      ),
    );
  }
}
