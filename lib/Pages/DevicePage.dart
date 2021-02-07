// import 'dart:convert';
import 'dart:async';
// import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ovenapp/Classes/app_dialog_helper.dart';
// import 'package:ovenapp/Models/HttpRetModel.dart';
// import 'package:ovenapp/Models/PowerModel.dart';
import 'package:ovenapp/Pages/CPEditPage.dart';
import 'package:ovenapp/Pages/CPViewPage.dart';
import 'package:ovenapp/Pages/PowerListPage.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:ovenapp/BusinessObjects/DeviceBO.dart';
import 'package:ovenapp/BusinessObjects/DialogBO.dart';
// import 'package:ovenapp/BusinessObjects/DeviceBO.dart';
import 'package:ovenapp/BusinessObjects/ScanBO.dart';
// import 'package:ovenapp/Classes/ApkHelper.dart';
import 'package:ovenapp/Classes/AppDialog.dart';
import 'package:ovenapp/Classes/AppToast.dart';
import 'package:ovenapp/Classes/SharePrefHelper.dart';
import 'package:ovenapp/Controls/AppWidget.dart';
// import 'package:ovenapp/Controls/ControlPanelUnit.dart';
import 'package:ovenapp/Controls/DeviceUnit.dart';
import 'package:ovenapp/Models/ControlPanelModel.dart';
import 'package:ovenapp/Models/DeviceModel.dart';
// import 'package:ovenapp/Models/JPushModel.dart';
// import 'package:ovenapp/Models/HttpRetModel.dart';
import 'package:ovenapp/Pages/ControlPanelPage.dart';
import 'package:ovenapp/Pages/DeviceDetailPage.dart';
import 'package:ovenapp/Pages/WifiPage.dart';
// import 'package:ovenapp/Publics/AppObjHelper.dart';
import 'package:ovenapp/Publics/AppStyle.dart';
// import 'package:flutter_refresh/flutter_refresh.dart';
import 'package:ovenapp/Publics/DataHelper.dart';
import 'package:ovenapp/Publics/GlobalVar.dart';
import 'package:ovenapp/Publics/MyControl.dart';
import 'package:ovenapp/Services/EventBusSrv.dart';
// import 'package:ovenapp/Services/HttpCallerSrv.dart';

// import 'package:ovenapp/Controls/SearchText.dart';

class DevicePage extends StatefulWidget {
  @override
  _DevicePageState createState() => _DevicePageState();
}

class _DevicePageState extends State<DevicePage> {
  List<dynamic> _lstData;

  final TextEditingController searchController =
      TextEditingController(text: "");

  var _onWarnStartEvent;
  var _onControlPancelEvent;
  var _onDeviceEvent;
  var _onWifiInfoEvent;
  var _onLoginEvent;
  var _onLogoutEvent;
  // final _memoizer = new AsyncMemoizer();
// final AsyncMemoizer _memoizer = AsyncMemoizer();
  // @override
  // bool get wantKeepAlive =>true; with AutomaticKeepAliveClientMixin
  // List<dynamic> _lstDevice;
  // List<dynamic> _lstControlPanel;
  String queryStr = '';
  String cpuuid = '';
  String spfile;
  int _isRefreshable = 1;
  // int _isLogout = 0;
  // int querycount = 0;
  // final double dD = 12.0;

