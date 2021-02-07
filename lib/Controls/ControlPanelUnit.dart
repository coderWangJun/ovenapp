import 'dart:async';
// import 'dart:js';

import 'package:flutter/material.dart';
import 'package:ovenapp/BusinessObjects/TemplateBO.dart';
import 'package:ovenapp/Classes/MediaPlayer.dart';
// import 'package:ovenapp/BusinessObjects/DialogBO.dart';
// import 'package:ovenapp/Classes/AppDialog.dart';
// import 'package:ovenapp/Controls/AppWidget.dart';
// import 'package:ovenapp/BusinessObjects/DeviceBO.dart';
import 'package:ovenapp/Models/ControlPanelModel.dart';
import 'package:ovenapp/Models/DeviceModel.dart';
import 'package:ovenapp/Models/MqttDataModel.dart';
// import 'package:ovenapp/Pages/ControlPanelPage.dart';
// import 'package:ovenapp/Pages/WifiPage.dart';
import 'package:ovenapp/Publics/AppStyle.dart';
import 'package:ovenapp/Publics/DateTimeHelper.dart';
import 'package:ovenapp/Publics/GlobalVar.dart';
// import 'package:ovenapp/Publics/GlobalVar.dart';
// import 'package:ovenapp/Publics/GlobalVar.dart';
import 'package:ovenapp/Services/EventBusSrv.dart';

class ControlPanelUnit extends StatefulWidget {
  ControlPanelUnit(
      {Key key, this.deviceModel, this.controlPanelModel, this.index})
      : super(key: key);
  final DeviceModel deviceModel;
  final ControlPanelModel controlPanelModel;
  final int index;
  @override
  _ControlPanelUnitState createState() => _ControlPanelUnitState();
}

class _ControlPanelUnitState extends State<ControlPanelUnit> {
  var _onMqttPayloadEvent;
  final double dM = 5.0;
  final double iconSize = 18.0;
  final double fontSize = 19.0;
  String uuid;

  // GlobalKey _key = GlobalKey();

  final StreamController<MqttDataModel> _streamController =
      StreamController<MqttDataModel>();

  MqttDataModel curMqttData = MqttDataModel(
      uuid: "0",
      state: 0,
      timer: [420, 0],
      up: [200, 0, 0],
      down: [200, 0, 0],
      steam: [200, 0],
      center: [200, 0]);

  @override
  void initState() {
    // print("@@@ ControlPanelUnit.initState() ... index : ${widget.index}");
    super.initState();
    // GlobalVar.mqttClass = new MqttClass(GlobalVar.userInfo.loginid);
    uuid = "/" + widget.controlPanelModel.uuid;
    int warn = 0;
    //所有来自设备的消息从这理统一处理后下发，其它地方不再监听此消息
    _onMqttPayloadEvent = eventBus.on<MqttPayloadEvent>().listen((event) {
      // if (!isListen) return;
      MqttDataModel mm = event.data;

      // print('@@@ ControlPanelUnit._onMqttPayloadEvent GlobalVar.isControlPanelOpen : ${GlobalVar.isControlPanelOpen}');
      // print('@@@ ControlPanelUnit._onMqttPayloadEvent : ${mm.uuid} - ${widget.controlPanelModel.uuid}');
      if (mm.uuid != uuid || mm.state > 4) {
        //  print('@@@ ControlPanelUnit._onMqttPayloadEvent : false');
        return;
      }

      if (mm.state == -1) mm.state = 0; // 遗嘱 {"state":-1}

      //更新主板状态，通知设备刷新显示
      if (mm.state != widget.controlPanelModel.state) {
        widget.controlPanelModel.setState(mm.state);
        eventBus.fire(DeviceDataEvent(widget.controlPanelModel.did));
      } else
        widget.controlPanelModel.setState(mm.state);

      //倒计时报警
      if (warn != mm.warn) {
        if (mm.warn == 1) {
          // _showWarn();
          eventBus.fire(WarnStartEvent(mm.uuid));
        } else {
          if (MediaPlayer.isloop == 1) {
            GlobalVar.closeWarnAudio();
          }
        }
      }

      if (GlobalVar.isPrintMqttData == 1)
        print(
            '${DateTime.now()} ControlPanelUnit._onMqttPayloadEvent $uuid => curMqttData.state : ${curMqttData.state} , mm.state : ${mm.state}');

      if (curMqttData != null) {
        if (curMqttData.state != mm.state ||
            curMqttData.timer[1] != mm.timer[1] ||
            curMqttData.steam[1] != mm.steam[1] ||
            curMqttData.up[1] != mm.up[1] ||
            curMqttData.down[1] != mm.down[1]) {
          // setState(() {});
          _streamController.sink.add(mm);
        }
      }

      curMqttData = mm;

      GlobalVar.mpMqttData[widget.controlPanelModel.uuid] = mm;

      eventBus.fire(ControlPanelDataEvent(widget.controlPanelModel.uuid));
    });
  }

