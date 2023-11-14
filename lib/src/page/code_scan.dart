import 'package:bookscan_1/src/helper/app_bar.dart';
import 'package:bookscan_1/src/page/book_info.dart';
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

  // _qrCallback(String? code) {
  //   setState(() {
  //     //_camState = false;
  //     _qrInfo = code; // code => isbn
  //     //_server.sendData(code);
  //   });
  //     Navigator.push(
  //     context,
  //     MaterialPageRoute(builder: (context) => BookInfo()),
  //   );
  // }

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
                          MaterialPageRoute(builder: (context) => BookInfo(qrCode: code)),
                        );
                      }
                    },
                  ),
                ),
                SizedBox(height: 20,),
                Container(child: Text('책의 바코드를 스캔해주세요 !', style: TextStyle(fontSize: 15),),
                )
              ],
            )
          
            : Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Center(
                child: Text('다른 책을 스캔하고 싶으시면 아래 버튼을 클릭해주세요.',
                style: TextStyle(fontSize: 15),),
            
              ),
            )
          ),
          SizedBox(height: 20,),
          if(_qrInfo != null)
          // Center(child: Text('Scanned QR/Bar code : $_qrInfo',
          // style: TextStyle(fontSize: 20),),),
          // SizedBox(height: 20,),
          ElevatedButton(onPressed: () {
            setState(() {
              _qrInfo = null;
              _scanCode();
            });
          }, child: Text('Scan Again'),),
        ]),
      ),
    );
  }
}