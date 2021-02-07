import 'dart:async';

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:wakelock/wakelock.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// import 'package:image_picker/image_picker.dart';
// import 'package:ovenapp/BusinessObjects/DeviceBO.dart';
import 'package:ovenapp/BusinessObjects/DialogBO.dart';
// import 'package:ovenapp/BusinessObjects/ScanBO.dart';
import 'package:ovenapp/BusinessObjects/TemplateBO.dart';
import 'package:ovenapp/Classes/AppDialog.dart';
import 'package:ovenapp/Classes/AppToast.dart';
import 'package:ovenapp/Classes/FileLoadHelper.dart';
// import 'package:ovenapp/Classes/MediaPlayer.dart';
import 'package:ovenapp/Classes/SharePrefHelper.dart';
import 'package:ovenapp/Controls/AppImage.dart';
// import 'package:ovenapp/Controls/AppWidget.dart';
import 'package:ovenapp/Models/ControlPanelModel.dart';
// import 'package:ovenapp/Models/DeviceModel.dart';
import 'package:ovenapp/Models/HttpRetModel.dart';
import 'package:ovenapp/Models/MqttDataModel.dart';
import 'package:ovenapp/Models/SectionTimeModel.dart';
import 'package:ovenapp/Models/TemplateModel.dart';
import 'package:ovenapp/Models/UpDownFireModel.dart';
import 'package:ovenapp/Pages/SelectTemplateList.dart';
// import 'package:ovenapp/Pages/TemplateListPage.dart';
// import 'package:ovenapp/Pages/TemplatePage.dart';

import 'package:ovenapp/Publics/AppStyle.dart';
import 'package:ovenapp/Publics/DataHelper.dart';
import 'package:ovenapp/Publics/GlobalVar.dart';
import 'package:ovenapp/Services/EventBusSrv.dart';
// import 'package:ovenapp/Services/HttpCallerSrv.dart';

// GlobalKey<_ControlPanelPageState> cpKey = GlobalKey();
// GlobalKey<_ControlPanelPageState> cp1Key = GlobalKey<_ControlPanelPageState>();
// GlobalKey<_ControlPanelPageState> cp2Key = GlobalKey<_ControlPanelPageState>();
// GlobalKey<_ControlPanelPageState> cp3Key = GlobalKey<_ControlPanelPageState>();

class ControlPanelPage extends StatefulWidget {
  ControlPanelPage({Key key, this.controlPanelModel}) : super(key: key);

// final DeviceModel deviceModel;this.deviceModel,
  final ControlPanelModel controlPanelModel;
  // final String id;this.id,
  // final int index;, this.index
  // final String devicename;, this.devicename
  // final String uuid; , this.uuid

  @override
  _ControlPanelPageState createState() => _ControlPanelPageState();
}

