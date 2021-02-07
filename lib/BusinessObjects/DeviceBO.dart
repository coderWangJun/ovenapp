// import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ovenapp/BusinessObjects/AppBO.dart';
import 'package:ovenapp/Classes/AppToast.dart';
import 'package:ovenapp/Classes/SharePrefHelper.dart';
// import 'package:ovenapp/Controls/DeviceItem.dart';

import 'package:ovenapp/Models/ControlPanelModel.dart';
import 'package:ovenapp/Models/DeviceModel.dart';
import 'package:ovenapp/Models/HttpRetModel.dart';
import 'package:ovenapp/Models/PowerModel.dart';
// import 'package:ovenapp/Models/HttpRetModel.dart';
import 'package:ovenapp/Pages/ControlPanelPage.dart';
// import 'package:ovenapp/Publics/AppObjHelper.dart';
import 'package:ovenapp/Publics/DataHelper.dart';
import 'package:ovenapp/Publics/GlobalVar.dart';
import 'package:ovenapp/Services/EventBusSrv.dart';
// import 'package:ovenapp/Services/HttpCallerSrv.dart';

class DeviceBO {
  static getData([int fromcs = 0]) async {
    String spfile = GlobalVar.spdevice;

    if (fromcs == 1) {
      GlobalVar.lstDevice = null;
      GlobalVar.lstControlPanel = null;
      SharePrefHelper.removeData(spfile);
    }

    if (fromcs == 0 &&
        GlobalVar.lstDevice != null &&
        GlobalVar.lstDevice.isNotEmpty) {
      print('@@@ DeviceBO.getData() Cache Data : $spfile');
      return;
    }

    List<dynamic> lstObj = [
      DeviceModel(),
      ControlPanelModel(),
    ];

    if (fromcs == 0) {
      if (SharePrefHelper.appPrefs.containsKey(spfile)) {
        String jsonData = await SharePrefHelper.getData(spfile);
        // print('@@@ AppPublicData._getTemplates() SharePref Data : $jsonData');
        if (jsonData != null && jsonData != "") {
          try {
            // Map<String, dynamic> ret = json.decode(jsonData);
            // HttpRetModel rm = HttpRetModel.fromJson(ret, TemplateModel());
            HttpRetModel rm = HttpRetModel.fromJsonStr(jsonData, lstObj);

            _setDeviceData(rm);

            print('@@@ DeviceBO.getData() SharePref data : $spfile');
            return;
          } catch (e) {
            // AppPublicData.mpTables.remove(spfile);
            SharePrefHelper.removeData(spfile);
            print('*** DeviceBO.getData() SharePref data e : $e');
            // isQueryData = true;
          }
        }
      }
      // }
    }

    await DataHelpr.dataQuerier('Device/List', null, lstObj, (ret) {
      HttpRetModel rm = ret as HttpRetModel;

      print(
          '@@@ DeviceBO.getData() Cloud data rm.ret : ${rm.ret}, data.length : ${rm.data?.length}');
      // print(
      //     '@@@ AppPublicData.getTemplate selectData => ret : ${rm.ret} , data.length : ${rm.data.length} , data1.length : ${rm.data1.length}');

      if (rm.ret == 0) {
        // GlobalVar.lstTemplate[tid] = tm;
        _setDeviceData(rm);
      }
    }, spfile);
  }

