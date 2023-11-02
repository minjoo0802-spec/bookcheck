import 'dart:convert';
import 'dart:io';

import 'package:bookscan_1/src/page/book_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_qr_bar_scanner/qr_bar_scanner_camera.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class CodeScan extends StatefulWidget {
  const CodeScan({super.key});

  @override
  State<CodeScan> createState() => _CodeScanState();
}

class _CodeScanState extends State<CodeScan> {
  String? _qrInfo = 'Scan a QR/Bar code';
  bool _camState = false;

  final String _url = "http://192.168.25.5:3000";

  String isbn = "11";

  TextEditingController searchTextEditingController = TextEditingController();

  emptyTheTextFormField() {
    searchTextEditingController.clear();
  }

  controlSearching(str) {
    print(str);
  }

  _qrCallback(String? code) {
    setState(() {
      _camState = false;
      _qrInfo = code; // code => isbn
    });
  }

  _scanCode() {
    setState(() {
      _camState = true;
    });
  }

  @override
  void initState() {
    super.initState();
    _scanCode();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> sendData(String? data) async {
    try {
      final Map<String, dynamic> requestData = {
        'data': data,
      };
      final response = await http.post(
        Uri.parse("$_url/post"),
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

  Widget Camera() {
    return Container(
      child: _camState
          ? Center(
              child: SizedBox(
                height: 450,
                width: 500,
                child: QRBarScannerCamera(
                  onError: (context, error) => Text(
                    error.toString(),
                    style: TextStyle(color: Colors.red),
                  ),
                  qrCodeCallback: (code) {
                    _qrCallback(code);
                    print(code);
                    sendData(code);
                  },
                ),
              ),
            )
          : Center(
              child: Text(_qrInfo ?? ''),
            ),
    );
  }

  Widget Search() {
    return Container(
        child: TextFormField(
      controller: searchTextEditingController,
      decoration: InputDecoration(
        hintText: 'Search hear',
        hintStyle: TextStyle(
          color: Colors.grey,
        ),
        prefixIcon: Icon(Icons.search_rounded, color: Colors.black, size: 30),
        suffixIcon: IconButton(
          icon: Icon(
            Icons.clear,
            color: Colors.black,
          ),
          onPressed: emptyTheTextFormField,
        ),
      ),
      onFieldSubmitted: controlSearching,
    ));
  }

  Widget InfoMessage() {
    return Container(
      padding: EdgeInsets.only(top: 15),
      child: Text(
        "책의 바코드 또는 QR 코드를 스캔해주세요 !",
        style: TextStyle(fontSize: 20),
      ),
    );
  }

  Widget InfoMessage1() {
    return Container(
      padding: EdgeInsets.only(top: 15),
      child: Text(
        "22",
        style: TextStyle(fontSize: 20),
      ),
    );
  }

  // bool extended = false;

  // FloatingActionButton extendedButton() {
  //   return FloatingActionButton.extended(
  //     onPressed: () {},
  //     label: const Text("Click"),
  //     isExtended: extended,
  //     icon: const Icon(
  //       Icons.add,
  //       size: 30,
  //     ),
  //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
  //   );
  // }

  Widget InfoButton(BuildContext context) {
    return Container(
      child: FloatingActionButton.small(
        onPressed: () async {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => BookInfo()));
          // Navigator.push(
          // Get.to(const BookInfo());
          //     context, MaterialPageRoute(builder: (context) => BookInfo()));
          // http.Response _res = await http.get(Uri.parse("$_url/"));
          // print(_res.body);
          // setState(() {
          //   _text = _res.body;
          // });
        },
        child: Icon(Icons.add),
      ),
    );
  }

  // void _getRequest() async {
  //   http.Response _res = await http.get("$_url/");
  //   print(_res.body);
  //   setState(() {
  //     _text = _res.body;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Column(children: <Widget>[
          Search(),
          Camera(),
          InfoMessage(),
          InfoButton(context),
        ]),
      ),
    );
  }
}
