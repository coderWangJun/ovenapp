import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ovenapp/Classes/AppDialog.dart';

import 'package:wifi_configuration/wifi_configuration.dart';
import 'package:wifi/wifi.dart';

import 'package:ovenapp/BusinessObjects/DialogBO.dart';
import 'package:ovenapp/Classes/AppToast.dart';
import 'package:ovenapp/Classes/SharePrefHelper.dart';
// import 'package:ovenapp/Classes/SharePrefHelper.dart';
import 'package:ovenapp/Classes/SocketClass.dart';
import 'package:ovenapp/Publics/AppStyle.dart';
import 'package:ovenapp/Publics/GlobalVar.dart';
import 'package:ovenapp/Services/EventBusSrv.dart';
// import 'package:qrscan/qrscan.dart' as scanner;
// import 'package:protobuf/protobuf.dart';
// import 'dart:io';
// import 'dart:async';

// import '../Classes/SocketHelper.dart';
import '../Classes/AppToast.dart';

class WifiPage extends StatefulWidget {
  WifiPage({Key key, this.uuid}) : super(key: key);
  final String uuid;

  @override
  _WifiPageState createState() => new _WifiPageState();
}

class _WifiPageState extends State<WifiPage> {
  // final TextEditingController qrcodeController =
  //     TextEditingController(text: "");

  final TextEditingController ssidController = TextEditingController(
      text: GlobalVar.wifissid); //chenkexin  GlobalVar.wifissid

  final TextEditingController pwdController = TextEditingController(
      text: GlobalVar.wifipwd); //13437183248  GlobalVar.wifipwd

  final int sc = 5;
// "05DAFF33-31365950-43187617";
  @override
  void initState() {
    super.initState();
    devicessid = widget.uuid.replaceAll('/', '');
    devicessid = devicessid.substring(0, 8) +
        '-' +
        devicessid.substring(8, 16) +
        '-' +
        devicessid.substring(16);

    // await _getWifi();
    print("@@@ => WifiPage.initState() ... $devicessid");
  }

  Color clTitle = Colors.grey;
  Color clText = Colors.black87;
  double dCardElevation = 2.2;
  String devicessid;
// class MyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("@@@ => WifiPage.build() ... ");