  static _setDeviceData(HttpRetModel rm) {
    if (GlobalVar.lstDevice == null)
      GlobalVar.lstDevice = {};
    else
      GlobalVar.lstDevice.clear();

    if (GlobalVar.lstControlPanel == null)
      GlobalVar.lstControlPanel = {};
    else
      GlobalVar.lstControlPanel.clear();

    if (rm.data == null || rm.data.isEmpty) {
      return;
    }

    rm.data.forEach((mo) {
      // print(
      //     '@@@ TemplateBO.getTemplateModel() HttpRetModel.data.length : ${rm.data.length} , HttpRetModel.data1.length : ${rm.data1.length} , HttpRetModel.data2.length : ${rm.data2.length} , HttpRetModel.data3.length : ${rm.data3.length}');
      DeviceModel tm = mo as DeviceModel;
      if (rm.data1 != null && rm.data1.isNotEmpty) {
        rm.data1.forEach((m) {
          ControlPanelModel mm = m as ControlPanelModel;
          if (mm.did == tm.id) {
            tm.lstCP.add(mm);
          }
          if (!GlobalVar.lstControlPanel.containsKey(mm.uuid))
            GlobalVar.lstControlPanel[mm.uuid] = mm;
        });
      }

      GlobalVar.lstDevice[tm.id] = tm;
    });
    print(
        '@@@ DeviceBO._setDeviceData() GlobalVar.lstDevice.length : ${GlobalVar.lstDevice?.length} ,  GlobalVar.lstControlPanel.length : ${GlobalVar.lstControlPanel?.length}');
    // return tm;
  }

  static removeCache() {
    SharePrefHelper.removeData(GlobalVar.spdevice);
  }

//得到该设备当前第一个空位
  static getDeviceEmptyIndexNo(DeviceModel dm) {
    int iret = 0;
    // for (int i = 1; i <= 3; i++) {
    // print('getDeviceEmptyIndexNo iret1 : $iret');
    List<int> _lst = dm.lstCP.map((e) => e.indexno).toList();
    _lst.sort();

    for (int i = 1; i <= 3; i++) {
      if (_lst.indexOf(i) == -1) {
        iret = i;
        break;
      }
    }
    // print(_lst);
    // dm.forEach((element) {
    //   // iret = iret + element.indexno;
    //   if (element.indexno == 1) iret = 2;
    //   if (element.indexno == 2) {
    //     iret = 3;
    //   }
    //   if (element.indexno == 1) iret = 2;
    // });
    // print('getDeviceEmptyIndexNo iret2 : $iret');
    // switch (iret) {
    //   case 1:
    //     iret = 2;
    //     break;
    //     case 2:
    //     iret = 1;
    //     break;
    //   case 3:
    //     iret = 3;
    //     break;
    //   case 4:
    //     iret = 2;
    //     break;
    //   case 5:
    //     iret = 1;
    //     break;
    //   default:
    //     iret = 0;
    //     break;
    // }
    // print('getDeviceEmptyIndexNo iret3 : $iret');
    // }
    return iret;
  }
  // static String spfile = "devicedata";
  // static List<dynamic> lstControlPanel;

  // static FutureBuilder getDeviceFB(BuildContext context) {
  //   return FutureBuilder(
  //     future: _getDeviceData(context),
  //     builder: (context, snapshot) {
  //       switch (snapshot.connectionState) {
  //         case ConnectionState.none:
  //         case ConnectionState.active:
  //         case ConnectionState.waiting:
  //           print(snapshot.connectionState);
  //           return Center(child: CupertinoActivityIndicator());
  //         case ConnectionState.done:
  //           // print('done');

  //           if (snapshot.hasError) {
  //             return Center(
  //               child: Text('网络请求出错'),
  //             );
  //           }
  //           // _newsData = snapshot.data;
  //           return _getDeviceUI(context, snapshot.data);
  //         default:
  //           return null;
  //       }
  //       // return null;
  //     },
  //   );
  // }

  // static Future<HttpRetModel> _getDeviceData(BuildContext context) async {
  //   int datafrom = 1;
  //   String jsonData = await SharePrefHelper.getData(GlobalVar.spdevice);
  //   if (jsonData != null && jsonData != "") {
  //     // print("@@@ DeviceBO._getDeviceData() from SharePref : $jsonData");
  //     // sret = spdata;
  //   } else {
  //     jsonData = await HttpCallerSrv.get(
  //         "Device/List", null, GlobalVar.userInfo.tk); //;

