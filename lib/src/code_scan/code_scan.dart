import 'package:bookscan_1/src/page/book_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_qr_bar_scanner/qr_bar_scanner_camera.dart';

class CodeScan extends StatefulWidget {
  const CodeScan({super.key});

  @override
  State<CodeScan> createState() => _CodeScanState();
}

class _CodeScanState extends State<CodeScan> {
  String? _qrInfo = 'Scan a QR/Bar code';
  bool _camState = false;

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
      _qrInfo = code;
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

  Widget InfoButton() {
    return Container(
      child: FloatingActionButton.small(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const BookInfo()));
        },
        child: Icon(Icons.add),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Column(children: <Widget>[
          Search(),
          Camera(),
          InfoMessage(),
          InfoButton(),
        ]),
      ),
    );
  }
}