class _ControlPanelPageState extends State<ControlPanelPage>
    with AutomaticKeepAliveClientMixin<ControlPanelPage> {
  @override
  bool get wantKeepAlive => true;
  TemplateModel curTemplateModel;

  // String _localImageFile; //本地文件，中途更换图片时专用，
  // var _onMqttPayloadEvent;
  var _onControlPanelDataEvent;
  var _onSaveTemplateEvent;
  final double dRadius = 5.0;
  final double dL = 10.0;
  final double dR = 10.0;
  final double dSperator = 4.0; //按钮间距
  double dButtonLineHeight = 120.0;
  double dButtonWidth = 24.0;
  double dSectionHeight = 25.0;
  double d3Height = 117.0; //中间可变区域三分之一的高度
  double dTitleHeight = 30.0;

  String uuid;
  // ControlPanelModel controlPanelModel;

  final StreamController<MqttDataModel> _streamController =
      StreamController<MqttDataModel>();

  MqttDataModel curMqttData = MqttDataModel.getEmptyModel();

  int cpstate = 2;
  int templateid = -1;
  int sectionid = -1;

  Color clIdleFC = Colors.grey[400];
  Color clWorkFC = Color(0xFF2D2D2D); //Colors.black87;
  Color clActiveFC = Colors.green[500];

  String tempName = ''; //程序分段：
  String cpIcon = 'camera.png';
  // String _localImage;
  static int _lastTemplateID = -1;

  @override
  void initState() {
    super.initState();

    Wakelock.enable();

    print("@@@ => ControlPanelPage.initState() ...");
//  controlPanelModel.icon : ${widget.controlPanelModel.icon}
    GlobalVar.isControlPanelOpen = true;

    uuid = "/" + widget.controlPanelModel.uuid;

    cpIcon = widget.controlPanelModel.icon;

    _onSaveTemplateEvent = eventBus.on<SaveTemplateEvent>().listen((event) {
      // print(
      //     "@@@ => ControlPanelPage._onSaveTemplateEvent() ... widget.controlPanelModel.indexno : ${widget.controlPanelModel.indexno} , event.index : ${event.index}");
      if (widget.controlPanelModel.indexno == event.index) _addTemplate();
    });

    _onControlPanelDataEvent =
        eventBus.on<ControlPanelDataEvent>().listen((event) {
      if (event == null ||
          event.uuid == null ||
          widget.controlPanelModel.uuid != event.uuid) return;

      MqttDataModel mm = GlobalVar.mpMqttData[event.uuid];

      if (_lastTemplateID == -1) {
        // _lastTemplateID = mm.tn;
      } else {
        if (_lastTemplateID != mm.tn && mm.tn == 0) {
          curTemplateModel = null;
        }
      }
      _lastTemplateID = mm.tn;

      // if (mm.tn == 0)
      //   cpIcon = widget.controlPanelModel.icon;
      // else {
      //   if (GlobalVar.lstTemplate != null) {
      //     // if (GlobalVar.lstTemplate != null) {
      //     TemplateModel tm = GlobalVar.lstTemplate[curMqttData.tn];
      //     // if (tempPic != null) picfile = tempPic.toString();
      //     if (tm != null && tm.mainpic != null) cpIcon = tm.mainpic;
      //     // }
      //   } else
      //     cpIcon = widget.controlPanelModel.icon;
      // }

      _streamController.sink.add(mm);
    });

    dButtonWidth = (AppStyle.screenSize.width - 2 * dL - 5 * dSperator) / 6;
    dButtonLineHeight = dButtonWidth * 2 + dSperator;

    d3Height =
        (GlobalVar.dScreenHeight - 100.0 - dButtonLineHeight - dTitleHeight) /
            3;

    print(
        "@@@ => ControlPanelPage._onSaveTemplateEvent() ... d3Height : $d3Height");
  }

  @override
  void dispose() {
    super.dispose();
    Wakelock.disable();
    // _onMqttPayloadEvent.cancel();
    _streamController.close();
    _onControlPanelDataEvent.cancel();
    _onSaveTemplateEvent.cancel();
    GlobalVar.isControlPanelOpen = false;

    GlobalVar.closeWarnAudio();
    print("@@@ ControlPanelPage.dispose() ...");
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    // d3Height = (GlobalVar.dScreenHeight -
    //         MediaQuery.of(context).padding.top -
    //         dButtonLineHeight -
    //         dTitleHeight) /
    //     3;
    // dButtonWidth = (AppStyle.screenSize.width - 2 * dL - 5 * dSperator) / 6;
    // dButtonLineHeight = dButtonWidth * 2 + dSperator;
    // double dsw = AppStyle.screenSize.width;
    // double dsh = AppStyle.screenSize.height;
    print(
        "@@@ => ControlPanelPage.build() ... top : ${MediaQuery.of(context).padding.top} ");
    // print(
    //     "@@@ => screenSize.width:{$dsw} - screenSize.height:{$dsh} / dButtonWidth:{$dButtonWidth} - ButtonLineHeight:{$dButtonLineHeight}");
// print("@@@ => ControlPanelPage.build() w:{} h:{}");
    return StreamBuilder<MqttDataModel>(
        stream: _streamController.stream,
        initialData: curMqttData,
        builder: (BuildContext context, AsyncSnapshot<MqttDataModel> snapshot) {
          curMqttData = snapshot.data;
          return Scaffold(
            // key: cpKey,
            resizeToAvoidBottomInset: false,
            //标题栏
            // appBar:
            //     // PreferredSize(
            //     //   child:
            //     AppBar(
            //   backgroundColor: AppStyle.clTitleBC,
            //   title: Text(_getOvenNo()),
            //   actions: _getActions(),
            // ),
            //   preferredSize: AppStyle.getAppBarHeight(),
            // ),
            //主界面

            body: Column(children: <Widget>[
              //标题
              _getTitle(),
              //中间数据
              Expanded(
                child: _getCenter(),
              ),
              //上下火
              _getUDFire(),
              //按钮组
              _getButtonGroup(),
            ]), // This trailing comma makes auto-formatting nicer for build methods.
          );
        });
  }

  // _showWarn() {
  //   GlobalVar.playWarnAudio(context, curMqttData.uuid);
  // }

  // _getOvenNo() {
  //   switch (widget.controlPanelModel.indexno) {
  //     case 0:
  //       return "上炉";
  //       break;
  //     case 1:
  //       return "中炉";
  //       break;
  //     case 2:
  //       return "下炉";
  //       break;
  //     case 3:
  //       return "第四炉";
  //       break;
  //     default:
  //       return "尾炉";
  //       break;
  //   }
  // }

  List<Widget> _getActions() {
    return <Widget>[
      // IconButton(
      //     icon: Icon(Icons.save),
      //     color: AppStyle.clTitle2FC,
      //     iconSize: 28.0,
      //     onPressed: () {
      //       _addTemplate();
      //     }),
      PopupMenuButton(
          color: AppStyle.mainBackgroundColor,
          onSelected: (String value) {
            print("@@@ Selected : " + value);
            switch (value) {
              case "0":
                _addTemplate();
                break;
              case "2":
                // _setWifi();
                break;
              case "3":
                // _sendTemplate();
                break;
            }
          },
          itemBuilder: (BuildContext context) => <PopupMenuItem<String>>[
                // new PopupMenuItem(value: "5", child: new Text("模板列表")),
                PopupMenuItem(value: "0", child: Text("存为模板")),
                // new PopupMenuItem(value: "1", child: new Text("载入模板")),
                PopupMenuItem(value: "1", child: Text("报修")),
                PopupMenuItem(value: "2", child: Text("初始化 WIFI")),
                PopupMenuItem(value: "3", child: Text("设置 WIFI")),
                PopupMenuItem(value: "4", child: Text("帮助")),
              ]),
    ];
  }

  _popMenu(context) {
    // RenderBox box = context.findRenderObject();
    // Offset offset = box.localToGlobal(Offset.zero);
    // Size size = box.size;
    // double l = offset.dx + size.width / 4;
    // double t = offset.dy + size.height / 3;
    double dTop = MediaQueryData.fromWindow(window).padding.top + 56.0;
    print("_popMenu() dTop : $dTop");
    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(1000.0, dTop, 0.0, 0.0),
      items: <PopupMenuItem<String>>[
        PopupMenuItem(value: "0", child: new Text("全部")),
        PopupMenuItem(value: "1", child: Text("模板")),
        PopupMenuItem(value: "2", child: Text("心得")),
        // PopupMenuItem(value: "3", child: Text("打印列表")),
      ],
      // items: <PopupMenuEntry>[
      //   PopupMenuItem(value: "0", child: Text("移除")),
      //   PopupMenuDivider(),
      // ],
    ).then((v) {
      // ft=int.parse(v);
      // _refreshData();

      // // print("selected : $v");
      // if (v == "0") {
      //   // print("position ：${_controller.position.pixels}");
      //   SharePrefHelper.removeData(spfile);
      //   // _streamController.sink.add(_controller.position.pixels);
      // } else if (v == "1") {
      //   // print("position ：${_controller.position.pixels}");
      //   _getData();
      //   // _streamController.sink.add(_controller.position.pixels);
      // } else if (v == "2") {
      //   // print("position ：${_controller.position.pixels}");
      //   _getSP();
      //   // _streamController.sink.add(_controller.position.pixels);
      // } else if (v == "3") {
      //   print("_lstData.length : ${_lstData?.length}");
      //   // _streamController.sink.add(_controller.position.pixels);
      // }
    });
    // print("_popMenu");
    // return PopupMenuButton(
    //   itemBuilder: (context) => <PopupMenuItem<String>>[
    //     new PopupMenuItem(value: "0", child: new Text("选项一")),
    //     new PopupMenuItem(value: "1", child: new Text("选项二"))
    //   ],
    //   onSelected: (value) {
    //     print("onSelected");
    //   },
    //   onCanceled: () {
    //     print("onCanceled");
    //   },
    // );
  }

  _addTemplate() {
    AppDialog.showTextFieldIOS(context, '请输入模板名称', '模板名称', (ret) {
      if (ret == null || ret.toString().trim() == '') return;

      Map<String, dynamic> param = {
        "Name": ret,
        "ClientControlPanel_ID": widget.controlPanelModel.id,
        "IndexNo": 1,
        "Timer": curMqttData.timer[0],
        "UpS": curMqttData.ups,
        "UpTemp": curMqttData.up[0],
        "UpPower": curMqttData.up[2],
        "DownS": curMqttData.downs,
        "DownTemp": curMqttData.down[0],
        "DownPower": curMqttData.down[2],
        "SteamT": curMqttData.steamt[0],
        "IID": widget.controlPanelModel.iid,
        // "EditType": edittype,
      };

      DataHelpr.dataHandler('Template/Add', param, (rm) {
        print(
            '@@@ ControlPanelPage._addTemplate  rm.ret : ${rm.ret} , rm.id : ${rm.message}');

        DataHelpr.resultHandler(rm, () {
          // print('@@@ ControlPanelPage._addTemplate rm.id : ${rm.id}');

          _insertTemplate(rm, ret, param);
        });
      });
    });
  }

  _insertTemplate(rm, name, param) async {
    int tid = int.parse(rm.id);
    TemplateModel tm = TemplateModel(
        id: tid,
        name: name,
        ccpid: widget.controlPanelModel.id,
        mainpic: 'camera.png',
        cid: GlobalVar.userInfo.id,
        memo: '模板说明 ...',
        cname: GlobalVar.userInfo.name,
        createdt: DateTime.now().toString());
    tm.lstSection = [];
    tm.lstRecipe = [];
    tm.lstDescribe = [];

    SectionTimeModel sm = SectionTimeModel(
      id: rm.pageno,
      timer: param["Timer"],
      ups: param["UpS"],
      uptemp: param["UpTemp"],
      uppower: param["UpPower"],
      downs: param["DownS"],
      downtemp: param["DownTemp"],
      downpower: param["DownPower"],
      steamt: param["SteamT"],
      tn: tid,
      sn: 1,
      tid: tid,
    );

    tm.lstSection.add(sm);

    TemplateBO.cleanCache();

    if (GlobalVar.lstTemplate == null) GlobalVar.lstTemplate = {};
    GlobalVar.lstTemplate[tid] = tm;
    // print('@@@ ControlPanelPage._addTemplate tm.id : ${tm.id}');

    TemplateBO.showTemplatePage(context, tm);
    // Navigator.push(context,
    //     MaterialPageRoute(builder: (context) => TemplatePage(id: tid)));
  }

  // _addTemplateFail(String err) {
  //   print('@@@ _addTemplateFail ret : $err');
  //   AppToast.showToast("新增模板失败：$err", 2);
  // }

  // _setWifi() {
  //   print("@@@ _setWifi() 设置WIFI参数");
  //   String orderstr = '{"state":"getWifi"}';
  //   _sendOrder(orderstr);
  // }

  // _sendTemplate() {
  //   print("@@@ _sendTemplate() 发送模板命令");
  //   String orderstr = '{"plan":[' +
  //       '{"timer":1,"up":[250,2],"down":[210,5],"steams":1,"steam":281,"steamt":[3,5],"tn":1,"sn":1},' +
  //       '{"timer":2,"up":[251,3],"down":[220,6],"steams":1,"steam":282,"steamt":[4,6],"tn":1,"sn":2},' +
  //       '{"timer":1,"up":[252,4],"down":[230,7],"steams":1,"steam":283,"steamt":[5,7],"tn":1,"sn":3},' +
  //       '{"timer":2,"up":[253,5],"down":[240,8],"steams":1,"steam":284,"steamt":[6,8],"tn":1,"sn":4},' +
  //       '{"timer":1,"up":[254,6],"down":[250,9],"steams":1,"steam":285,"steamt":[7,9],"tn":1,"sn":5}' +
  //       ']}';

  //   _sendOrder(orderstr);

  //   Timer(Duration(seconds: 3), () {
  //     print("@@@ _sendTemplate() 执行模板命令 =>");
  //     _sendOrder('{"state":4}');
  //   });
  // }
  _getLayerText() {
    var sret = '';
    switch (widget.controlPanelModel.indexno) {
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
        sret = '第 ${widget.controlPanelModel.indexno} 层';
        break;
    }
    return sret;
  }

  _getTitle() {
    return Container(
      height: dTitleHeight,
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.fromLTRB(dL, 15, dR, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            widget.controlPanelModel.devicename +
                "." +
                widget.controlPanelModel.name,
            style: TextStyle(
                fontSize: ScreenUtil().setSp(19.0), color: Colors.black),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0.0, 0.0, 5.0, 0.0),
            child: Text(
              _getLayerText(),
              style: TextStyle(
                fontSize: ScreenUtil().setSp(18.5),
                color: Colors.orange[900],
                fontFamily: AppStyle.ffPF,
              ),
            ),
          ),
          // SizedBox(
          //   width: 5.0,
          // ),
        ],
      ),
    );
  }

  _getCenter() {
    return Container(
      // height: 200,
      margin: EdgeInsets.fromLTRB(dL, 0, dR, 0),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: Colors.black, width: 1.2),
          bottom: BorderSide(color: Colors.black, width: 1.2),
        ), //灰色的一层边框
        // color: Colors.yellowAccent,
        // borderRadius: BorderRadius.all(Radius.circular(0.0)),
      ),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            //左边栏
            Expanded(child: _getLeftContent()),

            //右边栏
            _getRightContent(),
          ]),
    );
  }

  _getSteamClock() {
    return Container(
      // height: 80,
      alignment: Alignment.bottomCenter,
      margin: EdgeInsets.fromLTRB(0, 0, dR, 0),
      // padding: EdgeInsets.only(
      //   bottom: 3.0,
      // ),
      decoration: BoxDecoration(
        border: Border(
            bottom: BorderSide(color: Colors.black, width: 1.0)), //灰色的一层边框
        // color: Colors.white,
        // borderRadius: BorderRadius.all(Radius.circular(0.0)),
      ),
      child: Row(children: <Widget>[
        Expanded(
          // flex: 4,
          child: GestureDetector(
            child: Container(
              alignment: Alignment.center,
              child: Text(
                // "120",
                _getSteamt(),
                style: TextStyle(
                  fontSize: ScreenUtil().setSp(44),
                  color: curMqttData.state == 0
                      ? clIdleFC
                      : clWorkFC, // Color(0xFF2D2D2D),
                  fontWeight: FontWeight.bold,
                  fontFamily: "Arial",
                ),
              ),
            ),
            onTap: () {
              _setSteamt();
            },
          ),
        ),

        //单位 秒
        Container(
          width: ScreenUtil().setWidth(26.0),
          alignment: Alignment.centerLeft,
          child: Text(
            "sec",
            style: TextStyle(
              fontSize: ScreenUtil().setSp(16), //16,
              color: curMqttData.state == 0 ? clIdleFC : clWorkFC,
            ),
          ),
          // color: Colors.redAccent, color: Colors.black
        ),

        //小温度计图标
        Container(
          alignment: Alignment.bottomRight,
          width: ScreenUtil().setWidth(18.0),
          // height: 40.0,
          padding: EdgeInsets.only(
            bottom: 6.0,
          ),
          child: Image.asset(
            "images/thermometer.png",
            height: ScreenUtil().setHeight(40.0),
            color: curMqttData.state == 0 ? clIdleFC : clWorkFC,
          ),
          // color: Colors.blueAccent,
        ),

        //蒸汽温度
        GestureDetector(
          child: Container(
            alignment: Alignment.bottomRight,
            width: ScreenUtil().setWidth(60.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Container(
                    height: ScreenUtil().setHeight(24.0),
                    alignment: Alignment.centerRight,
                    child: Text(
                      // "180℃",
                      _getSteam("real"),
                      style: TextStyle(
                        fontSize: ScreenUtil().setSp(18),
                        color: curMqttData.state == 0
                            ? AppStyle.clTitleBC
                            : AppStyle.mainColor,
                        fontFamily: "Arial",
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    height: ScreenUtil().setHeight(25.0),
                    child: Text(
                      // "200℃",
                      _getSteam("set"),
                      style: TextStyle(
                        fontSize: ScreenUtil().setSp(18.0),
                        color: curMqttData.state == 0 ? clIdleFC : clWorkFC,
                        fontFamily: "Arial",
                      ),
                    ),
                  ),
                ]),
            // color: Colors.cyanAccent,
          ),
          onTap: () {
            _setSteamTemp();
          },
        ),
      ]),
    );
  }

  _setSteamt() {
    print("@@@ 设置蒸汽进汽时间 ...");
    DialogBO.showSteamTimeIOS(context, curMqttData.steamt[0], (sec) {
      int secv = int.parse(sec);
      String orderstr = '{"steamt":$secv}';
      print("@@@ orderstr : $orderstr");
      GlobalVar.mqttClass.publishMessage("/oven/device" + uuid, orderstr);
    });
  }

  _getSteam(String t) {
    return t == "real"
        ? (curMqttData.steams == 1 ? curMqttData.steam[1].toString() + "℃" : "")
        : curMqttData.steam[0].toString() + "℃";
  }

  _getSteamt() {
    if (curMqttData.steamt == null) {
      return '0';
    }
    // if (curMqttData.steams == 0)
    //   // return (curMqttData.steamt ?? 0 * 60).toString();
    //   return curMqttData.steamt[0].toString();
    else {
      return (curMqttData.steamt[0] - curMqttData.steamt[1]).toString();
    }
  }

  _getLeftContent() {
    return Column(children: <Widget>[
      //蒸汽时间
      _getIconText("蒸汽时间", "steam"),

      //蒸汽计时与温度
      Expanded(
        // flex: 18,
        child: _getSteamClock(),
      ),

      //烘焙时间
      _getIconText("烘焙时间", "hot"),

      //倒计时时间
      Expanded(
        // flex: 20,
        child: Container(
          // height: 40,
          alignment: Alignment.centerLeft,
          margin: EdgeInsets.only(left: 5.0),
          child: _getClockCenterWidget(),
        ),
      ),
    ]);
  }

  _setSteamTemp() {
    print("@@@ 设置蒸汽温度 ...");
    AppDialog.showSteamPramIOS(
        context, curMqttData.steams, curMqttData.steam[0] ?? 0 * 200, (m) {
      UpDownFireModel upm = m as UpDownFireModel;
      // String orderstr = '{"steam":${upm.temp.toInt()},"steams":${upm.isOpen}}';
      // print("@@@ orderstr : $orderstr");
      // GlobalVar.mqttClass.publishMessage("/oven/device" + uuid, orderstr);
      _sendOrder('{"steam":${upm.temp.toInt()}}');
      Timer(Duration(seconds: 1), () {
        _sendOrder('{"steams":${upm.isOpen}}');
      });
    });
  }

  _setCenterTemp() {
    print("@@@ 设置中心温度 ...");
    AppDialog.showCenterTempIOS(context, curMqttData.center[0] ?? 0 * 200,
        (temp) {
      String orderstr = '{"center":$temp}';
      print("@@@ orderstr : $orderstr");
      GlobalVar.mqttClass.publishMessage("/oven/device" + uuid, orderstr);
    });
  }

  _getClockCenterWidget() {
    if (curMqttData.state == 3 || cpstate == 3) {
      return GestureDetector(
        child: Row(children: <Widget>[
          //中心温度
          Expanded(
            // flex: 18,
            child: Container(
              margin: EdgeInsets.only(right: 12.0),
              alignment: Alignment.center,
              child: Text(
                // "333",
                curMqttData.center[0].toString(),
                style: TextStyle(
                    color: (curMqttData.state == 0
                        ? clIdleFC
                        : clWorkFC), //Color(0xFF2D2D2D),
                    fontSize: ScreenUtil().setSp(42.0),
                    fontFamily: "Arail",
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Container(
            width: 1.2,
            height: ScreenUtil().setHeight(24.0),
            color: Colors.black,
            margin: EdgeInsets.only(left: 0.0, right: 0.0),
          ),
          Expanded(
            // flex: 20,
            child: Container(
              margin: EdgeInsets.only(left: 10.0),
              alignment: Alignment.center,
              child: Text(
                // "220",
                curMqttData.center[1].toString(),
                style: TextStyle(
                    color: curMqttData.state == 0
                        ? AppStyle.clTitleBC
                        : AppStyle.mainColor,
                    fontSize: ScreenUtil().setSp(42.0),
                    fontFamily: "Arail",
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 0.0),
            alignment: Alignment.topLeft,
            child: Text(
              "℃",
              style: TextStyle(
                color: curMqttData.state == 0
                    ? AppStyle.clTitleBC
                    : AppStyle.mainColor,
                fontSize: ScreenUtil().setSp(30.0),
              ),
            ),
            // color: Colors.yellow,
          ),
        ]),
        onTap: () {
          // print("@@@ set center temperature");
          _setCenterTemp();
        },
      );
    } else {
      return GestureDetector(
        child: Text(
          // "09:47",
          _getClockTime(),
          style: TextStyle(
              fontSize: ScreenUtil().setSp(45.0),
              color: (curMqttData.state == 0
                  ? clIdleFC
                  : clWorkFC), // Color(0xFF2D2D2D),
              fontWeight: FontWeight.bold,
              fontFamily: "Arial"),
        ),
        onTap: () {
          _setClockTime();
        },
      );
    }
  }

  _setClockTime() {
    print("@@@ _setClockTime sec : $curMqttData.timer[0]");
    DialogBO.showClockTimeIOS(context, (sec) {
      String orderstr = '{"timer":$sec}';
      print("@@@ orderstr : $orderstr");
      GlobalVar.mqttClass.publishMessage("/oven/device" + uuid, orderstr);
    });
  }

  _getClockTime() {
    if (curMqttData.state == 3 || cpstate == 3) return;

    int sec = curMqttData.timer[0];
    if (curMqttData.timer[1] > 0) {
      sec = curMqttData.timer[1];
    }

    if (curMqttData.state == 2) {
      sec = curMqttData.timer[0] - curMqttData.timer[1];
    }

    if (sec < 60)
      return "00:" + sec.toString().padLeft(2, '0');
    else
      return (sec ~/ 60).toString().padLeft(2, '0') +
          ":" +
          (sec % 60).toString().padLeft(2, '0');
  }

  _getIconText(String title, String iconname) {
    return Container(
      height: ScreenUtil().setHeight(35.0),
      // color: Colors.tealAccent,
      alignment: Alignment.bottomCenter,
      margin: EdgeInsets.only(
        left: 5.0,
      ),
      child: Row(children: <Widget>[
        Icon(
          iconname == "steam" ? Icons.timelapse : Icons.timer,
          color: Colors.grey,
        ),
        Text(
          title,
          style: TextStyle(
            fontSize: ScreenUtil().setSp(16.0),
            color: Colors.grey,
          ),
        ),
      ]),
      // color: Colors.redAccent,
    );
  }

  // decoration: BoxDecoration(
  //   border:
  //       Border.all(color: Colors.red, width: 1.0), //灰色的一层边框grey[200]
  //   // color: Colors.white,
  //   borderRadius: BorderRadius.all(Radius.circular(5.0)),
  // ),
  _getRightContent() {
    return Container(
      width: AppStyle.screenSize.width / 2 - 2 * dL,
      // color: Colors.deepOrangeAccent,
      child: Column(children: <Widget>[
        //主图height: 128,width: 164,
        Expanded(
          child: GestureDetector(
            child: Padding(
              padding:
                  EdgeInsets.only(left: 5.0, top: dL, bottom: dL, right: 5.0),
              child: AspectRatio(
                aspectRatio: 4.0 / 3.0,
                // width: double.infinity,
                // color: Colors.blueGrey,
                // margin:
                //     EdgeInsets.only(left: 5.0, top: dL, bottom: dL, right: 5.0),
                child: ConstrainedBox(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5.0),
                    child: _getMainpicUI(),
                  ),
                  constraints: BoxConstraints.expand(),
                ),
              ),
            ),
            onTap: () {
              _setCPImage(context);
            },
          ),
        ),
        //程序分段

        // Container(
        //   alignment: Alignment.centerRight,
        //   margin: EdgeInsets.only(
        //     right: 5.0,
        //   ),
        //   height: dSectionHeight,
        //   child: Text("程序分段"),
        //   // color: Colors.lime,
        // ),

        //时段
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Container(
            height: dSectionHeight,
            // width: double.infinity,
            // color: Colors.pinkAccent,
            margin: EdgeInsets.only(
              right: 5.0,
            ),
            alignment: Alignment.centerRight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: _getSectionListUI(),
            ),
          ),
        ),
      ]),
    );
  }
  // Widget _cpImage = Text('图片');

  _getMainpicUI() {
    String _imageFile = cpIcon;
    // print('@@@ ControlPanelPage._getMainpicUI() cpIcon : $cpIcon');
    if (curTemplateModel != null) {
      _imageFile = curTemplateModel.mainpic;
      // return AppImage.rectImageUnSize(curTemplateModel.mainpic, dRadius);
    }

    if (_imageFile == 'oven.png' || _imageFile.endsWith('.webp')) {
      return AppImage.circleAssertImage(
          cpIcon, 60.0, 60.0, AppStyle.clBorderImage);
      // return AppWidget.getAssetImage(cpIcon, 60.0, Colors.grey[300]);
    }

    // if (GlobalVar.platForm == 0 && _localImage != null && _localImage != '') {
    //   // return Image.file(File(_localImage), fit: BoxFit.fitWidth);
    //   return AppImage.localImageUnSize(_localImage, dRadius);
    // }

    return AppImage.rectImageUnSize(_imageFile, dRadius);
  }

  List<Widget> _lstTemplateText = [];

  _getTempNameUI() {
    String sret = "";
    if (curMqttData.tn == 0 || tempName == null) {
      return Text(sret);
    } else {
      if (GlobalVar.lstTemplate != null &&
          GlobalVar.lstTemplate[curMqttData.tn] != null)
        sret = GlobalVar.lstTemplate[curMqttData.tn].name + ' :';
    }
    return Text(sret);
  }

  _getSectionListUI() {
    if (curTemplateModel == null) return _lstTemplateText;
    templateid = curTemplateModel.id;
    sectionid = curMqttData.sn;
    _lstTemplateText.clear();

    _lstTemplateText.add(Text(curTemplateModel.name));

    // if (templateid == 0 ||
    //     GlobalVar.lstTemplate == null ||
    //     GlobalVar.lstTemplate[curMqttData.tn] == null) return _lstTemplateText;

    int _ii = 1;
    // TemplateModel tm = GlobalVar.lstTemplate[curMqttData.tn];
    curTemplateModel.lstSection.forEach((sm) {
      _lstTemplateText.add(_getSectionUI(_ii));
      _ii++;
    });

    return _lstTemplateText;
    // print('@@@ _getSectionListUI() templateid : $templateid , sectionid : $sectionid , curMqttData.tn : ${curMqttData.tn} , curMqttData.sn : ${curMqttData.sn}');
    // if (templateid == curMqttData.tn && sectionid == curMqttData.sn)
    //   return _lstTemplateText;
    // templateid = curMqttData.tn;
    // sectionid = curMqttData.sn;
    // _lstTemplateText.clear();

    // _lstTemplateText.add(_getTempNameUI());

    // if (templateid == 0 ||
    //     GlobalVar.lstTemplate == null ||
    //     GlobalVar.lstTemplate[curMqttData.tn] == null) return _lstTemplateText;

    // int _ii = 1;
    // TemplateModel tm = GlobalVar.lstTemplate[curMqttData.tn];
    // tm.lstSection.forEach((sm) {
    //   _lstTemplateText.add(_getSectionUI(_ii));
    //   _ii++;
    // });

    // return _lstTemplateText;
  }

  _getSectionUI(index) {
    return Container(
      alignment: Alignment.center,
      height: ScreenUtil().setHeight(20.0),
      width: ScreenUtil().setWidth(20.0),
      child: Text(index.toString()),
      margin: EdgeInsets.only(left: 3.0),
      decoration: BoxDecoration(
        // border: Border.all(color: AppStyle.clTitleBC, width: 1.0),
        color:
            index == curMqttData.sn ? Colors.orangeAccent : AppStyle.clTitleBC,
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
        // borderRadius: BorderRadius.only(
        //   bottomLeft: Radius.circular(3.0),
        //   bottomRight: Radius.circular(3.0),
        //   topLeft: Radius.zero,
        //   topRight: Radius.zero,
        // ),
      ),
    );
  }

  _setCPImage(context) {
    var fparam = {
      "ot": 0,
      "tb": "ClientControlPanel",
      "rid": widget.controlPanelModel.id, //.replaceAll("/", ""),
      "fn": "Icon",
    };

    FileLoadHelper.selectPicture(context, fparam, (path) {
      // _localImage = path;
      // setState(() {});
    }, (f) {
      HttpRetModel rm = f as HttpRetModel; // HttpRetModel.getExecRet(f);
      print('@@@ ControlPanelPage._loadImage() rm : ${rm.message}');
      if (rm.ret == 0) {
        SharePrefHelper.removeData(GlobalVar.spdevice);
        widget.controlPanelModel.icon = rm.message;
        cpIcon = rm.message;

        // _localImage = null;
        setState(() {});
      } else {
        AppToast.showToast(rm.message);
      }
    });
  }

  _getUDFire() {
    return Container(
      margin: EdgeInsets.fromLTRB(dL, 2.0, dR, 2.0),
      height: d3Height,
      // color: Colors.tealAccent,
      child: Row(children: <Widget>[
        //温度计
        Container(
          padding: EdgeInsets.fromLTRB(0.0, ScreenUtil().setHeight(14.0), 0.0,
              ScreenUtil().setHeight(14.0)),
          height: double.infinity,
          child: Image.asset(
            "images/big_wdj.png",
            width:
                dButtonWidth, //ScreenUtil().setWidth(dButtonWidth), //dButtonWidth,
            // height: double.infinity,
            // height: ScreenUtil()
            //     .setHeight(dButtonLineHeight - 25), //dButtonLineHeight - 25,
            // fit:BoxFit.fill,
            // color: _getTIColor(), //Colors.black87,
            // color: Colors.black87,
          ),
        ),
        Expanded(
          child: Column(children: <Widget>[
            //上火
            _getUpDownFire("up"),

            //下火
            _getUpDownFire("down"),
          ]),
        ),
      ]),
    );
  }

  _getTIColor() {
    switch (curMqttData.state) {
      case 0:
        return Colors.grey[400];
        break;
      case 1:
        return AppStyle.mainColor;
        break;
      case 2:
        return Colors.red;
        break;
      case 3:
        return Colors.brown;
        break;
      default:
        return Colors.grey[400];
        break;
    }
  }

  _getUpDownFire(String t) {
    return Expanded(
      child: GestureDetector(
        child: Container(
          margin: t == "up"
              ? EdgeInsets.only(top: 6.0, right: 12.0)
              : EdgeInsets.only(bottom: 6.0, right: 12.0),
          child: Row(children: <Widget>[
            //上火
            Container(
              width: ScreenUtil().setWidth(48.0), //48.0,
              child: Image.asset(
                t == "down" ? "images/downfire3.png" : "images/upfire3.png",
                height: ScreenUtil().setWidth(36.0), //36.0,
                width: ScreenUtil().setWidth(32.0), // 32.0,
                // fit: BoxFit.fill,
                color: curMqttData.state == 0 ? Colors.grey[400] : Colors.red,
              ),
            ),
            Expanded(
              // flex: 18,
              child: Container(
                margin: EdgeInsets.only(right: 12.0),
                alignment: Alignment.centerRight,
                child: Text(
                  t == "up"
                      ? curMqttData.up[0].toString()
                      : curMqttData.down[0].toString(),
                  style: TextStyle(
                      color: curMqttData.state == 0
                          ? clIdleFC
                          : clWorkFC, //Color(0xFF2D2D2D),
                      fontSize: ScreenUtil().setSp(42.0), // 42.0,
                      fontFamily: "Arail",
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Container(
              width: 1.2,
              height: ScreenUtil().setHeight(24.0), // 24.0,
              color: Colors.black,
              margin: EdgeInsets.only(left: 8.0, right: 0.0),
            ),
            Expanded(
              // flex: 20,
              child: Container(
                margin: EdgeInsets.only(left: 12.0),
                alignment: Alignment.center,
                child: Text(
                  // "220",
                  t == "up"
                      ? curMqttData.up[1].toString()
                      : curMqttData.down[1].toString(),
                  style: TextStyle(
                      color: curMqttData.state == 0
                          ? clIdleFC
                          : AppStyle.mainColor,
                      fontSize: ScreenUtil().setSp(42.0), //42.0,
                      fontFamily: "Arail",
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 0.0),
              alignment: Alignment.topLeft,
              child: Text(
                "℃",
                style: TextStyle(
                  color: curMqttData.state == 0
                      ? AppStyle.clTitleBC
                      : AppStyle.mainColor,
                  fontSize: ScreenUtil().setSp(30.0),
                ),
              ),
              // color: Colors.yellow,
            ),
          ]),
        ),
        onTap: () {
          _setUpDownFire(t == "up" ? 0 : 1);
        },
      ),
    );
  }

  _setUpDownFire(index) {
    print("@@@ _setUpDownFire()");
    String fn = index == 0 ? 'ups' : 'downs';
    String fnt = fn.replaceAll('s', '');
// int isopen=curMqttData.ups;
// if(index==1) isopen=curMqttData.downs;
    AppDialog.showUpDownFireParamIOS(
        context,
        UpDownFireModel(
          index: index,
          temp:
              (index == 0 ? curMqttData.up[0].toDouble() : curMqttData.down[0])
                  .toDouble(),
          isOpen: (index == 0 ? curMqttData.ups : curMqttData.downs),
          power: (index == 0
              ? curMqttData.up[2].toDouble()
              : curMqttData.down[2].toDouble()),
        ), (m) {
      // print("@@@ m : ${m.tojson()}");
      UpDownFireModel mv = m as UpDownFireModel;
      // String orderstr =
      //     '{"$fnt":[${mv.temp.round()},${mv.power.round()}],"$fn":${mv.isOpen}}';
      // _sendOrder(orderstr);
      // print("@@@ orderstr : $orderstr");
      // GlobalVar.mqttClass.publishMessage("/oven/device" + uuid, orderstr);
      _sendOrder('{"$fnt":[${mv.temp.round()},${mv.power.round()}]}');
      Timer(Duration(seconds: 1), () {
        _sendOrder('{"$fn":${mv.isOpen}}');
      });
    });
  }

  _getButtonGroup() {
    return Container(
      height: dButtonLineHeight,
      margin: EdgeInsets.fromLTRB(dL, 0, dR, dL),
      // color: Colors.deepOrangeAccent,
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          //电源开关
          _getBigButton("power", "left"),

          //灯门
          _getButtons("light", "gate"),

          //中心放汽
          _getButtons("state", "gas"),

          //蒸汽风扇
          _getButtons("steams", "fan"),

          // 排气模板
          _getButtons("water", "temp"),

          //运行
          _getBigButton("run", "right"),
        ],
      ),
    );
  }

  _getButtons(String upname, String downname) {
    return Container(
      height: dButtonLineHeight,
      child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            _getButton(upname, "up"),
            _getButton(downname, "down"),
          ]),
    );
  }

  _getButton(String name, String bt) {
    return Container(
      height: dButtonWidth,
      width: dButtonWidth,
      margin: EdgeInsets.fromLTRB(dSperator / 2, bt == "up" ? 0 : dSperator / 2,
          dSperator / 2, bt == "up" ? dSperator / 2 : 0),
      // padding: EdgeInsets.only(
      //   bottom: 3.0,
      // ),
      decoration: BoxDecoration(
        // border: Border.all(
        // bottom: BorderSide(color: Colors.black, width: 1.0)), //灰色的一层边框
        color: Colors.black87,
        borderRadius: BorderRadius.all(Radius.circular(3.0)),
      ),
      child: IconButton(
        icon: Image.asset(
          "images/" + name + ".png",
          color: _getButtonColor(name),
        ),
        onPressed: () {
          // print("@@@ _changeIcon()");
          if (name == "temp")
            _selectTemplate();
          else
            _setOrder(name);
        },
      ),
    );
  }

  _selectTemplate() async {
    await TemplateBO.getTemplates();
    if (GlobalVar.lstTemplate == null || GlobalVar.lstTemplate.length == 0) {
      AppToast.showToast('您还没有可用的模板，请选添加模板！');
      return;
    }
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SelectTemplateList(
          iid: widget.controlPanelModel.iid,
          // cpname: widget.controlPanelModel.name,
          // dest: 1,
        ),
      ),
    ).then((ret) {
      if (GlobalVar.tempData.containsKey('template_id')) {
        // curTemplateModel=  GlobalVar.tempData
        int tid = GlobalVar.tempData['template_id'];
        curTemplateModel = GlobalVar.lstTemplate[tid];
        // _runTemplate();
      }
    }).catchError((e) {
      print('@@@ e : $e');
    });
  }

  _setOrder(String name) {
    // if (name == "temp") {
    //   Navigator.push(
    //     context,
    //     MaterialPageRoute(
    //       builder: (context) => SelectTemplateList(
    //         iid: widget.controlPanelModel.iid,
    //         // cpname: widget.controlPanelModel.name,
    //         // dest: 1,
    //       ),
    //     ),
    //   ).then((ret) {
    //     // print('@@@ ret : $ret');
    //     // if (ret != null) {
    //     //   print('@@@ ret : $ret');
    //     //   // _runTemplate(ret);
    //     // }
    //     if (GlobalVar.tempData.containsKey('template_id')) _runTemplate();
    //   }).catchError((e) {
    //     print('@@@ e : $e');
    //   });
    //   // Navigator.of(context).pushNamed("/templatelist");
    //   return;
    // }

    if (name == "state") {
      if (curMqttData.state == 2 || curMqttData.state == 3) {
        AppToast.showToast('烤箱在运行中，不能设置此切换！');
        return;
      }

      if (cpstate == 2)
        cpstate = 3;
      else
        cpstate = 2;
      return;
    }

    if (curMqttData.state == 0) return;

    String orderstr = "";
    switch (name) {
      case "gate":
        orderstr = '{"gate":' + (curMqttData.gate == 0 ? '1' : '0') + '}';
        break;
      case "water":
        orderstr =
            '{"water":1}'; // '{"water":' + (curMqttData.water == 0 ? '1' : '0') + '}';
        break;
      case "gas":
        orderstr = '{"gas":' + (curMqttData.gas == 0 ? '1' : '0') + '}';
        break;
      case "fan":
        orderstr = '{"fan":' + (curMqttData.fan == 0 ? '1' : '0') + '}';
        break;
      case "light":
        orderstr = '{"light":' + (curMqttData.light == 0 ? '1' : '0') + '}';
        break;
      case "steams":
        orderstr = '{"steams":' + (curMqttData.steams == 0 ? '1' : '0') + '}';
        break;
    }

    print("@@@ _setPower()  orderstr : $orderstr");
    GlobalVar.mqttClass.publishMessage("/oven/device" + uuid, orderstr);
  }

  _runTemplate() async {
    // print(
    //     '@@@ ControlPanelPage._runTemplate() id : ${GlobalVar.tempData['template_id']}');
    // int tid = GlobalVar.tempData['template_id'];
    // TemplateModel tm = GlobalVar.lstTemplate[tid];
    if (curTemplateModel == null) {
      print('@@@ ControlPanelPage._runTemplate() curTemplateModel is null');
      return;
    }

    String orderstr = curTemplateModel.getOrderStr();
    if (orderstr == '') {
      print('*** ControlPanelPage._runTemplate() orderstr is empty');
      return;
    }
    _sendOrder(orderstr);

    Timer(Duration(seconds: 1), () {
      // print("@@@ _sendTemplate() 执行模板命令 =>");
      _sendOrder('{"state":4}');
    });
  }

  // _getSingleTemplateOrder(stm, index, timer) {
  //   return '{"timer":$timer,"up":[${stm.uptemp},${stm.uppower}],"down":[${stm.downtemp},${stm.downpower}],"steamt":${stm.steamt[0]},"tn":${stm.tn},"sn":$index}';
  // }

  _getButtonColor(String name) {
    switch (name) {
      case "light":
        return curMqttData.light == 0 ? Colors.white : AppStyle.mainColor;
        break;
      case "gate":
        return curMqttData.gate == 0 ? Colors.white : AppStyle.mainColor;
        break;
      case "steams":
        return curMqttData.steams == 0 ? Colors.white : AppStyle.mainColor;
        break;
      case "gas":
        return curMqttData.gas == 0 ? Colors.white : AppStyle.mainColor;
        break;
      case "fan":
        return curMqttData.fan == 0 ? Colors.white : AppStyle.mainColor;
        break;
      case "water":
        return curMqttData.water == 0 ? Colors.white : AppStyle.mainColor;
        break;
      case "state":
        return curMqttData.state == 3 || cpstate == 3
            ? AppStyle.mainColor
            : Colors.white;
        break;
      default:
        return Colors.white;
        break;
    }
  }

  _getBigButton(String name, String bt) {
    return Container(
      height: dButtonLineHeight,
      width: dButtonWidth,
      // color: Colors.black87,
      // alignment: Alignment.bottomCenter,
      margin: EdgeInsets.fromLTRB(bt == "left" ? 0 : dSperator / 2, 0,
          bt == "left" ? dSperator / 2 : 0, 0),
      // padding: EdgeInsets.only(
      //   bottom: 3.0,
      // ),
      decoration: BoxDecoration(
        // border: Border.all(
        // bottom: BorderSide(color: Colors.black, width: 1.0)), //灰色的一层边框
        color: _getBigButtonBC(name), // Colors.black87,
        borderRadius: BorderRadius.all(Radius.circular(3.0)),
      ),
      child: IconButton(
        icon: Image.asset(
          bt == "left" ? "images/power.png" : "images/run.png",
          color: name == "run" ? Colors.white : _getBigButtonFC(name),
        ),
        onPressed: () {
          if (name == "power")
            _setPower();
          else if (name == "run") _setRun();
        },
      ),
    );
  }

  _setPower() {
    // String orderstr = "";
    // orderstr = '{"state":0}';
    // print("@@@ _setPower()  orderstr : $orderstr");
    // GlobalVar.mqttClass.publishMessage("/oven/device" + uuid, orderstr);

    GlobalVar.sendOrder("/oven/device" + uuid, '{"state":0}');
  }

  _setRun() {
    if (curMqttData.state == 2 || curMqttData.state == 3) {
      AppDialog.showYesNoIOS(context, '停止确认', '烤箱正在运行中，您确定要停止吗？', () {
        _sendOrder('{"state":1}');
      });
      return;
    }

    if (curTemplateModel != null) {
      _runTemplate();
      return;
    }

    if (curMqttData != null) {
      // AppDialog.showRunConfirmIOS(context, cpstate, curMqttData, () {
      String orderstr = '{"state":$cpstate,' +
          '"ups":${curMqttData.ups},"up":[${curMqttData.up[0]},${curMqttData.up[2]}],' +
          '"downs":${curMqttData.downs},"down":[${curMqttData.down[0]},${curMqttData.down[2]}],' +
          '"center":${curMqttData.center[0]},' +
          '"steams":${curMqttData.steams},"steam":${curMqttData.steam[0]},' +
          '"timer":${curMqttData.timer[0]},' +
          '"gate":${curMqttData.gate},' +
          '"light":${curMqttData.light},' +
          '"fan":${curMqttData.fan},' +
          '"water":${curMqttData.water},"steamt":${curMqttData.steamt[0]},' +
          '"tn":0,"sn":0}';
      _sendOrder(orderstr);
      // });
    }
  }

  _getBigButtonBC(name) {
    if (curMqttData.state == 0) return Colors.black87;
    if (name == "power") {
      return Colors.black87;
    } else {
      return (curMqttData.state == 2 || curMqttData.state == 3)
          ? Colors.red
          : Colors.black87;
    }
  }

  _getBigButtonFC(String name) {
    if (curMqttData.state == 0) return Colors.white;
    if (name == "power") {
      return curMqttData.state == 0 ? Colors.grey[400] : Colors.red;
    } else {
      return Colors.white;
    }
  }

  _sendOrder(String orderstr) {
    if (orderstr == "") return;
    String topic = "/oven/device" + uuid;
    print("@@@ _sendOrder() topic : $topic , orderstr : $orderstr");
    GlobalVar.mqttClass.publishMessage(topic, orderstr);
  }

  addToTemplate(tn) {
    print(
        "@@@ ControlPanelPage.addToTemplate() tn : $tn ，curTemplateModel : ${curTemplateModel.ccpid}");
  }
}