  //     print("@@@ DeviceBO._getDeviceData() jsonData => " + jsonData);
  //     if (jsonData == "http401") {
  //       // Navigator.pop(context);
  //       // Navigator.of(context).pushNamed("/login");
  //       return null;
  //     }
  //     datafrom = 0;
  //     SharePrefHelper.saveData(GlobalVar.spdevice, jsonData);
  //   }

  //   // print("@@@ DeviceBO._getDeviceData() jsonData => " + jsonData);

  //   HttpRetModel rm;
  //   try {
  //     Map<String, dynamic> ret = json.decode(jsonData);
  //     rm = HttpRetModel.fromJson1(
  //         ret, new DeviceModel(), new ControlPanelModel());

  //     if (rm.data1 != null)
  //       lstControlPanel = rm.data1;
  //     else
  //       lstControlPanel = [];

  //     print("@@@ DeviceBO._getDeviceData() from " +
  //         (datafrom == 0 ? "Cloud Server" : "Local Storage") +
  //         " data.length => ${rm.data.length}");
  //     // print("@@@ DeviceBO._getDeviceData() rm.data1.length => ${rm.data1.length}");

  //   } catch (e) {
  //     lstControlPanel = [];
  //     SharePrefHelper.removeData(GlobalVar.spdevice);
  //     print("*** DeviceBO._getDeviceData() data => $e");
  //   }

  //   return rm;
  // }

//   static ListView _getDeviceUI(BuildContext context, HttpRetModel data) {
//     List<Widget> _lst = new List<Widget>();
//     if (GlobalVar.userInfo == null) return ListView(children: _lst);
//     //  print("@@@ DeviceBO._getDeviceUI() rm.data.length => ${data.data.length}");
//     //   print("@@@ DeviceBO._getDeviceUI() rm.data1.length => ${data.data1.length}");
// // List<ControlPanelModel> lstcp=data.data1 as List<ControlPanelModel>;
//     List<dynamic> lstcp = data.data1;
//     // for (int i = 0; i < lstcp.length; i++) {
//     //   ControlPanelModel cpm = lstcp[i] as ControlPanelModel;

//     //   print("@@@ DeviceBO._getDeviceUI() cpm.name => ${cpm.uuid}");
//     // }

// // print(data);
//     if (data.data.length > 0) {
//       for (int i = 0; i < data.data.length; i++) {
//         DeviceModel dm = data.data[i] as DeviceModel;

//         // print("@@@ DeviceBO._getDeviceUI() dm.name => ${dm.name}");

//         Widget w = DeviceItem(
//             key: UniqueKey(), deviceModel: dm, lstControlPanel: lstcp);
//         _lst.add(w);
//       }

//       if (GlobalVar.mqttClass != null)
//         GlobalVar.mqttClass.openSubscribeTimer();
//       else
//         GlobalVar.initMqttSrv();
//     }
// // int ii=round(12.3);
//     // ListView lv = new ListView(children: _lst);
//     return ListView(children: _lst);
//   }