  @override
  void initState() {
    super.initState();

    spfile = GlobalVar.spdevice;
    // if (GlobalVar.userInfo == null) {
    //   // _lstDevice = [];
    //   // _lstControlPanel = [];
    //   GlobalVar.lstDevice = {};
    //   GlobalVar.lstControlPanel = {};
    // } else {
    // _getData();

    // }
    print("@@@ DevicePage.initState() ...");
    // GlobalVar.mqttClass = new MqttClass(GlobalVar.userInfo.loginid);

    _onControlPancelEvent = eventBus.on<ControlPanelEvent>().listen((event) {
      String ot = event.ot;
      ControlPanelModel cpm = event.data;
      print("@@@ DevicePage.ControlPancelEvent => ot : $ot / id : ${cpm.uuid}");
      switch (ot) {
        case "menu":
          _showMenu(cpm);
          break;

        case "delete":
          _deleteControlPanel(cpm);
          break;

        case "show":
          _showControlPanel(cpm);
          break;
      }
    });

    _onDeviceEvent = eventBus.on<DeviceEvent>().listen((event) {
      String ot = event.ot;
      DeviceModel dm = event.data;
      int index = event.cpindex;
      print("@@@ DevicePage.DeviceEvent => ot : $ot / id : ${dm.id}");
      switch (ot) {
        case "detail":
          _showDeviceDetail(dm);
          break;
        case "addcp":
          // _addControlPanel(id);
          _getUuid(dm, index);
          break;
        case "refresh":
          cpuuid = dm.name;
          _refreshData();
          break;
        case "delete":
          _deleteDevice(dm);
          break;
        case "viewpower":
          _viewPower(dm);
          break;
        case "controlpanel":
          _showcpview(dm, index);
          break;
      }
    });

    _onWarnStartEvent = eventBus.on<WarnStartEvent>().listen((event) {
      // print("@@@ DevicePage.WarnStartEvent => uuid : ${event.uuid}");
      GlobalVar.playWarnAudio(context, event.uuid);
    });

    _onWifiInfoEvent = eventBus.on<WifiInfoEvent>().listen((event) {
      // print("@@@ DevicePage.WifiInfoEvent => uuid : ${event.data.uuid}");
      _showWifiUI(event.data);
    });

    _onLoginEvent = eventBus.on<LoginEvent>().listen((event) {
      _refreshData();
    });

    _onLogoutEvent = eventBus.on<LogoutEvent>().listen((event) {
      // print("@@@ DevicePage.LogoutEvent => 。。。");
      SharePrefHelper.removeData(spfile);
      // GlobalVar.lstDevice.clear();
      // GlobalVar.lstControlPanel.clear();
      _lstData = [];
      // _isLogout = 1;
      setState(() {});
      // _refreshData();
    });

    getData();
    _initPowerTimer();
  }

