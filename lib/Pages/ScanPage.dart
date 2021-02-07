import 'package:flutter/material.dart';
import 'package:ovenapp/BusinessObjects/ScanBO.dart';
import 'package:ovenapp/Classes/AppToast.dart';
import 'package:ovenapp/Models/ControlPanelModel.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import '../Classes/AppToast.dart';

class ScanPage extends StatefulWidget {
  @override
  _ScanPageState createState() => new _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  final TextEditingController qrcodeController =
      TextEditingController(text: "");

  final int sc = 5;

  // final cpd=ControlPanelDataModel();

  @override
  void initState() {
    super.initState();

    print("@@@ => ScanPage.initState()");
    // ScanBO.scanQB();
  }

// class MyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("@@@ => ScanPage.build() ... ");

    return new Scaffold(
        body: new SafeArea(
      child: new Column(children: <Widget>[
        new RaisedButton(
          child: new Text('扫描'),
          onPressed: () async {
            String cameraScanResult = await scanner.scan();
            print("@@@ qrcode => " + cameraScanResult);
            AppToast.showToast(cameraScanResult, 2);
            qrcodeController.text = cameraScanResult;
          },
        ),
        // new TextField(
        //   controller: qrcodeController,
        //   enableInteractiveSelection: false,
        //   enabled: false,
        //   decoration: InputDecoration(
        //     contentPadding: const EdgeInsets.symmetric(vertical: 10.0),
        //   ),
        // ),
       
      ]),
    ));
  }
}