  static addControlPanel(DeviceModel dm, String uuid, int index, var callback) {
    // String uuid = await ScanBO.getQRCodeByScan();
    // String uuid = AppObjHelper.checkQRCode(uid);
    // if (uuid == null) return;

    //同一设备中已经存在
    if (GlobalVar.lstControlPanel.containsKey(uuid) &&
        GlobalVar.lstControlPanel[uuid].did == dm.id) {
      return;
    }

    // print(
    //     '@@@ DevicePage._addControlPanel() _lstDevice.length : ${_lstDevice.length} ,_lstControlPanel.length : ${_lstControlPanel.length}');

    List<ControlPanelModel> _lstDelete = [];

    // 得到新的主板相对于设备的序号
    int indexno = index;
    if (indexno == -1) {
      if (dm != null && dm.lstCP != null) {
        indexno = dm.lstCP.length + 1;
      }
    }

    // for (int i = 0; i < GlobalVar.lstControlPanel.length; i++) {
    GlobalVar.lstControlPanel.forEach((k, cpm) {
      // ControlPanelModel cpm = GlobalVar.lstControlPanel[i];
      // if (cpm.did == dm.id) {
      //   indexno++;
      //   // devicename = cpm.devicename;
      // }
      //删除其中已存在于其它设备中的主板
      if (cpm.uuid == uuid) _lstDelete.add(cpm);
    });

    // if (indexno == 0) indexno = 1;

    String name = '烤箱#$indexno';

    DataHelpr.dataHandler('ControlPanel/Add', {
      "Device_ID": dm.id,
      "ControlPanel_ID": uuid,
      "IndexNo": indexno,
      "Name": name
    }, (rm) {
      // print('@@@ DevicePage._addControlPanel() rm.ret : ${rm.ret} , rm.id : ${rm.id}');
      // HttpRetModel rm = m as HttpRetModel;
      // if (rm.ret == 0) {
      DataHelpr.resultHandler(rm, () {
        // print(GlobalVar.mqttClass.mapControlPanel);

        // SharePrefHelper.removeData(GlobalVar.spdevice);

        // _removeDeivceCP(_lstDelete);
        // //string 不可赋给 int ，切记 ~~~
        // //  print('@@@ DevicePage._addControlPanel() id : ${rm.id} , indexno : $indexno , uuid : $uuid, did : $did, name : $name, devicename : $devicename');
        // // print("@@@ DevicePage._addDevice() rowid : " + rm.id);
        // ControlPanelModel ccpm = ControlPanelModel(
        //     id: int.parse(rm.id),
        //     indexno: indexno,
        //     uuid: uuid,
        //     did: dm.id,
        //     name: name,
        //     devicename: dm.name,
        //     icon: 'oven.png',
        //     wifi: '',
        //     iid: 0);

        // // print('@@@ DevicePage._addControlPanel() ccpm : ${ccpm.toJsonStr()}');
        // // _addControlPanelList(ccpm);
        // // _lstControlPanel.add(ccpm);
        // GlobalVar.lstControlPanel[uuid] = ccpm;
        // dm.lstCP.add(ccpm);
        // // print(
        // //     '@@@ DevicePage._addControlPanel($did, $uid) ccpm : ${ccpm.toJsonStr()}');

        // // setState(() {});

        // print(GlobalVar.mqttClass.mapControlPanel);

        if (callback != null) callback(uuid);

        // GlobalVar.mqttClass.openSubscribeTimer();
      });
      // else
      //   AppToast.showToast('新增失败: ${rm.message}');
    });
  }

  static showControlPanel(context, uuid) {
    ControlPanelModel cpm = GlobalVar.lstControlPanel[uuid];
    // DeviceModel dm = GlobalVar.lstDevice[cpm.did];
    // Navigator.of(context).pushNamed("/controlpanel");
    Navigator.push(
      context,
      new MaterialPageRoute(
          builder: (context) => ControlPanelPage(controlPanelModel: cpm)),
    );
  }

  static _removeDeivceCP(_lstDelete) {
    if (_lstDelete == null || _lstDelete.length == 0) return;
    _lstDelete.forEach((pm) {
      print('@@@ DeviceBO._removeDeivceCP() remove : ${pm.toJsonStr()}');
      if (GlobalVar.lstDevice.containsKey(pm.did)) {
        DeviceModel dm = GlobalVar.lstDevice[pm.did];
        dm.lstCP.remove(pm);
        print('@@@ DeviceBO._removeDeivceCP() dm.id : ${dm.id}');
      }
      GlobalVar.lstControlPanel.remove(pm.uuid);
    });
  }

  static removeDevice(DeviceModel dm) {
    if (dm == null) return;
    if (dm.lstCP != null && dm.lstCP.length > 0) {
      dm.lstCP.forEach((cpm) {
        GlobalVar.lstControlPanel.remove(cpm.uuid);
        print('@@@ DeviceBO.removeDevice() uuid : ${cpm.uuid}');
      });
    }
    print('@@@ DeviceBO.removeDevice() dm.id : ${dm.id}');
    GlobalVar.lstDevice.remove(dm.id);
  }

