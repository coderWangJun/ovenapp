import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ovenapp/BusinessObjects/TemplateBO.dart';
// import 'package:ovenapp/BusinessObjects/AppBO.dart';
// import 'package:ovenapp/BusinessObjects/DeviceBO.dart';
import 'package:ovenapp/Classes/AppDialog.dart';
import 'package:ovenapp/Classes/AppToast.dart';
import 'package:ovenapp/Controls/ControlPanelUnit.dart';
// import 'package:ovenapp/Models/ControlPanelModel.dart';
import 'package:ovenapp/Models/DeviceModel.dart';
import 'package:ovenapp/Models/PowerModel.dart';
// import 'package:ovenapp/Models/MqttDataModel.dart';
import 'package:ovenapp/Publics/AppStyle.dart';
import 'package:ovenapp/Publics/DateTimeHelper.dart';
// import 'package:ovenapp/Pages/DeviceDetailPage.dart';
import 'package:ovenapp/Publics/GlobalVar.dart';
import 'package:ovenapp/Services/EventBusSrv.dart';

class DeviceUnit extends StatefulWidget {
  DeviceUnit({Key key, this.deviceModel, this.index}) : super(key: key);
  final DeviceModel deviceModel;
  // final List<dynamic> lstControlPanel; this.lstControlPanel,
  final int index;

  @override
  _DeviceUnitState createState() => _DeviceUnitState();
}

const double dLeft = 12.0;
const double dTop = 6.0;

class _DeviceUnitState extends State<DeviceUnit> {
  // List<ControlPanelModel> _lstControlPanel = [];
  Map<String, int> _cpState = {};
  // final StreamController<Map<String, int>> _streamController =
  //     StreamController<Map<String, int>>();
  final StreamController<int> _streamController = StreamController<int>();
  final StreamController<PowerModel> _powerController =
      StreamController<PowerModel>();

  // Stream _dataStateStream;
  // var _onMqttPayloadEvent;
  var _onDeviceDataEvent;
  var _onPowerEvent;

  int dstate = 0;
  PowerModel _powerModel;

  @override
  void initState() {
    // print("@@@ ControlPanelUnit.initState() ... index : ${widget.index}");
    super.initState();

    // print(
    //     "@@@ DeviceUnit.initState() ... widget.lstControlPanel.length : ${widget.deviceModel.lstCP.length}");

    _powerModel = PowerModel.getEmptyObj();
    // DeviceBO.getPower();
    // if (GlobalVar.lstPower != null && GlobalVar.lstPower.length > 0) {
    // } else {}

    _onDeviceDataEvent = eventBus.on<DeviceDataEvent>().listen((event) {
      if (widget.deviceModel.lstCP.length == 0) return;
      if (event == null ||
          event.did == null ||
          widget.deviceModel.id != event.did) return;

      int state = widget.deviceModel.getState();
      if (GlobalVar.isPrintMqttData == 1)
        print(
            '@@@ DeviceUnit._onDeviceDataEvent did : ${event.did} , dstate : $dstate , state : $state');
      if (state != dstate) {
        dstate = state;
        _streamController.sink.add(dstate);
      }
    });

    _onPowerEvent = eventBus.on<PowerEvent>().listen((event) {
      PowerModel pm = event.pm;
      if (pm.id == widget.deviceModel.id) {
        // print('@@@ DeviceUnit._onPowerEvent pm : ${event.pm.toJsonStr()}');
        _powerController.sink.add(event.pm);
      }
    });

    // _dataStateStream = _streamController.stream.asBroadcastStream();
    // _streamController.stream
    //     .listen((data) => print("~~~~~~~~~~~~~~~~~~~~~~~~ : $data"));
  }

  @override
  void dispose() {
    super.dispose();

    _streamController.close();
    _powerController.close();
    //取消订阅
    _onDeviceDataEvent.cancel();
    _onPowerEvent.cancel();
    // _onMqttPayloadEvent.cancel();
    // print(
    //     "@@@ DeviceUnit.dispose() ... widget.deviceModel.id : ${widget.deviceModel.id}");
  }

