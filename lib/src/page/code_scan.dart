import 'package:bookscan_1/src/helper/app_bar.dart';
import 'package:bookscan_1/src/page/book_info.dart';
import 'package:bookscan_1/src/page/book_report_write.dart';
import 'package:flutter/material.dart';
import 'package:flutter_qr_bar_scanner/qr_bar_scanner_camera.dart';

import '../connect/server.dart';

class CodeScan extends StatefulWidget {
  const CodeScan({super.key});

  @override
  State<CodeScan> createState() => _CodeScanState();
}

class _CodeScanState extends State<CodeScan> {
  final ServerConnect _server = ServerConnect();

  String? _qrInfo = 'Scan a QR/Bar code';
  bool _camState = false;

  TextEditingController searchTextEditingController = TextEditingController();

  emptyTheTextFormField() {
    searchTextEditingController.clear();
  }

  controlSearching(str) {
    print(str);
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

  Widget btn1() {
    return ElevatedButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => BookReportWritePage(
                        index: 0,
                      )));
        },
        child: Text("독후감 작성 페이지"));
  }

  // Widget btn2() {
  //   return ElevatedButton(
  //     onPressed: () {
  //       Navigator.push(context,
  //         MaterialPageRoute(builder: (context) => BookReportReviewPage()));
  //     },
  //     child: Text("독후감 작성 페이지"));
  // }

  Widget Search() {
    return TextFormField(
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
    );
  }

  @override
  Widget build(BuildContext context) {
    final arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;

    return Scaffold(
      appBar: MainAppBar(),
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Column(children: <Widget>[
          Search(),
          Center(
              child: _camState
                  ? Column(
                      children: [
                        SizedBox(
                          height: 450,
                          width: 500,
                          child: QRBarScannerCamera(
                            onError: (context, error) => Text(
                              error.toString(),
                              style: TextStyle(color: Colors.red),
                            ),
                            qrCodeCallback: (code) {
                              if (_camState) {
                                _qrInfo = code;
                                print(code);
                                _server.sendBookData(code);
                                setState(() {
                                  _camState = false;
                                });
                                // + 서버에 데이터 요청
                                // + 서버에서 받은 데이터 전달
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => BookInfo(
                                          id: arguments?['id'], qrCode: code!)),
                                );
                                //print('id : ${arguments?['id']}');
                              }
                            },
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          child: Text(
                            '책의 바코드를 스캔해주세요 !',
                            style: TextStyle(fontSize: 15),
                          ),
                        )
                      ],
                    )
                  : Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Center(
                        child: Text(
                          '다른 책을 스캔하고 싶으시면 아래 버튼을 클릭해주세요.',
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                    )),
          SizedBox(
            height: 20,
          ),
          if (_qrInfo != null)
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _qrInfo = null;
                  _scanCode();
                });
              },
              child: Text('Scan Again'),
            ),
          btn1(),
          //btn2(),
        ]),
      ),
    );
  }
}