  static removeControlPanel(cpm) {
    if (cpm == null) return;
    if (GlobalVar.lstDevice.containsKey(cpm.did)) {
      DeviceModel dm = GlobalVar.lstDevice[cpm.did];
      dm.lstCP.remove(cpm);
      print('@@@ DeviceBO.removeControlPanel() dm.id : ${dm.id}');
    }

    print('@@@ DeviceBO.removeControlPanel() uuid : ${cpm.uuid}');
    GlobalVar.lstControlPanel.remove(cpm.uuid);
  }

  static getPower() async {
    if (GlobalVar.userInfo == null ||
        GlobalVar.lstControlPanel == null ||
        GlobalVar.lstControlPanel.isEmpty) return;
    String spfile = GlobalVar.sppower;
    String ids = '';
    GlobalVar.lstControlPanel.keys.forEach((id) {
      ids = ids + '-' + id;
    });
    ids = ids.substring(1);
    await DataHelpr.dataQuerier(
        'ControlPanel/Power', {"ids": ids}, [PowerModel()], (ret) {
      HttpRetModel rm = ret as HttpRetModel;
      // print(
      //     '@@@ DeviceBO.getPower() Cloud Data => data : $spfile , rm.data.length : ${rm.data?.length}');

      if (rm.ret == 0) {
        setPowerData(rm, 1);
      }
    }, spfile);
  }

  static setPowerData(HttpRetModel rm, [int isfire = 0]) {
    if (GlobalVar.lstDevice == null || GlobalVar.lstDevice.isEmpty) return;
    GlobalVar.lstDevice.values.toList().forEach((m) {
      m.lasttimes = 0;
      m.todaytimes = 0;
      m.runtimes = 0;
      m.lastpower = 0.0;
      m.todaypower = 0.0;
      m.totalpower = 0.0;
    });

    if (GlobalVar.lstPower == null)
      GlobalVar.lstPower = {};
    else
      GlobalVar.lstPower.clear();

    if (rm.data != null && rm.data.length > 0) {
      // print(
      //     '@@@ DeviceBO.setPowerData() rm.data.length : ${rm.data?.length}');
      rm.data.forEach((m) {
        PowerModel pm = m as PowerModel;
        ControlPanelModel cpm = GlobalVar.lstControlPanel[pm.id];
        //  print(
        //   '@@@ DeviceBO.setPowerData() cpm.id : ${cpm?.id}');
        if (cpm != null) {
          DeviceModel dm = GlobalVar.lstDevice[cpm.did];

          if (dm != null) {
            dm.lasttimes = dm.lasttimes + pm.lasttimes;
            dm.todaytimes = dm.todaytimes + pm.todaytimes;
            dm.runtimes = dm.runtimes + pm.runtimes;
            dm.lastpower =
                dm.lastpower + AppBO.getPower(pm.lasttimes, pm.power);
            dm.todaypower =
                dm.todaypower + AppBO.getPower(pm.todaytimes, pm.power);
            dm.totalpower =
                dm.totalpower + AppBO.getPower(pm.runtimes, pm.power);
            dm.power = pm.power;
          }
        }

        // print('@@@ pm : ${pm.toJsonStr()}');
        // GlobalVar.lstPower[pm.id] = pm;
      });

      if (isfire == 1) {
        GlobalVar.lstDevice.values.toList().forEach((m) {
          PowerModel pm = PowerModel(
            id: m.id,
            lasttimes: m.lasttimes,
            todaytimes: m.todaytimes,
            runtimes: m.runtimes,
            lastpower: m.lastpower,
            todaypower: m.todaypower,
            totalpower: m.totalpower,
            power: m.power,
          );
          GlobalVar.lstPower[m.id] = pm;
          eventBus.fire(PowerEvent(pm));
        });
      }
    }
  }
}