  @override
  void dispose() {
    super.dispose();

    _streamController.close();
    //取消订阅
    _onMqttPayloadEvent.cancel();
    // print("@@@ ControlPanelUnit.dispose() ...");
  }

  @override
  Widget build(BuildContext context) {
    // super.build(context);
    // print("@@@ ControlPanelUnit.build() ...");
    // maincontext = context;
    return //GestureDetector(      child:
        //   Expanded(
        // flex: 20,
        // child:
        StreamBuilder<MqttDataModel>(
            stream: _streamController.stream,
            initialData: curMqttData,
            builder:
                (BuildContext context, AsyncSnapshot<MqttDataModel> snapshot) {
              return GestureDetector(
                child: Container(
                  width: TemplateBO.dControlPanelUnitWidth,
                  constraints: BoxConstraints(
                    minWidth: 75.0,
                  ),
                  alignment: Alignment.center,
                  margin: EdgeInsets.fromLTRB(0, dM, 0.0, dM),
                  padding: EdgeInsets.only(
                    bottom: 3.0,
                  ),
                  decoration: BoxDecoration(
                    // border: Border(
                    //     right: BorderSide(color: Colors.grey[300], width: 1.0)), //灰色的一层边框
                    border: Border.all(
                        color: _getBorderColor(snapshot.data), width: 1.0),
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        height: 4,
                        decoration: BoxDecoration(
                          color: _getBorderColor(snapshot.data),
                          borderRadius: BorderRadius.vertical(
                            bottom: Radius.circular(3.0),
                            //right: new Radius.circular(20.0),
                          ),
                        ),
                        margin: EdgeInsets.only(
                            left: 20.0, right: 20.0, bottom: 3.0),
                      ),
                      _getData(snapshot.data, "clock"),
                      _getData(snapshot.data, "steam"),
                      _getData(snapshot.data, "upfire"),
                      _getData(snapshot.data, "downfire"),
                    ],
                  ),
                ),
                onTap: () => _gotoCP(),
                onLongPress: () => _showMemu(), //_popMenu(context),
                onDoubleTap: () => _showMemu(),
              );
            });
  }

  _showMemu() {
    eventBus.fire(ControlPanelEvent("menu", widget.controlPanelModel));
  }

  _gotoCP() {
    // eventBus.fire(ControlPanelEvent("show", widget.controlPanelModel));
    eventBus
        .fire(DeviceEvent("controlpanel", widget.deviceModel, widget.index));
  }

  Widget _getData(MqttDataModel mqttData, String t) {
    final double dE = 6.5;
    return Expanded(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(width: dE),
        Image.asset(_getIcon(mqttData, t), //"images/" + t + ".png",
            width: iconSize,
            height: iconSize),
        Expanded(
            child: Container(
                // margin: EdgeInsets.only(left: 5),
                alignment: Alignment.centerRight,
                child: Text(
                  _getRealValue(mqttData, t),
                  style: TextStyle(fontSize: fontSize, color: Colors.grey),
                ))),
        // Text(
        //   t == "clock" ? " S" : "℃",
        //   style: TextStyle(fontSize: fontSize, color: Colors.grey),
        // ),
        SizedBox(width: dE),
      ],
    ));
  }

  String _getRealValue(MqttDataModel mqttData, String t) {
    if (mqttData == null) return "0";
    String sret = "0";
    try {
      switch (t) {
        case "clock":
          sret = _getClockCount(mqttData.timer);
          break;
        case "steam":
          sret = _getClockCount(mqttData.steamt);
          // if (mqttData.steamt.length > 1) sret = DateTimeHelper.changeSecToMS(mqttData.steamt[0]-mqttData.steamt[1]); else sret='0';//  mqttData.steam[1].toString();
          break;
        case "upfire":
          if (mqttData.up.length > 1) sret = mqttData.up[1].toString();
          break;
        case "downfire":
          if (mqttData.down.length > 1) sret = mqttData.down[1].toString();
          break;
      }
    } catch (e) {
      print('*** ControlPanelUnit._getRealValue error : ${e.toString()}');
      print(mqttData);
    }
    return sret;
  }

  _getClockCount(data) {
    // print('data : $data , data.length : ${data.length} 0 : ${data[0]} , 1 : ${data[1]}'); https://pub.flutter-io.cn/packages/flutter_spinkit
    if (data == null || data.length <= 1 || data[1].toInt() == 0)
      return '0';
    else
      return DateTimeHelper.changeSecToMS(data[0] - data[1]);
  }

  Color _getBorderColor(MqttDataModel mqttData) {
    // return GlobalVar.cpOpenColor;
    if (mqttData == null || mqttData.state == 0)
      return AppStyle.cpCloseColor;
    else
      return AppStyle.cpOpenColor;
  }

  String _getIcon(MqttDataModel mqttData, String t) {
    if (mqttData == null || mqttData.state == 0) {
      return "images/" + t + "_g.png";
    } else {
      if (mqttData.state == 2 && t == 'click')
        return "images/clock.png";
      else if (mqttData.state == 3 && t == 'center')
        return "images/center.png";
      else
        return "images/" + t + ".png";
    }
  }

  // _popMenu(BuildContext context) {
  //   RenderBox box = context.findRenderObject();
  //   Offset offset = box.localToGlobal(Offset.zero);
  //   Size size = box.size;
  //   double l = offset.dx + size.width / 4;
  //   double t = offset.dy + size.height / 3;
  //   showMenu(
  //     context: context,
  //     position: RelativeRect.fromLTRB(l, t, 1000.0, 1000.0),
  //     items: <PopupMenuItem<String>>[
  //       PopupMenuItem(value: "0", child: new Text("移除")),
  //       PopupMenuItem(value: "1", child: Text("初始化WIFI")),
  //       PopupMenuItem(value: "2", child: Text("更换WIFI")),
  //       PopupMenuItem(value: "3", child: new Text("报修")),
  //       PopupMenuItem(value: "4", child: new Text("帮助")),
  //     ],
  //     // items: <PopupMenuEntry>[
  //     //   PopupMenuItem(value: "0", child: Text("移除")),
  //     //   PopupMenuDivider(),
  //     //   PopupMenuItem(value: "1", child: Text("初始化WIFI")),
  //     //   PopupMenuDivider(),
  //     //   PopupMenuItem(value: "2", child: Text("更换WIFI")),
  //     //   PopupMenuDivider(),
  //     //   PopupMenuItem(value: "3", child: Text("报修")),
  //     //   PopupMenuDivider(),
  //     //   PopupMenuItem(value: "4", child: Text("帮助")),
  //     // ],
  //   ).then((v) {
  //     // print("selected : $v");
  //     switch (v) {
  //       case "0":
  //         AppDialog.showYesNoIOS(context, "移除确认", "您确实要移除该控制面板吗？", () {
  //           eventBus
  //               .fire(ControlPancelEvent("delete", widget.controlPanelModel));
  //         });
  //         break;
  //       case "1":
  //         _initWifi();
  //         break;
  //       case "2":
  //         String orderstr = '{"state":"getWifi"}';
  //         print("@@@ _sendOrder()  orderstr : $orderstr");
  //         GlobalVar.mqttClass.publishMessage("/oven/device" + uuid, orderstr);
  //         break;
  //     }
  //   });
  //   // print("_popMenu");
  //   // return PopupMenuButton(
  //   //   itemBuilder: (context) => <PopupMenuItem<String>>[
  //   //     new PopupMenuItem(value: "0", child: new Text("选项一")),
  //   //     new PopupMenuItem(value: "1", child: new Text("选项二"))
  //   //   ],
  //   //   onSelected: (value) {
  //   //     print("onSelected");
  //   //   },
  //   //   onCanceled: () {
  //   //     print("onCanceled");
  //   //   },
  //   // );
  // }

  // _initWifi() {
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //       builder: (context) => WifiPage(
  //         uuid: uuid,
  //       ),
  //     ),
  //   ).then((ret) {
  //     GlobalVar.isAPConnected = false;
  //     // if (GlobalVar.tempData.containsKey('template_id')) _runTemplate();
  //   }).catchError((e) {
  //     GlobalVar.isAPConnected = false;
  //     print('@@@ _initWifi() catchError(e) : $e');
  //   }).whenComplete(() {
  //     GlobalVar.isAPConnected = false;
  //   });
  // }

  // _showWifiUI(mm) {
  //   DialogBO.showWifiIOS(context, mm.ssid, mm.password, (ssid, pwd) {
  //     print('@@@ ssid : $ssid , pwd : $pwd');
  //     if (ssid == mm.ssid && pwd == mm.password) return;
  //     String orderstr = '{"state":"setwifi","ssid":"$ssid","passwd":"$pwd"}';
  //     print("@@@ _sendOrder()  orderstr : $orderstr");
  //     GlobalVar.mqttClass.publishMessage("/oven/device" + uuid, orderstr);
  //   });
  // }
}