  @override
  Widget build(BuildContext context) {
    // print(
    //     "@@@ DeviceUnit.build() ... indexno : ${widget.deviceModel.indexno}"); // key : ${widget.key}  widget.lstControlPanel.length : ${widget.lstControlPanel.length}
    // _getControlPanelList();
    _getCPState();
    // _lstControlPanel=widget.lstControlPanel as List<dynamic>;
    return StreamBuilder<int>(
        stream: _streamController.stream,
        initialData: dstate,
        builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
          return _getCardUI(); //_getDeviceUI();
        });
    // return StreamBuilder<Map<String, int>>(
    // stream: _streamController.stream,
    // initialData: _cpState,
    // builder:
    //     (BuildContext context, AsyncSnapshot<Map<String, int>> snapshot) {
    //   return _getDeviceUI();
    // });
  }

  // _getControlPanelList() {
  //   _lstControlPanel.clear();
  //   for (int i = 0; i < widget.lstControlPanel.length; i++) {
  //     ControlPanelModel cpm = widget.lstControlPanel[i];
  //     if (cpm.did == widget.deviceModel.id) {
  //       _lstControlPanel.add(cpm);
  //       _cpState[cpm.uuid] = 0;
  //     }
  //   }
  // }

  _getCPState() {
    for (int i = 0; i < widget.deviceModel.lstCP.length; i++) {
      // ControlPanelModel cpm = widget.lstControlPanel[i];
      _cpState[widget.deviceModel.lstCP[i].uuid] = 0;
    }
  }

  _getCardUI() {
    double dIconSize = 26.0;
    return Card(
      margin: const EdgeInsets.fromLTRB(dLeft, dTop, dLeft, dTop),
      elevation: dstate == 0 ? 2.0 : 0.0, //传入double值，控制投影效果

      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: _getBorderStateColor(dstate), //Colors.transparent,
          width: 1.0,
        ),
        borderRadius: BorderRadius.all(Radius.circular(10.0)), //设定 Card 的倒角大小
        // borderRadius: BorderRadius.only(
        //   //设定 Card 的每个角的倒角大小
        //   topLeft: Radius.zero, //Radius.circular(20.0),
        //   topRight: Radius.zero,
        //   bottomLeft: Radius.zero, //Radius.circular(10.0),
        //   bottomRight: Radius.zero, //Radius.circular(10.0),
        // ),
      ),

      clipBehavior: Clip.antiAlias, //
      child: Column(
        children: <Widget>[
          //标题
          Container(
            height: 45.0,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      // print('@@@ ${widget.deviceModel.id}');
                      eventBus
                          .fire(DeviceEvent("detail", widget.deviceModel, 0));
                    },
                    child: Container(
                      // color: Colors.redAccent,
                      alignment: Alignment.centerLeft,
                      height: double.infinity,
                      margin: EdgeInsets.only(left: 12.0),
                      child: Text(
                        widget.deviceModel.name,
                        style: TextStyle(
                          fontSize: 19.0,
                          color: Colors.black87,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ),
                IconButton(
                    icon: Icon(
                      Icons.power_settings_new,
                      color: _getStateColor(2),
                    ),
                    padding: EdgeInsets.zero,
                    iconSize: dIconSize,
                    onPressed: () {
                      AppDialog.showSelectTextItemIOS(
                          context, ["关闭所有烤炉", "开启所有烤炉", "取消"], (item) {
                        _closeAll(item);
                      });
                    }),
                IconButton(
                    icon: Icon(
                      Icons.clear,
                      color: Colors.grey[400],
                    ),
                    padding: EdgeInsets.zero,
                    iconSize: dIconSize,
                    onPressed: () {
                      eventBus
                          .fire(DeviceEvent("delete", widget.deviceModel, 0));
                    }),
                IconButton(
                    // icon: Icon(
                    //   Icons.flash_on,
                    //   color: Colors.grey[400],
                    // ),
                    // color: Colors.grey[400],
                    icon: Image.asset(
                      'images/power2.png',
                      color: Colors.grey[400],
                      height: 24.0,
                      width: 24.0,
                    ),
                    padding: EdgeInsets.zero,
                    // iconSize: dIconSize,
                    onPressed: () {
                      eventBus.fire(
                          DeviceEvent("viewpower", widget.deviceModel, 0));
                    }),
              ],
            ),
          ),

          //主板
          Container(
            decoration: BoxDecoration(
              // color: AppStyle.clTitleBC, // Colors.transparent,
              border: Border(
                top: BorderSide(color: _getLineStateColor(dstate), width: 1.0),
                bottom: BorderSide(
                    color: (widget.deviceModel.lstCP.length > 0)
                        ? _getLineStateColor(dstate)
                        : Colors.transparent,
                    width: 1.0),
              ),
              // backgroundBlendMode: BlendMode.color,
              // color: Colors.black38, //Color.fromRGBO(255, 255, 255, 0.55),
            ),
            margin: EdgeInsets.only(left: 10.0, right: 10.0),
            padding: EdgeInsets.only(
              top: 5.0,
              bottom: 5.0,
            ),
            height: 135.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: _getControlPanelGroupUI(),
            ),
          ),

          //电量、运行时间
          (widget.deviceModel.lstCP.length > 0)
              ? StreamBuilder<PowerModel>(
                  stream: _powerController.stream,
                  initialData: _powerModel,
                  builder: (BuildContext context,
                      AsyncSnapshot<PowerModel> snapshot) {
                    return _getPowerUI(snapshot.data); //_getDeviceUI();
                  })
              : SizedBox(
                  height: 0.0,
                ),

          // child: Row(children: <Widget>[
          //   Container(
          //     width: 6,
          //     decoration: BoxDecoration(
          //       border: Border.all(
          //           color: _getStateColor(0), width: 3.0, style: BorderStyle.solid),
          //       borderRadius: BorderRadius.horizontal(
          //         left: Radius.circular(5.0),
          //         //right: new Radius.circular(20.0),
          //       ),
          //       // color: _getBorderColor(), //Colors.green,
          //     ),
          //   ),
          //   // _getDeviceInfoUI(),
          //   Expanded(
          //       child: Row(
          //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //           children: _getControlPanelGroupUI())),
          // ])
        ],
      ),
    );
  }

  _getPowerUI(pm) {
    return Container(
      height: 65.0,
      margin: EdgeInsets.only(
        left: 15.0,
        right: 15.0,
      ),
      child: Row(
        children: <Widget>[
          _getPowerIconUI(0),
          // Container(
          //   child: Icon(
          //     Icons.restore,
          //     size: 28.0,
          //     color: Colors.grey[400],
          //   ),
          // ),
          Container(
            width: 70.0,
            child: _getPowerDataUI(0, pm),
          ),
          _getSplitterUI(),
          _getPowerIconUI(1),
          // Container(
          //   child: Icon(
          //     Icons.alarm,
          //     size: 28.0,
          //     color: _getStateColor(dstate),
          //   ),
          // ),
          Container(
            width: 70.0,
            child: _getPowerDataUI(1, pm),
            // child: StreamBuilder<PowerModel>(
            //     stream: _powerController.stream,
            //     initialData: _powerModel,
            //     builder: (BuildContext context,
            //         AsyncSnapshot<PowerModel> snapshot) {
            //       return _getPowerDataUI(
            //           1, snapshot.data); //_getDeviceUI();
            //     }),
          ),

          _getSplitterUI(),
          _getPowerIconUI(2),
          // Container(
          //   child: Icon(
          //     Icons.update,
          //     size: 28.0,
          //     color: Colors.grey[400],
          //   ),
          // ),
          Expanded(
            flex: 20,
            child: _getPowerDataUI(2, pm),
            // child: StreamBuilder<PowerModel>(
            //     stream: _powerController.stream,
            //     initialData: _powerModel,
            //     builder: (BuildContext context,
            //         AsyncSnapshot<PowerModel> snapshot) {
            //       return _getPowerDataUI(
            //           2, snapshot.data); //_getDeviceUI();
            //     }),
          ),
        ],
      ),
    );
  }

  _getSplitterUI() {
    return Container(
      width: 1.0,
      margin: EdgeInsets.only(
        top: 8.0,
        bottom: 8.0,
        left: 8.0,
        right: 8.0,
      ),
      color: AppStyle.clSplitterLineColor,
    );
  }

  double dIconSize = 20.0;
  _getPowerIconUI(tt) {
    return GestureDetector(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            child: Image.asset(
              'images/times.png',
              width: dIconSize,
              height: dIconSize,
              color: Colors.grey[400],
            ),
          ),
          SizedBox(
            height: 8.0,
          ),
          Container(
            child: Image.asset(
              'images/powers.png',
              width: dIconSize,
              height: dIconSize,
              color: Colors.grey[400],
            ),
          ),
        ],
      ),
      onTap: () {
        _showPowerHint(tt);
      },
    );
  }

  _showPowerHint(tt) {
    String hint = '升温时间与消耗电量';
    switch (tt) {
      case 0:
        hint = '昨天' + hint;
        break;
      case 1:
        hint = '今天' + hint;
        break;
      case 2:
        hint = '累计' + hint;
        break;
      default:
    }
    AppToast.showToast(hint);
  }

  _getPowerDataUI(int pt, PowerModel pm) {
    //pt 类型,0昨天，1今天，2统计
    return GestureDetector(
      child: Container(
        height: double.infinity,
        width: double.infinity,
        // color: Colors.deepOrangeAccent,
        padding: EdgeInsets.only(
          top: 4.5,
          bottom: 4.5,
          right: 5.0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: double.infinity,
              alignment: Alignment.centerRight,
              child: Text(
                // '20:13',
                // DateTimeHelper.getHMFromSec(_getRunTimes(pt, pm)),
                _getRunTimes(pt, pm),
                textAlign: TextAlign.end,
                style: TextStyle(
                  color: Colors.grey[400],
                  fontSize: 19.0,
                ),
              ),
            ),
            SizedBox(
              height: 8.0,
            ),
            Container(
              width: double.infinity,
              alignment: Alignment.centerRight,
              child: Text(
                //AppBO.getPower(_getRunTimes(pt, pm), pm.power),
                _getPower(pt, pm),
                textAlign: TextAlign.end,
                style: TextStyle(
                  color: Colors.grey[400],
                  fontSize: 19.0,
                ),
              ),
            ),
          ],
        ),
      ),
      onTap: () {
        _showPowerHint(pt);
      },
    );
  }

  _getRunTimes(pt, pm) {
    switch (pt) {
      case 0:
        return DateTimeHelper.getHMFromSec(pm.lasttimes);
        break;
      case 1:
        return DateTimeHelper.getHMFromSec(pm.todaytimes);
        break;
      case 2:
        return (pm.runtimes / 3600).toStringAsFixed(0);
        break;
    }
    return '0';
  }

  _getPower(pt, pm) {
    switch (pt) {
      case 0:
        return pm.lastpower.toStringAsFixed(1);
        break;
      case 1:
        return pm.todaypower.toStringAsFixed(1);
        break;
      case 2:
        return pm.totalpower.toStringAsFixed(1);
        break;
    }
    return 0;
  }

  _getDeviceUI() {
    return Container(
      margin: const EdgeInsets.fromLTRB(dLeft, dTop, dLeft, dTop),
      height: 120,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(color: _getStateColor(0), width: 1.0),
        color: Colors.transparent, //此处与主色 color 属性不能同时出现，否则报错
        // borderRadius:BorderRadius.vertical(top:Radius.circular(20.0),bottom: Radius.circular(20.0)),
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
      child: Row(children: <Widget>[
        Container(
          width: 6,
          decoration: BoxDecoration(
            border: Border.all(
                color: _getStateColor(0), width: 3.0, style: BorderStyle.solid),
            borderRadius: BorderRadius.horizontal(
              left: Radius.circular(5.0),
              //right: new Radius.circular(20.0),
            ),
            // color: _getBorderColor(), //Colors.green,
          ),
        ),
        _getDeviceInfoUI(),
        Expanded(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: _getControlPanelGroupUI())),
      ]),
    );
  }

  // _getTotalState() {
  //   int iv = 0;
  //   _cpState.forEach((k, v) {
  //     if (v == 1) {
  //       iv = iv + v;
  //       // return AppStyle.cpOpenColor;
  //     }
  //   });
  //   if (iv > 0)
  //     return 1;
  //   else
  //     return 0;
  // }

  Color _getStateColor(tn) {
    if (dstate == 0) return AppStyle.cpCloseColor;

    switch (tn) {
      case 0:
        return AppStyle.cpOpenColor;
        break;
      case 1:
        return AppStyle.mainColor;
        break;
      case 2:
        return Colors.redAccent;
        break;
    }
    return AppStyle.cpOpenColor;
  }

  Color _getBorderStateColor(tn) {
    // print('@@@ tn : $tn');
    if (dstate == 0) return Colors.transparent;

    switch (tn) {
      case 0:
        return Colors.transparent;
        break;
      case 1:
        return AppStyle.mainColor;
        break;
      case 2:
        return Colors.redAccent;
        break;
    }
    return Colors.transparent;
  }

  Color _getLineStateColor(tn) {
    if (dstate == 0) return AppStyle.clSplitterLineColor;

    switch (tn) {
      case 0:
        return AppStyle.clSplitterLineColor;
        break;
      case 1:
        return AppStyle.mainColor;
        break;
      case 2:
        return Colors.redAccent;
        break;
    }
    return AppStyle.clSplitterLineColor;
  }

  // Color _getBorderColor() {
  //   if (_cpState.length == 0) {
  //     // print('@@@ _getBorderColor ${widget.deviceModel.id} _cpState.length : 0');
  //     return AppStyle.cpCloseColor; //Colors.grey[300]; Colors.green
  //   }

  //   int iv = 0;
  //   _cpState.forEach((k, v) {
  //     if (v == 1) {
  //       iv = iv + v;
  //       // return AppStyle.cpOpenColor;
  //     }
  //   });

  //   print('@@@ _getBorderColor did : ${widget.deviceModel.id}, v : $iv');

  //   if (iv == 0)
  //     return AppStyle.cpCloseColor;
  //   else
  //     return AppStyle.cpOpenColor;
  // }

  // Color _getImageColor() {
  //   if (_cpState.length == 0) {
  //     // print('@@@ _getBorderColor ${widget.deviceModel.id} _cpState.length : 0');
  //     return AppStyle.cpCloseColor; //Colors.grey[300]; Colors.green
  //   }

  //   int iv = 0;
  //   _cpState.forEach((k, v) {
  //     if (v == 1) {
  //       iv = iv + v;
  //       // return AppStyle.cpOpenColor;
  //     }
  //   });

  //   // print('@@@ _getBorderColor did : ${widget.deviceModel.id}, v : $iv');

  //   if (iv == 0)
  //     return AppStyle.cpCloseColor;
  //   else
  //     return null; // Colors.white;
  // }

  _getControlPanelGroupUI() {
    int ef = 6;
    List<Widget> _lst = new List<Widget>();
    _lst.add(
      Expanded(
        // flex: ef,
        child: Container(
          child: Text(''),
        ),
      ),
    );

    // int _ll = widget.deviceModel.lstCP.length;
    for (int i = 0; i < 3; i++) {
      int indexno = i + 1;
      var cpm = _getControlPanelByIndex(indexno);
      // print("cpm : $cpm");
      if (cpm == null)
        _lst.add(_getNullControlPanelUI(widget.deviceModel, indexno));
      else {
        _lst.add(_getControlPanelUI(widget.deviceModel, cpm, indexno));
      }
      // if (i >= _ll) {
      //   _lst.add(_getNullControlPanelUI(widget.deviceModel, i + 1));
      // } else {
      //   ControlPanelModel cpm = widget.deviceModel.lstCP[i];
      //   _lst.add(_getControlPanelUI(widget.deviceModel, cpm, i + 1));
      // }

      if (i < 2)
        _lst.add(SizedBox(
          width: 10.0,
        ));
    }

    _lst.add(
      Expanded(
        // flex: ef,
        child: Container(
          child: Text(''),
        ),
      ),
    );

    return _lst;
  }

  _getControlPanelByIndex(int index) {
    var ret;
    widget.deviceModel.lstCP.forEach((cpm) {
      // print("cpm.indexno : ${cpm.indexno} / $index");
      if (cpm.indexno == index) {
        ret = cpm;
      }
    });
    return ret;
  }

  _getDeviceInfoUI() {
    return Container(
      width: 80,
      // color: Colors.lightGreen,
      margin: EdgeInsets.only(right: 5.0),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border(
            right: BorderSide(color: Colors.grey[300], width: 1.0)), //灰色的一层边框
        color: Colors.white,
        // borderRadius: BorderRadius.all(Radius.circular(12.0)),
      ),
      child: Column(children: <Widget>[
        // Text(widget.deviceModel.model?.toString()),
        // Expanded(
        // flex: 1,
        GestureDetector(
          child: Padding(
              padding: EdgeInsets.fromLTRB(0, 12, 0, 2),
              child: Image.network(
                GlobalVar.webimageurl + widget.deviceModel.icon,
                height: 45,
                fit: BoxFit.fill,
                color: _getStateColor(1),
                // colorBlendMode: BlendMode.clear,
              )),
          onTap: () {
            // print("@@@ widget.deviceModel.id : ${widget.deviceModel.id}");
            // _showDeviceDetail();
            eventBus.fire(DeviceEvent("detail", widget.deviceModel, 0));
          },
        ),
        GestureDetector(
          child: Container(
            alignment: Alignment.center,
            // color: Colors.greenAccent,
            child: Text(
              widget.deviceModel.name?.toString(),
              style: TextStyle(color: Colors.grey, fontSize: 16),
            ),
            height: 28,
          ),
          onTap: () {
            // print("@@@ widget.deviceModel.id : ${widget.deviceModel.id}");
            // _showDeviceDetail();
            eventBus.fire(DeviceEvent("detail", widget.deviceModel, 0));
          },
        ),
        Container(
          // alignment: Alignment.topCenter,
          // color: Colors.orangeAccent,
          decoration: BoxDecoration(
            border: Border(
                top: BorderSide(color: Colors.grey[100], width: 1.0)), //灰色的一层边框
            // color: Colors.orangeAccent,
            // borderRadius: BorderRadius.all(Radius.circular(12.0)),
          ),
          child: Row(children: <Widget>[
            Expanded(
                child: IconButton(
              padding: EdgeInsets.all(0.0),
              icon: Icon(
                Icons.power_settings_new,
                size: 22,
                color: _getStateColor(2), // Colors.grey[300],
                // color: Colors.red,
                // textDirection: TextDirection.ltr,
              ),
              // iconSize: 24,
              onPressed: () {
                // print("@@@ _getDeviceUI.add(" + widget.deviceModel.id + ")");
                AppDialog.showSelectTextItemIOS(
                    context, ["关闭所有烤炉", "开启所有烤炉", "取消"], (item) {
                  _closeAll(item);
                });
              },
            )),
            SizedBox(
              width: 1.0,
              child: Container(color: Colors.grey[100]),
            ),
            Expanded(
                child: IconButton(
                    padding: EdgeInsets.all(0.0),
                    icon: Icon(
                      Icons.clear,
                      color: Colors.grey[300],
                    ),
                    iconSize: 22,
                    onPressed: () {
                      // print("@@@ _getDeviceUI.delete(" +
                      //     deviceModel.id +
                      //     ")");
                      eventBus
                          .fire(DeviceEvent("delete", widget.deviceModel, 0));
                      // _deleteDevice(widget.deviceModel.id);
                    })),
          ]),
          height: 31,
        ),
      ]),
    );
  }

  _closeAll(item) {
    print("@@@ _getDeviceUI._closeAll($item) did : ${widget.deviceModel.id}");
    if (item == '0') {
      //关闭
      widget.deviceModel.lstCP.forEach((cpm) {
        if (cpm.state == 1)
          GlobalVar.sendOrder("/oven/device/" + cpm.uuid, '{"state":0}');
      });
    }

    if (item == '1') {
      //启动r
      widget.deviceModel.lstCP.forEach((cpm) {
        if (cpm.state == 0)
          GlobalVar.sendOrder("/oven/device/" + cpm.uuid, '{"state":0}');
      });
    }
  }

  _getControlPanelUI(dm, cpm, index) {
    return ControlPanelUnit(
        key: UniqueKey(),
        deviceModel: dm,
        controlPanelModel: cpm,
        index: index);
  }

  _getNullControlPanelUI(deviceModel, index) {
    final double dM = 5.0;
    return
        // Expanded(
        //   flex: 20,
        //   child:
        Container(
      width: TemplateBO.dControlPanelUnitWidth,
      constraints: BoxConstraints(
        minWidth: 75.0,
      ),
      alignment: Alignment.center,
      margin: EdgeInsets.fromLTRB(0, dM, 0.0, dM),
      decoration: BoxDecoration(
        // border: Border(
        //     right: BorderSide(color: Colors.grey[300], width: 1.0)), //灰色的一层边框
        border: Border.all(color: AppStyle.cpCloseColor, width: 1.0),
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
              padding: EdgeInsets.all(0.0),
              icon: Icon(
                Icons.add,
                color: Colors.grey[400],
              ),
              iconSize: 28,
              onPressed: () {
                // print("@@@ DeviceBO.add CP did : ${deviceModel.id}");
                // eventBus.fire(DeviceEvent("addcp", deviceModel.id));
                // _addControlPanel(deviceModel.id);
                // _getUuid(deviceModel);
                eventBus.fire(DeviceEvent("addcp", widget.deviceModel, index));
                // _getControlPanelNo(deviceModel);
              }),
          Text(
            _getLiTitle(index),
            style: TextStyle(
              fontFamily: AppStyle.ffPF,
              color: Colors.grey[400],
              fontSize: 17.0,
            ),
          ),
        ],
      ),
    );
  }

  _getLiTitle(index) {
    var sret = '';
    switch (index) {
      case 1:
        sret = '上层';
        break;
      case 2:
        sret = '中层';
        break;
      case 3:
        sret = '下层';
        break;
      default:
        sret = '第 $index 层';
        break;
    }
    return sret;
  }

  // void _showDeviceDetail() {
  //   print("@@@ widget.deviceModel.id : ${widget.deviceModel.id}");

  //   //此法无效，弹出前后父页均被 build 了
  //   // eventBus.fire(CallPageEvent("devicedetail",widget.deviceModel.id,"0"));
  //   // Navigator.of(context).pushNamed("/devicedetail",arguments:{"id":widget.deviceModel.id});
  //   Navigator.push(
  //       context,
  //       new MaterialPageRoute(
  //           builder: (context) =>
  //               new DeviceDetailPage(deviceModel: widget.deviceModel)));

  //   //Get.to(DeviceDetailPage(id:widget.deviceModel.id));//.toNamed("");
  //   // Get.toNamed("/devicedetail",arguments: {"id":widget.deviceModel.id});
  // }
}