  Timer _tmPower;
  _initPowerTimer() async {
    // if (GlobalVar.userInfo != null) {
    //   print("@@@ DevicePage._initPowerTimer() ... DeviceBO.getPower()");
    // String spf = GlobalVar.sppower;
    // String jsonData = await SharePrefHelper.getData(spf);
    // if (jsonData != null && jsonData != '') {
    //   try {
    //     HttpRetModel rm = HttpRetModel.fromJsonStr(jsonData, [PowerModel()]);
    //     DeviceBO.setPowerData(rm);
    //   } catch (e) {
    //     print(
    //         "*** DevicePage._initPowerTimer => jsonData : $jsonData , e : $e");
    //   }
    // }

    // DeviceBO.getPower();
    // }

    _tmPower = Timer.periodic(Duration(minutes: 10), (t) {
      DeviceBO.getPower();
    });
  }

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    _refreshData();
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 300));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();

    // Timer(Duration(seconds: 5), (){_isRefreshable=1;});
  }

  void _onLoading() async {
    // return;
    _refreshController.loadComplete();
  }

  @override
  void dispose() {
    super.dispose();
    //取消订阅
    if (_tmPower != null) {
      _tmPower.cancel();
      _tmPower = null;
    }
    _onDeviceEvent.cancel();
    _onWarnStartEvent.cancel();
    _onControlPancelEvent.cancel();
    _onWifiInfoEvent.cancel();
    _onLoginEvent.cancel();
    _onLogoutEvent.cancel();
    GlobalVar.closeWarnAudio();
    print("@@@ DevicePage.dispose() ...");
  }

  @override
  Widget build(BuildContext context) {
    // super.build(context);

    print("@@@ DevicePage.build() ...");

    return Scaffold(
      appBar:
          // PreferredSize(
          //   child:
          AppBar(
        backgroundColor: AppStyle.clTitleBC,
        leading: _getLeading(),
        // leading: IconButton(icon: Icon(Icons.arrow_back_ios),tooltip: '返回', onPressed: (){}),
        // leading: _getLeading(),
        title: AppWidget.getSearcherTF("设备名称", (tn, v) {
          // print('@@@ tn : $tn , v : $v');
          if (GlobalVar.userInfo != null) {
            queryStr = v;
            setState(() {});
          }
        }), //getSeacherTF(), //_getSearchTextField(),
        actions: _getActions(),
        shape: AppWidget.getAppBarBottomBorder(),
        elevation: 0.0,
      ),
      // preferredSize: AppStyle
      //     .getAppBarHeight(), // Size.fromHeight(AppStyle.screenSize.height * 0.08),
      // ),
      // body: DeviceBO.getDeviceFB(context),
      // backgroundColor: Colors.black38,
      body: SmartRefresher(
        enablePullDown: _isRefreshable == 1,
        enablePullUp: false,
        // onOffsetChange: (){},
        header: MaterialClassicHeader(
          backgroundColor: Colors.blueAccent,
        ), //WaterDropMaterialHeader(backgroundColor:  Color(0xFFE82662),),
        // footer: CustomFooter(
        //   builder: (BuildContext context, LoadStatus mode) {
        //     Widget body;
        //     if (mode == LoadStatus.idle) {
        //       body = Text("正在加载数据 ...");
        //       // return SizedBox(height: 0.0,);
        //     } else if (mode == LoadStatus.loading) {
        //       body = CupertinoActivityIndicator();
        //       //  CircularProgressIndicator(
        //       //   backgroundColor: Colors.blueAccent,
        //       // );
        //     } else if (mode == LoadStatus.failed) {
        //       body = Text("加载失败，请重试!");
        //     } else if (mode == LoadStatus.canLoading) {
        //       body = Text("松开加载更多数据 ...");
        //     } else {
        //       body = Text("我是有底线的 ...");
        //     }
        //     return Container(
        //       height: 60.0,
        //       child: Center(child: body),
        //     );
        //   },
        // ),
        controller: _refreshController,
        onRefresh: _onRefresh,
        // onLoading: _onLoading,
        child: _getBodyUI(),
      ),
      // _getBodyUI(),
      // Refresh(
      //   onFooterRefresh: onFooterRefresh,
      //   onHeaderRefresh: onHeaderRefresh,
      //   child: DeviceBO.getDeviceFB(context),
      //   //ListView.builder(itemCount: _list.length, itemBuilder: _itemBuilder),
      // ),
    );
  }

  _getLeading() {
    return IconButton(
        padding: EdgeInsets.zero,
        iconSize: 24.0,
        icon: Image.asset(
          'images/scan.png',
          height: 24.0,
          width: 24.0,
          color: Colors.black54,
        ),
        onPressed: () {
          _addControlPanelFromScan();
          // ScanBO.scanQB(context);
        });
  }

  _getBodyUI() {
    // print('@@@ DevicePage._getUI() ...');
    // if (_isLogout == 1) {
    //   // print('@@@ DevicePage._isLogout => 1 ..................');
    //   _isLogout = 0;
    //   return AppWidget.getEmptyData(() {});
    // }

    if (GlobalVar.userInfo == null) {
      return AppWidget.getEmptyData(() {
        _refreshData();
      });
    }

    if (_lstData == null)
      return MyControl.waitingWidget(); // AppWidget.getCircularProgress();

    if (_lstData.isEmpty) {
      return AppWidget.getEmptyData(() {
        _refreshData();
      });
    }

    // return ListView.builder(itemCount: _list.length, itemBuilder: _itemBuilder);
    return _getListUI();
  }

  _getListUI() {
    List<Widget> _lst = [];
    // return ListView.builder(itemCount: _lstDevice.length,itemBuilder: null);
    // print(
    //     '@@@ DevicePage._getDeviceListUI() _lstDevice.length : ${_lstDevice.length} ,_lstControlPanel.length : ${_lstControlPanel.length}');
    // List<DeviceModel> _lstDevice = GlobalVar.lstDevice.values.toList();
    _lst.clear();
    _lst.add(SizedBox(
      height: 12.0,
    ));

    int index = 0;
    _lstData.forEach((m) {
      // DeviceUnit(deviceModel: _lstData[index], index: index);
      // _lst.add(DeviceUnit(deviceModel: _lstData[index], index: index));
      // print('index: $index');
      // print(m);
      if (queryStr != '' && m.name.indexOf(queryStr) == -1) {
      } else {
        _lst.add(DeviceUnit(deviceModel: m, index: index));
        _lst.add(SizedBox(
          height: 6.0,
        ));
        index++;
      }
    });
    _lst.add(SizedBox(
      height: 36.0,
    ));

    return SingleChildScrollView(
      child: Column(
        children: _lst,
      ),
    );
  }

  getData([int fromcs = 0]) async {
    if (GlobalVar.userInfo == null) {
      _lstData = [];
      return;
    }

    await DeviceBO.getData(fromcs);

    if (GlobalVar.lstDevice == null) {
      _lstData = [];
    } else {
      _lstData = GlobalVar.lstDevice.values.toList();
    }

    if (mounted) {
      setState(() {});
    }
    // querycount++;
    if (GlobalVar.mqttClass != null &&
        GlobalVar.lstControlPanel != null &&
        GlobalVar.lstControlPanel.length > 0) {
      GlobalVar.mqttClass.openSubscribeTimer();
      DeviceBO.getPower();
    }
  }

  List<Widget> _getActions() {
    return <Widget>[
      // IconButton(
      //     icon: Icon(Icons.search),
      //     iconSize: 32,
      //     onPressed: () {
      //       _printDList();
      //     }),
      IconButton(
          icon: Icon(
            Icons.add,
            color: AppStyle.clButtonGray,
          ),
          // tooltip: '新增设备',
          iconSize: 32.0,
          onPressed: () {
            _getDeviceName();
            // ApkHelper.deleteApkFile();
            // print('@@@ DevicePage ApkHelper.isfinished : ${ApkHelper.isfinished}');
          }),
    ];
  }

  _printDList() {
    if (GlobalVar.isPrintMqttData == 0)
      GlobalVar.isPrintMqttData = 1;
    else
      GlobalVar.isPrintMqttData = 0;

    // DeviceModel dm = GlobalVar.lstDevice['A2CA8A11B94E'];
    // List<int> _lst = dm.lstCP.map((e) {
    //   return e.indexno;
    // }).toList();
    // print(_lst.indexOf(5));
  }

  _printDeviceList() {
    print(
        '@@@ DevicePage._printDeviceList() GlobalVar.lstDevice.length : ${GlobalVar.lstDevice.length} , GlobalVar.lstControlPanel.length : ${GlobalVar.lstControlPanel.length}');
    GlobalVar.lstDevice.forEach((k, v) {
      print(
          '@@@ DevicePage._printDeviceList() v.name : ${v.name} , v : ${v.lstCP.length}');
      v.lstCP.forEach((v) {
        print(
            '@@@ DevicePage._printDeviceList() ControlPanel : ${v.name} - ${v.uuid}');
      });
    });
  }

  _refreshData() async {
    print('@@@ DevicePage._refreshData() ${DateTime.now()}');

    if (GlobalVar.userInfo == null) return;

    if (_isRefreshable == 0) return;

    // _isRefreshable = 0; 暂时可以随便刷

    Timer(Duration(seconds: GlobalVar.refreshtime), () {
      _isRefreshable = 1;
    });

    await getData(1);

    if (cpuuid != '') {
      if (GlobalVar.lstControlPanel.containsKey(cpuuid)) {
        _showControlPanel(GlobalVar.lstControlPanel[cpuuid]);
      }
      cpuuid = '';
    }
    // setState(() {});
  }

  _showMenu(cpm) {
    Map<String, IconData> _lstItem = {
      "设置参数": Icons.border_color,
      "初始化WIFI": Icons.tap_and_play,
      "更换WIFI": Icons.wifi,
      "报修": Icons.settings_phone,
      "帮助": Icons.help,
      "移除": Icons.clear,
      "取消": Icons.directions_run
    };

    AppWidget.showModalBottomMenu(context, _lstItem, 140.0, (v) {
      print('@@@ _showMenu(${cpm.uuid}) v : $v');
      if (v == null || v == '取消') return;
      switch (v.toString()) {
        case '设置参数':
          _setCPParam(cpm);
          break;
        case '移除':
          _deleteControlPanel(cpm);
          break;
        case '初始化WIFI':
          _initWifi(cpm.uuid);
          break;
        case '更换WIFI':
          _wifiUuid = '/' + cpm.uuid;
          String orderstr = '{"state":"getWifi"}';
          print("@@@ _sendOrder()  orderstr : $orderstr");
          GlobalVar.mqttClass
              .publishMessage("/oven/device/" + cpm.uuid, orderstr);
          break;
        case '报修':
          // _repairCP(cpm);
          print(
              "@@@ DevicePage._showMenu()  cpm : ${cpm.toJsonStr()}"); //_showMemu(),
          // print("@@@ DevicePage._showMenu()  cpm : ${cpm.toJsonStr()}");
          break;
        case '帮助':
          // _showHelp(cpm);
          AppDialog.showInfoIOS(context, 'cpm.uuid', cpm.toJsonStr());
          break;
      }
    });
  }

  _setCPParam(cpm) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CPEditPage(
            cpModel: cpm,
          ),
        ));
  }

  _repairCP(cpm) {
    print("@@@ _repairCP() cpm.uuid : ${cpm.uuid}");
  }

  _showHelp(cpm) {
    print("@@@ _showHelp() cpm.uuid : ${cpm.uuid}");
  }

  _initWifi(uid) async {
    String wifiparam = await SharePrefHelper.getData('wifiparam');
    if (wifiparam != null && wifiparam != '') {
      List<String> sl = wifiparam.split(',');
      GlobalVar.wifissid = sl[0];
      GlobalVar.wifipwd = sl[1];
    }
    // else {
    //   GlobalVar.wifissid = 'chenkexin';
    //   GlobalVar.wifipwd = '13437183248';
    // }

    GlobalVar.isAPConnected = true;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => WifiPage(
          uuid: uid,
        ),
      ),
    ).then((ret) {
      // GlobalVar.isAPConnected = false;
      // if (GlobalVar.tempData.containsKey('template_id')) _runTemplate();
    }).catchError((e) {
      // GlobalVar.isAPConnected = false;
      print('@@@ _initWifi() catchError(e) : $e');
    }).whenComplete(() {
      _resumeAp();
    });
  }

  _resumeAp() {
    Timer(Duration(seconds: 3), () {
      GlobalVar.isAPConnected = false;
    });
  }

  _getDeviceName() async {
    if (GlobalVar.userInfo == null) {
      Navigator.of(context).pushNamed('/login');
      return;
    }
    // AppDialog.showTextFieldIOS(context, "新增设备：", "请输入设备名称", (dn) {
    //   // print("@@@ DevicePage._addDevice() : " + dn);
    //   _addDevice(dn.toString().trim());
    // });
    var ret = await AppDiaglogHelper.showTextFieldDialog(
        context, TitleTextModel(text: '请输入设备名称'));
    if (ret != null && ret.toString().trim() != '') {
      _addDevice(ret.toString());
    }
  }

  _addDevice(String name) async {
    GlobalVar.lstDevice.forEach((did, dm) {
      if (dm.name == name) {
        AppToast.showToast('此名称已经存在，请更换名称！');
        return;
      }
    });
    // print("@@@ DevicePage._addDevice() : " + name);
    int index = GlobalVar.lstDevice.length + 1;
    DataHelpr.dataHandler('Device/Add', {"name": name, "indexno": index}, (rm) {
      if (rm.ret == 0) {
        // print("@@@ DevicePage._addDevice() rowid : " + rm.id);
        SharePrefHelper.removeData(spfile);
        DeviceModel dm = DeviceModel(
            id: rm.id,
            name: name,
            icon: 'deviceicon.png',
            indexno: index,
            model: '202002');

        GlobalVar.lstDevice[rm.id] = dm;
        _lstData = GlobalVar.lstDevice.values.toList();
        // _addDeviceList(dm);
        // _lstDevice.add(dm);
        // GlobalVar.lstDevice[rm.id] = dm;
        setState(() {});
      } else
        AppToast.showToast('新增失败: ${rm.message}');
    });
  }

  _deleteDevice(dm) async {
    var ret = await AppDiaglogHelper.showYesNoDialog(
        context, '您确实要删除该设备吗？', CupertinoColors.systemRed);
    if (ret != null && ret == 1) {
      DataHelpr.dataHandler('Device/Delete', {"ID": dm.id}, (rm) {
        DataHelpr.resultHandler(rm, () {
          AppToast.showToast('删除成功！');
          //refresh
          // if (GlobalVar.lstDevice.containsKey(id)) {
          SharePrefHelper.removeData(spfile);

          // print(
          //     'Before Delete => GlobalVar.lstDevice : ${GlobalVar.lstDevice} / ${DateTime.now()}');
          // print('_deleteDevice begin : ${GlobalVar.mqttClass.mapControlPanel}');
          DeviceBO.removeDevice(dm);
          _lstData = GlobalVar.lstDevice.values.toList();
          // print(
          //     'After Delete => GlobalVar.lstDevice : ${GlobalVar.lstDevice} / ${DateTime.now()}');

          setState(() {
            // print('setState => ${DateTime.now()}');
          });

          GlobalVar.mqttClass.openSubscribeTimer();

          // print(GlobalVar.mqttClass.mapControlPanel);
          // }
        });
      });
    }

    // AppDialog.showYesNoIOS(context, "删除确认", "您确实要删除该设备吗？", () {
    //   print("@@@ DevicePage._deleteDevice => ${dm.id}");

    // });
  }

  _viewPower(DeviceModel dm) {
    if (dm.lstCP == null || dm.lstCP.length == 0) {
      AppToast.showToast('此设备没有烤箱！');
      return;
    }
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => PowerListPage(deviceModel: dm)));
  }

  _getUuid(dm, index) async {
    // print("@@@ DevicePage._getUuid() index : $index");

    List<String> _lstText = ["扫描二维码", "输入序列号", "取消"];
    var ret = await AppDiaglogHelper.showSelectTextList(context, _lstText);
    if (ret != null) {
      // print("@@@ DevicePage._getUuid ret : $ret");

      if (ret == 0) {
        String uuid = await ScanBO.getQRCodeByScan();
        if (uuid == null || uuid.trim() == '') return;
        // uuid = AppObjHelper.getQRCode(uuid);
        // if (uuid.isNotEmpty) return;
        _addControlPanel1(dm, uuid, index);
      } else if (ret == 1) {
        //注：不能在弹窗内调用另一弹窗，必须以时钟来实现
        Timer(Duration(milliseconds: 100), () {
          _getControlPanelNo(dm, index);
        });
      }
    }
  }

  _addControlPanelFromScan() async {
    String uuid = await ScanBO.getQRCodeByScan();
    if (uuid == null || uuid.trim() == '') {
      // AppToast.showToast('无效二维码！');
      return;
    }

    var rm =
        await DataHelpr.retQuerier('ControlPanel/ValidateSN', {"uuid": uuid});
    // print(rm);
    if (rm.ret != 0) {
      AppToast.showToast(rm.message);
      return;
    }

    // print('@@@ DataHelpr.retQuerier() rm.ret : ${rm.ret}');
    // DataHelpr.resultHandler(rm, () {
    List<String> _lst = [];
    List<String> _lstId = [];
    GlobalVar.lstDevice.forEach((k, v) {
      if (v.lstCP.length < 3) {
        _lst.add(v.name);
        _lstId.add(k);
      }
    });

    if (_lst.length > 0) {
      var ret = await AppDiaglogHelper.showSelectTextList(context, _lst, 1);
      if (ret != null && ret == -999) return;

      // print('@@@ DevicePage._addControlPanelFromScan ret : $ret');

      DeviceModel dm = GlobalVar.lstDevice[_lstId[ret]];
      int index = DeviceBO.getDeviceEmptyIndexNo(dm);
      // _addControlPanel1(dm, uuid, index);

      String name = '烤箱#$index';
      var param = {
        "Device_ID": dm.id,
        "ControlPanel_ID": uuid,
        "IndexNo": index,
        "Name": name
      };

      // print(param);

      if (GlobalVar.lstControlPanel.containsKey(uuid)) {
        ControlPanelModel cpm = GlobalVar.lstControlPanel[uuid];

        AppToast.showToast('该设备已经存在于 ${cpm.devicename} 中！');
        return;
      }

      await DataHelpr.dataHandler('ControlPanel/Add', param, (rm) {
        DataHelpr.resultHandler(rm, () {
          _refreshData();
        });
      });

      // double ch = _lst.length * 51.0;
      // if (ch > 180.0) ch = 400.0;
      // AppDialog.showSelectedListViewIOS(context, '请选择要加入的设备：', _lst, ch, ((v) {
      //   print("@@@ ScanBO.scanQB() => v : " + v);
      //   DeviceModel dm = GlobalVar.lstDevice[_lstId[int.parse(v)]];
      //   print("@@@ ScanBO.scanQB() => dm.name : ${dm.name}");
      //   DeviceBO.addControlPanel(dm, uuid, -1, (uuid) {
      //     DeviceBO.showControlPanel(context, uuid);
      //   });
      // }));
    } else {
      //无任何空闲设备的情况下新增
      print("无任何空闲设备的情况下,,,新增");
      DataHelpr.dataHandler('ControlPanel/Scan', {"uuid": uuid}, (rm) {
        DataHelpr.resultHandler(rm, () {
          _refreshData();
        });
      });
    }
    // });
    // });
    // uuid = AppObjHelper.getQRCode(uuid);
    // if (uuid.isNotEmpty) return;
    // _addControlPanel1(dm, uuid, index);
  }

  // _addControlPanel(dm, uuid, index) {
  //   DeviceBO.addControlPanel(dm, uuid, index, (uuid) {
  //     // _afterControlPanelAdded(uuid);
  //     print(
  //         "@@@ DevicePage._addControlPanel dm.name : ${dm.name} uuid : $uuid");
  //     setState(() {});
  //   });
  // }

  _getControlPanelNo(dm, index) async {
    // AppDialog.showTextFieldIOS(context, '请输入主板序列号', '', (sn) {
    //   _getUUID(dm, sn);
    // });
    var ret = await AppDiaglogHelper.showTextFieldDialog(
        context, TitleTextModel(text: '请输入主板序列号'));
    print("@@@ DevicePage._getControlPanelNo ret : $ret");
    if (ret != null && ret.toString().trim() != '') {
      _addControlPanel1(dm, ret, index);
    }
  }

  _addControlPanel1(dm, uuid, index) {
    if (uuid == null || uuid.toString().trim() == '') {
      AppToast.showToast('序列号不能为空！');
      return;
    }

    if (GlobalVar.lstControlPanel.containsKey(uuid)) {
      ControlPanelModel cpm = GlobalVar.lstControlPanel[uuid];

      AppToast.showToast('该设备已经存在于 ${cpm.devicename} 中！');
      return;
    }
    // print("@@@ DevicePage._getUUID sn : $sn");
    DataHelpr.dataHandler('ControlPanel/UUID', {"sn": uuid, "index": index},
        (rm) {
      DataHelpr.resultHandler(rm, () {
        // if (rm.ret == 0) {
        // print("@@@ DevicePage._getUUID uuid : ${rm.id}");
        // if (rm.id != '0') {
        // _addControlPanel(dm, 'https://www.cfdzkj.com:811/uuid=' + rm.id);'https://www.cfdzkj.com:811/uuid=' +

        // DeviceBO.addControlPanel(dm, rm.id, index, (uuid, lstDelete) {
        //   AppToast.showToast('添加主板成功！');
        //   // SharePrefHelper.removeData(spfile);
        //   // setState(() {});
        //   // getData(1);
        //   _refreshData();
        // });
        //同一设备中已经存在
        if (GlobalVar.lstControlPanel.containsKey(uuid) &&
            GlobalVar.lstControlPanel[uuid].did == dm.id) {
          return;
        }

        String name = '烤箱#$index';

        DataHelpr.dataHandler('ControlPanel/Add', {
          "Device_ID": dm.id,
          "ControlPanel_ID": uuid,
          "IndexNo": index,
          "Name": name
        }, (rm) {
          DataHelpr.resultHandler(rm, () {
            _refreshData();
          });
        });

        // _refreshData();
        // } else {
        //   AppToast.showToast('无效序列号！');
        // }
        // } else {
        //   AppToast.showToast('${rm.message}');
        // }
      });
    });
  }

  _showControlPanel(cpm) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ControlPanelPage(controlPanelModel: cpm)));
  }

  _showcpview(dm, index) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => CPViewPage(
                  deviceModel: dm,
                  index: index,
                )));
  }

  _deleteControlPanel(ControlPanelModel cpm) async {
    print("@@@ DevicePage._deleteControlPanel(id:${cpm.id})");
    var ret = await AppDiaglogHelper.showYesNoDialog(context, "您确实要移除该控制面板吗？");
    print("@@@ DevicePage._deleteControlPanel ret:$ret)");
    if (ret == 1) {
      DataHelpr.dataHandler('ControlPanel/Delete', {"id": cpm.id}, (rm) {
        DataHelpr.resultHandler(rm, () {
          AppToast.showToast('删除成功！');
          //refresh
          SharePrefHelper.removeData(spfile);
          DeviceBO.removeControlPanel(cpm);
          // GlobalVar.lstControlPanel.remove(cpm.uuid);
          // _removeControlPanelList(cpm);
          setState(() {});
          GlobalVar.mqttClass.openSubscribeTimer();
        });
      });
    }
  }

  void _showDeviceDetail(deviceModel) {
    print("@@@ widget.deviceModel.id : ${deviceModel.id}");

    //此法无效，弹出前后父页均被 build 了
    // eventBus.fire(CallPageEvent("devicedetail",widget.deviceModel.id,"0"));
    // Navigator.of(context).pushNamed("/devicedetail",arguments:{"id":widget.deviceModel.id});
    Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (context) =>
                new DeviceDetailPage(deviceModel: deviceModel)));
  }

  String _wifiUuid = '';
  _showWifiUI(mm) {
    DialogBO.showWifiIOS(context, mm.ssid, mm.password, (ssid, pwd) {
      print('@@@ ssid : $ssid , pwd : $pwd');
      if (ssid == mm.ssid && pwd == mm.password) return;
      String orderstr = '{"state":"setwifi","ssid":"$ssid","passwd":"$pwd"}';
      print("@@@ _sendOrder()  orderstr : $orderstr");
      GlobalVar.mqttClass.publishMessage("/oven/device" + _wifiUuid, orderstr);
      _wifiUuid = '';
    });
  }
}