    return new Scaffold(
        appBar: AppBar(
          title: Text('初始化 WIFI 设置'), //'设置WIFI => 设备：' + devicessid
          backgroundColor: AppStyle.clTitleBC,
          actions: <Widget>[
            // PopupMenuButton(
            //   itemBuilder: (BuildContext context) {
            //     return <PopupMenuItem<String>>[
            //       PopupMenuItem(
            //         child: Text("一键设置 #1"),
            //         value: "0",
            //       ),
            //       PopupMenuItem(
            //         child: Text("一键设置 #2"),
            //         value: "1",
            //       ),
            //        PopupMenuItem(
            //         child: Text("显示 wifi 列表"),
            //         value: "2",
            //       ),
            //     ];
            //   },
            //   // icon: new Icon(
            //   //     Icons.,
            //   //     color: Colors.white
            //   // ),
            //   onSelected: (String selected) {
            //     // print("选择的：" + selected);
            //     if (selected == "0") _newallinone();
            //     if (selected == "1") _allinone();
            //     if (selected == "2") _getWifiList('');
            //   },
            // ),
          ],
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.all(10.0),
              child: Column(children: <Widget>[
                // Container(
                //   child: Text(
                //       '请将设备恢复至出厂模式，操作如下：在关机状态下先按着右下角P键3秒，然后松下P键，将从下至上的三行内容分别设为 77,77,1，然后按一下P键，此时设备处于出厂模式。'),
                // ),

                Container(
                  width: double.infinity,
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.only(
                    bottom: 8.0,
                    left: 5.0,
                  ),
                  child: Text(
                    '设备ID：',
                    style: TextStyle(fontSize: 18.0, color: clTitle),
                    textAlign: TextAlign.left,
                  ),
                ),
                Card(
                  margin: EdgeInsets.only(bottom: 10.0),
                  elevation: dCardElevation,
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.only(
                      left: 10.0,
                      right: 10.0,
                      top: 12.0,
                      bottom: 12.0,
                    ),
                    child: Text(
                      devicessid,
                      style: TextStyle(fontSize: 20.0, color: clText),
                    ),
                  ),
                ),

                Container(
                  width: double.infinity,
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.only(
                    bottom: 8.0,
                    left: 5.0,
                  ),
                  child: Text(
                    'SSID：',
                    style: TextStyle(fontSize: 18.0, color: clTitle),
                    textAlign: TextAlign.left,
                  ),
                ),
                Card(
                  margin: EdgeInsets.only(bottom: 10.0),
                  elevation: dCardElevation,
                  child: CupertinoTextField(
                    padding: const EdgeInsets.only(
                      left: 10.0,
                      right: 10.0,
                      top: 12.0,
                      bottom: 12.0,
                    ),
                    // autofocus: true,
                    controller: ssidController,
                    // keyboardType: TextInputType.number,
                    maxLength: 50,
                    style: TextStyle(
                      color: clText,
                      fontSize: AppStyle.dTitleText + 3.0,
                      // fontWeight: FontWeight.bold,
                    ),
                    // textAlign: TextAlign.right,
                  ),
                ),
                Container(
                  width: double.infinity,
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.only(
                    bottom: 8.0,
                    // top: 10.0,
                    left: 5.0,
                  ),
                  child: Text(
                    '密码：',
                    style: TextStyle(fontSize: 18.0, color: clTitle),
                    textAlign: TextAlign.left,
                  ),
                ),
                Card(
                  margin: EdgeInsets.only(bottom: 10.0),
                  elevation: dCardElevation,
                  child: CupertinoTextField(
                    // maxLines: 1,
                    padding: const EdgeInsets.only(
                      left: 10.0,
                      right: 10.0,
                      top: 12.0,
                      bottom: 12.0,
                    ),
                    // autofocus: true,
                    controller: pwdController,
                    // keyboardType: TextInputType.number,
                    maxLength: 50,
                    style: TextStyle(
                      color: clText,
                      fontSize: AppStyle.dEditText + 3.0,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),

                // _getLoginButton(
                //     context, 'connect', '设置 wifi 设置', Colors.blueAccent),
                // Row(
                //   children: <Widget>[
                //     Expanded(
                //       flex: 20,
                //       child: _getLoginButton(
                //           context, 'newall', '一键设置', Colors.teal),
                //     ),
                //     SizedBox(
                //       width: 5.0,
                //     ),
                //     Expanded(
                //       flex: 10,
                //       child: _getLoginButton(
                //           context, 'newconnect', '连接', Colors.teal[300]),
                //     ),
                //     SizedBox(
                //       width: 5.0,
                //     ),
                //     Expanded(
                //       flex: 10,
                //       child: _getLoginButton(
                //           context, 'newset', '设置', Colors.teal[200]),
                //     ),
                //   ],
                // ),

                // Row(
                //   children: <Widget>[
                //     Expanded(
                //       flex: 20,
                //       child:
                //           _getLoginButton(context, 'all', '一键设置', Colors.blue),
                //     ),
                //     SizedBox(
                //       width: 5.0,
                //     ),
                //     Expanded(
                //       flex: 10,
                //       child: _getLoginButton(
                //           context, 'connect', '连接', Colors.blue[300]),
                //     ),
                //     SizedBox(
                //       width: 5.0,
                //     ),
                //     Expanded(
                //       flex: 10,
                //       child: _getLoginButton(
                //           context, 'set', '设置', Colors.blue[200]),
                //     ),
                //   ],
                // ),
                // // _getLoginButton(context, 'wific', '连接 - 设置', Colors.tealAccent),

                // _getLoginButton(
                //     context, 'wifilist', 'wifi列表', Colors.redAccent),
                _getLoginButton(context, 'set', '设置', Colors.blueAccent),
                // _getLoginButton(context, 'exit', '退 出', Colors.redAccent),

                Container(
                  margin: EdgeInsets.only(top: 12.0),
                  child: Text(
                    '说明：此操作要求您的设备处于出厂模式状态；\n操作如下：\n1.在关机状态下长按电源键，当设备第五行显示变为88或听到滴滴的响声时松开按键，此时设备已处于出厂模式；\n2.手工设置手机wifi连接至设备上；\n3.确定手机已经稳定连接上设备后点击设置按钮，等待设置结果；\n注：设置过程中您的手机将会断网，设置完成后会自动恢复。请耐心等待！\n如果一次设置不成功，请多试几次；',
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.red,
                    ),
                  ),
                ),

//                 Row(
//                   children: <Widget>[
//                     new RaisedButton(
//                       child: Text('Connect AP'),
//                       onPressed: () {
//                         //05DAFF33-31365950-43187617
//                         // List<WifiResult> list =
//                         //     await Wifi.list('chen'); // this key is used to filter
//                         //     print("@@@ list.length : " + list.length.toString());
//                         // for (int i = 0; i < list.length; i++) {
//                         //   WifiResult wr = list[i];
//                         //   print("@@@ ssid : " + wr.ssid);
//                         // }
//                         // var result = await Wifi.connection('05DAFF33-31365950-43187617', '12345678');
//                         // String ssid = "AndroidAP4E97";
//                         // String pwd = "yxbh9460";
//                         GlobalVar.isAPConnected = true;
//                         // String ssid = "05DAFF33-31365950-43187617";
//                         probeCount = 0;
//                         // String pwd = "12345678";
//                         _connectAP(devicessid, "12345678");

//                         // socketClass = SocketClass();
//                         // await socketClass.initSocket();
//                         // if(result.toString()=="WifiState.success"){
//                         //   String param = "chenkexin,13437183248,www.cfdzkj.com,1888\n";
//                         //   SocketManage.sendData(param);
//                         // }
//                         // AppToast.showToast('Connect WIFI : ' + result.toString(), 2);
//                       },
//                     ),
//                     new RaisedButton(
//                       child: Text('Connet Chenkexin'),
//                       onPressed: () {
//                         // SocketManage.initSocket();
//                         // for (int i = 0; i < sc; i++) {
//                         //   var result =
//                         //       await Wifi.connection('chenkexin', '13437183248');
//                         //   print("@@@ result : " + result.toString());
//                         // }

//                         // print("@@@ Wifi Connection Over !");
//                         probeCount = 0;
//                         _connectAP('chenkexin', '13437183248');
//                       },
//                     ),
//                   ],
//                 ),
//                 Row(
//                   children: <Widget>[
//                     new RaisedButton(
//                       child: new Text('WIFI Info'),
//                       onPressed: () async {
//                         String ssid = await Wifi.ssid;
// //Signal strength， 1-3，The bigger the number, the stronger the signal
//                         int level = await Wifi.level;
//                         // String pwd=await Wifi.connection(ssid, password)
//                         String ip = await Wifi.ip;

//                         print(ssid + " / " + level.toString() + " / " + ip);
//                         // var result = await Wifi.connection('ssid', 'password');
// // only work on Android.
//                         // List<WifiResult> list = await Wifi.list('key'); // this key is used to filter
//                       },
//                     ),
//                     RaisedButton(
//                       child: new Text('Set WIFI'),
//                       onPressed: () async {
//                         // SocketManage.initSocket();
//                         // String ssid = "AndroidAP4E97";
//                         // String pwd = "yxbh9460";
//                         // String ssid = "chenkexin";
//                         // String pwd = "13437183248";
//                         String ssid = ssidController.text;
//                         String pwd = pwdController.text;
//                         for (int i = 0; i < 10; i++) {
//                           //String param = "chenkexin,13437183248,www.cfdzkj.com,1888\n";
//                           String param =
//                               ssid + "," + pwd + ",www.cfdzkj.com,1888\n";
//                           // await Future.delayed(new Duration(milliseconds: 20), SocketManage.sendData(param));
//                           await SocketManage.sendData(param);
//                         }

//                         print("@@@ Wifi Set Over !");
//                         // SocketManage.mSocket.write(obj)

// //             Socket _socket =await Socket.connect(ip, port);

// // _socket.transform(base64.encoder).listen((data){
// // //接受数据并处理
// //       List dataList = base64Decode(data);
// //   //接收后处理 详情可见下文
// //       readData(dataList);
// //     });

//                         // var result = await Wifi.connection('05DAFF33-31365950-43187617', '12345678');
//                         //  print("@@@ result : " + _socket.toString());
//                       },
//                     ),
//                   ],
//                 ),
//                 Row(
//                   children: <Widget>[
//                     RaisedButton(
//                       child: new Text('Init Socket'),
//                       onPressed: () async {
//                         socketClass = SocketClass();
//                         await socketClass.initSocket(); //(tn, ret) {}
//                       },
//                     ),
//                     RaisedButton(
//                       child: new Text('change wifi'),
//                       onPressed: () async {
//                         // print('@@@ sendData() ... socketClass : $socketClass');
//                         // String ssid = ssidController.text;
//                         // String pwd = pwdController.text;

//                         String param =
//                             '${ssidController.text},${pwdController.text},www.cfdzkj.com,1888\n';
//                         await socketClass.sendData(param);
//                       },
//                     ),
//                     RaisedButton(
//                       child: new Text('make wifi'),
//                       onPressed: () async {
//                         // print('@@@ sendData() ... socketClass : $socketClass');
//                         // String ssid = ssidController.text;
//                         // String pwd = pwdController.text;(tn, ret) {}
//                         socketClass = SocketClass();
//                         await socketClass.initSocket();
//                         String param =
//                             '${ssidController.text},${pwdController.text},www.cfdzkj.com,1888\n';
//                         await socketClass.sendData(param);
//                       },
//                     ),
//                   ],
//                 ),
              ]),
            ),
          ),
        ));
  }

  String wifiparam;
  final double dButtonHeight = 45.0;
  _getLoginButton(context, String name, String title, Color clBC) {
    return Container(
      margin: EdgeInsets.only(top: 10.0),
      width: double.infinity,
      height: dButtonHeight,
      child: RaisedButton(
        color: clBC,
        child: Text(
          title,
          style: TextStyle(
            // height: 2.2,
            color: Colors.white,
            fontSize: 19,
            fontFamily: "微软雅黑",
            // backgroundColor: AppStyle.mainColor,
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(3.0),
          // side: BorderSide(color: Colors.red),
          //size:Size(width, height),
        ), //圆角大小
        onPressed: () async {
          probeCount = 0;
          String ssid = ssidController.text;
          if (ssid == '') {
            AppToast.showToast('请输入SSID名称！');
            return;
          }

          GlobalVar.wifissid = ssid;
          GlobalVar.wifipwd = pwdController.text.trim();

          wifiparam =
              '${ssidController.text},${pwdController.text},www.cfdzkj.com,1888\n';

          if (name == 'all') {
            isset = 1;
            await _connectToAP();
          } else if (name == 'connect') {
            probeCount = 0;
            isset = 0;
            await _connectToAP();
          } else if (name == 'set') {
            isset = 0;
            _launchWifiSetting();
            // _probeWifiSet(); wc
          } else if (name == 'newall') {
            isset = 1;
            await _connectDevice(devicessid, '12345678');
          } else if (name == 'newconnect') {
            isset = 0;
            await _connectDevice(devicessid, '12345678');
          } else if (name == 'newset') {
            isset = 0;
            _launchWifiSetting();
          } else if (name == 'cc') {
            isset = 0;
            await _connectDevice('chenkexin', '13437183248');
          } else if (name == 'wifilist') {
            _getWifiList(devicessid);
          } else {
            var listAvailableWifi = await WifiConfiguration.getWifiList();
            print("get wifi list : " + listAvailableWifi.toString());
          }
          // Navigator.of(context).pop('Cancel');
        },
      ),
    );
  }

  _newallinone() async {
    isset = 1;
    await _connectDevice(devicessid, '12345678');
  }

  _allinone() async {
    isset = 1;
    await _connectToAP();
  }

  _getWifiList(String ssid) async {
    var listAvailableWifi = await WifiConfiguration.getWifiList();
    print("get wifi list : " + listAvailableWifi.toString());
    List<String> _lst = [];
    listAvailableWifi.forEach((v) {
      if (v != null && v.toString().trim() != '') _lst.add(v.toString());
    });
    AppDialog.showSelectTextItemIOS(context, _lst, null);
    // if (listAvailableWifi.toString().indexOf(ssid) == -1) {
    // AppToast.showToast('要连接的设备不存在，请检查设备是否开启 ...');
    // return;
    // }
  }

  _connectDevice(ssid, pwd) async {
    DialogBO.waitHint = '正在连接设备 ...';
    DialogBO.showCircleWait(context, isset == 1 ? 50 : 12, '正在连接设备 ...', '进度 ');

    try {
      WifiConnectionStatus connectionStatus =
          await WifiConfiguration.connectToWifi(ssid, pwd, "com.cfdzkj.ovenapp")
              .catchError((e) {
        print("WifiConfiguration.connectToWifi catchError : $e");
      });
      // print("is Connected : ${connectionStatus}");

      if (isset == 0) eventBus.fire(DialogCloseEvent());

      String ret = connectionStatus.toString();
      print("connectionStatus : $ret");

      bool blSetWifi = await WifiConfiguration.isConnectedToWifi(ssid);
      print("isConnectedToWifi : $blSetWifi");

      ret = '$ssid 连接成功！';
      switch (connectionStatus) {
        case WifiConnectionStatus.connected:
          // print("connected");
          // blSetWifi=true;
          break;

        case WifiConnectionStatus.alreadyConnected:
          // print("alreadyConnected");
          // blSetWifi=true;
          break;

        case WifiConnectionStatus.notConnected:
          // print("notConnected");
          ret = '$ssid ' + _connectFail;
          break;

        case WifiConnectionStatus.platformNotSupported:
          // print("platformNotSupported");
          ret = '$ssid 连接失败 (该版本不支持)！';
          break;

        case WifiConnectionStatus.profileAlreadyInstalled:
          // blSetWifi=true;
          // print("profileAlreadyInstalled");
          break;

        case WifiConnectionStatus.locationNotAllowed:
          // print("locationNotAllowed");
          ret = '$ssid 连接失败 (请开启【烘焙之光】app在本机的使用权限)！';
          break;
      }

      AppToast.showToast(ret);

      if (blSetWifi && isset == 1) {
        Future.delayed(Duration(seconds: 3), () {
          _launchWifiSetting();
        });
      }
    } catch (e) {
      print("_connectDevice error : $e");
    }
  }

  _launchWifiSetting() async {
    tryCount = 0;
    probeCount = 0;
    SocketClass.sendRet = 0;
    SocketClass.socketConnected = 0;
    DialogBO.waitHint = '正在设置 WIFI ...';
    if (isset == 0) DialogBO.showCircleWait(context, 50, '正在设置WIFI ...', '进度 ');
    await _setWifiParam();
  }

  int isset = 1;

  SocketClass socketClass;
  _connectToAP() async {
    // SocketClass sc = SocketClass();
    // await sc.initSocket();

    probeCount = 0;
    print('@@@ sendData() ... socketClass : $socketClass');
    String ssid = ssidController.text.trim();
    // String pwd = pwdController.text.trim();
    if (ssid == '') {
      AppToast.showToast('请输入SSID名称！');
      return;
    }

    GlobalVar.wifissid = ssid;
    GlobalVar.wifipwd = pwdController.text.trim();
    _connectAP(devicessid, '12345678');

    DialogBO.waitHint = '正在连接设备 ...';
    DialogBO.showCircleWait(
        context, isset == 1 ? 80 : 12, '正在连接设备 ...', '进度 '); //80
    // String param = ssid + "," + pwd + ",www.cfdzkj.com,1888\n";
    // await socketClass.sendData(param);

    // for (int i = 0; i < 10; i++) {
    //   //String param = "chenkexin,13437183248,www.cfdzkj.com,1888\n";
    //   // await Future.delayed(new Duration(milliseconds: 20), SocketManage.sendData(param));
    //   // await sc.sendData(param);
    // }
  }

  Future<bool> _getWifiInfo(newssid, [et = 1]) async {
    try {
      String ssid = await Wifi.ssid;
//Signal strength， 1-3，The bigger the number, the stronger the signal
      int level = await Wifi.level;
      // String pwd=await Wifi.connection(ssid, password)
      String ip = await Wifi.ip;

      print('@@@ WifiPage._getWifiInfo() ' +
          ssid +
          " , " +
          level.toString() +
          " , " +
          ip);
      return et == 1 ? newssid == ssid : newssid != ssid;
    } catch (e) {
      print('*** WifiPage._getWifiInfo() e : $e');
      return false;
    }
    // var result = await Wifi.connection('ssid', 'password');
// only work on Android.
    // List<WifiResult> list = await Wifi.list('key'); // this key is used to filter
  }

  int tryCount = 1;
  _connectAP(String ssid, String password) async {
    print("@@@ WifiPage._connectAP($ssid,$password) tryCount : $tryCount ...");
    // SocketManage.initSocket();
    var result;
    // for (int i = 0; i < tryCount; i++) {
    await Wifi.connection(ssid, password).then((f) {
      print("@@@ WifiPage._connectAP f : $f");
      result = f;
    }).catchError((e) {
      print("*** WifiPage._connectAP error : $e");
    });
    print("@@@ WifiPage._connectAP tryCount : $tryCount , result : " +
        result.toString());
    tryCount++;
    // }

    print("@@@ WifiPage._connectAP Connect Over !");
    // probeCount = 0;
    // _getWifiInfo();
    _probeWifi(ssid, password);
  }

  int probeCount = 0;
  _probeWifi(apid, pwd) async {
    print(
        "@@@ WifiPage._probeWifi GlobalVar.isAPConnected : ${GlobalVar.isAPConnected}");
    // probeCount = 0;
    Timer.periodic(Duration(seconds: 1), (timer) {
      // bool blret = await _getWifiInfo(ssid);

      _getWifiInfo(apid).then((f) {
        probeCount++;
        print("@@@ WifiPage._probeWifi f : $f , probeCount : $probeCount");

        if (f) {
          timer.cancel();
          timer = null;
          probeCount = 0;
          // _setWifi();
          // eventBus.fire(DialogCloseEvent());
          // AppToast.showToast('连接设备成功！');
          DialogBO.waitHint = '正在设置 WIFI ...';
          if (isset == 1) {
            // AppToast.showToast('连接设备成功，请继续点击设置！');
            Timer(Duration(seconds: 15), () {
              _setWifiParam();
            });
          } else {
            eventBus.fire(DialogCloseEvent());
            AppToast.showToast('连接设备成功！');
          }
          return;
        } else {
          if (probeCount > 10) {
            timer.cancel();
            timer = null;
            probeCount = 0;
            eventBus.fire(DialogCloseEvent());
            AppToast.showToast('连接主板失败，请确保手机开通数据通道和设备处于出厂模式！');
            return;
          } else {
            timer.cancel();
            timer = null;
            _connectAP(apid, pwd);
          }
        }
      });
      // probeCount++;
    });
  }

  String _connectFail = '连接设备失败，请确保手机开通数据通道和设备处于出厂模式！';
  // _setWifi() async {
  //   socketClass = SocketClass();
  //   await socketClass.initSocket();//(tn, ret) {}
  //   print(
  //       "@@@ WifiPage._setWifi() tn : $tn , ret : $ret -- ${DateTime.now()}");

  //   if (tn == 'connect') {
  //     // Timer(Duration(seconds: 2), () {
  //     //   String param =
  //     //       '${ssidController.text},${pwdController.text},www.cfdzkj.com,1888\n';
  //     //   socketClass.sendData(param);
  //     // });

  //     // if (ret == 'OK') {
  //     //   String param =
  //     //       '${ssidController.text},${pwdController.text},www.cfdzkj.com,1888\n';
  //     //   socketClass.sendData(param);
  //     // } else {
  //     //   eventBus.fire(DialogCloseEvent());
  //     //   AppToast.showToast('设置错误：$ret，请重新尝试设置 ...');
  //     //   return;
  //     // }
  //   }
  //   // if (tn == 'send') {}

  //   if (tn == 'listen') {
  //     // eventBus.fire(DialogCloseEvent());
  //     // if (ret == 'OK') {
  //     //   AppToast.showToast('设置成功，请断电重启主板！');
  //     //   Navigator.pop(context);
  //     // } else {
  //     //   AppToast.showToast('设置错误：$ret，请重新尝试设置 ...');
  //     //   return;
  //     // }
  //     // GlobalVar.isAPConnected = false;
  //   }
  // });

  // String param =
  //     '${ssidController.text},${pwdController.text},www.cfdzkj.com,1888\n';
  // print("@@@ WifiPage._setWifiParam() param : $param");
  // await socketClass.sendData(param);

  // Timer(Duration(seconds: 3), () {
  //   _setWifiParam(socketClass);
  // });
  // }

  _setWifiParam() async {
    // if (probeCount == 0) {
    //   DialogBO.waitHint = '正在设置 WIFI ...';
    //   DialogBO.showCircleWait(context, 60, '正在设置 WIFI ...', '进度 ');
    // }
    // DialogBO.showCircleWait(context, 60, '正在设置WIFI ...', '进度 ');
    print(
        "@@@ WifiPage._setWifiParam() SocketClass.socketConnected : ${SocketClass.socketConnected} , SocketClass.sendRet : ${SocketClass.sendRet},probeCount : $probeCount");
    if (SocketClass.socketConnected == 0) {
      socketClass = SocketClass();
      await socketClass.initSocket();
    }

    if (SocketClass.sendRet == 0) {
      // String param =
      //     '${ssidController.text},${pwdController.text},www.cfdzkj.com,1888\n';

      // print("@@@ WifiPage._setWifiParam() param : $param");
      // await socketClass.sendData(param);
      await _sendData();
      // for (int i = 0; i < 5; i++) {
      //   print("@@@ WifiPage._setWifiParam() param : $param");
      //   await Future.delayed(Duration(milliseconds: 100),(){
      //      socketClass.sendData(param);
      //   });
      // }
    }

    _probeWifiSet();
  }

  _sendData() async {
    String param =
        '${ssidController.text},${pwdController.text},www.cfdzkj.com,1888\n';
    // print("@@@ WifiPage._setWifiParam() param : $param");
    await socketClass.sendData(param);
  }

  _probeWifiSet() async {
    // probeCount = 0;
    Timer.periodic(Duration(seconds: 3), (timer) {
      print(
          "@@@ WifiPage._probeWifiSet SocketClass.socketConnected:${SocketClass.socketConnected}, SocketClass.sendRet : ${SocketClass.sendRet}");

      _sendData();
      if (SocketClass.sendRet == 1) {
        //设置成功，但有时候成功了并未改变，所以再追发一次

        timer.cancel();
        timer = null;
        probeCount = 0;

        Timer(Duration(seconds: 10), () {
          eventBus.fire(DialogCloseEvent());
          AppToast.showToast('设备wifi设置成功，请重启设备！');
          SharePrefHelper.saveData(
              'wifiparam', '${ssidController.text},${pwdController.text}');
          Navigator.pop(context);
        });
        // eventBus.fire(DialogCloseEvent());
        // AppToast.showToast('设备wifi设置成功，请重启设备！');
        // Timer(Duration(seconds: 10), () {
        // Navigator.pop(context);
        // });
        // Navigator.pop(context);
        return;
      }

      if (probeCount > 5) {
        timer.cancel();
        timer = null;
        probeCount = 0;
        eventBus.fire(DialogCloseEvent());
        AppToast.showToast('设备wifi设置失败，请重试...！');
        return;
      }

      probeCount++;
      timer.cancel();
      timer = null;
      _setWifiParam();
    });

    // _getWifiInfo(devicessid,0).then((f) {
    //   probeCount++;
    //   print("@@@ WifiPage._probeWifiSet f : $f , probeCount : $probeCount");

    //   if (f) {
    //     timer.cancel();
    //     timer = null;
    //     probeCount = 0;
    //     // _setWifi();
    //     eventBus.fire(DialogCloseEvent());
    //     AppToast.showToast('设备wifi设置成功，请重启设备！');
    //      Navigator.pop(context);
    //     return;
    //   } else {
    //     if (probeCount > 5) {
    //       timer.cancel();
    //       timer = null;
    //       probeCount = 0;
    //       eventBus.fire(DialogCloseEvent());
    //       AppToast.showToast('设备wifi设置失败，请重试...！');
    //       return;
    //     } else {
    //       timer.cancel();
    //       timer = null;
    //       _setWifiParam();
    //     }
    //   }
    // }).catchError((e){
    //   print("@@@ WifiPage._probeWifiSet catchError e : $e");
    // });
  }
}
