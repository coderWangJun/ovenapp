import 'package:flutter/material.dart';
import 'package:ovenapp/BusinessObjects/AppBO.dart';
import 'package:ovenapp/BusinessObjects/DeviceBO.dart';
import 'package:ovenapp/Classes/AppDialog.dart';
// import 'package:ovenapp/Classes/SharePrefHelper.dart';
// import 'package:ovenapp/BusinessObjects/DeviceBO.dart';
// import 'package:ovenapp/Classes/AppToast.dart';
// import 'package:ovenapp/Models/ControlPanelModel.dart';
import 'package:ovenapp/Models/DeviceModel.dart';
// import 'package:ovenapp/Models/DeviceModel.dart';
// import 'package:ovenapp/Models/DeviceModel.dart';
// import 'package:ovenapp/Pages/ControlPanelPage.dart';
import 'package:ovenapp/Publics/AppObjHelper.dart';
import 'package:ovenapp/Publics/DataHelper.dart';
import 'package:ovenapp/Publics/GlobalVar.dart';
import 'package:ovenapp/Services/EventBusSrv.dart';
import 'package:qrscan/qrscan.dart' as scanner;

class ScanBO {
  static scanQB(BuildContext context) async {
    // _showDeviceSelect(context); return;
    if (GlobalVar.userInfo == null) {
      // Navigator.of(context).pushNamed("/login");
      AppBO.goLogin(context);
      return;
    }
    String cameraScanResult = await scanner.scan();
    print("@@@ ScanBO.scanQB() => " + cameraScanResult);

    String uuid = AppObjHelper.checkQRCode(cameraScanResult);
    if (uuid == null) return;

    if (GlobalVar.lstControlPanel.containsKey(uuid)) {
      DeviceBO.showControlPanel(context, uuid);
    } else {
      _showDeviceSelect(context, uuid);
    }
  }

  static _showDeviceSelect(context, uuid) {
    List<String> _lst = [];
    List<String> _lstId = [];
    GlobalVar.lstDevice.forEach((k, v) {
      if (v.lstCP.length < 3) {
        _lst.add(v.name);
        _lstId.add(k);
      }
    });
    // _lst.add('萌芽萌芽');_lst.add('萌芽萌芽');_lst.add('萌芽萌芽');_lst.add('萌芽萌芽');_lst.add('萌芽萌芽');_lst.add('萌芽萌芽');_lst.add('萌芽萌芽');
    if (_lst.length > 0) {
      double ch = _lst.length * 51.0;
      if (ch > 180.0) ch = 400.0;
      AppDialog.showSelectedListViewIOS(context, '请选择要加入的设备：', _lst, ch, ((v) {
        print("@@@ ScanBO.scanQB() => v : " + v);
        DeviceModel dm = GlobalVar.lstDevice[_lstId[int.parse(v)]];
        print("@@@ ScanBO.scanQB() => dm.name : ${dm.name}");
        DeviceBO.addControlPanel(dm, uuid, -1, (uuid) {
          DeviceBO.showControlPanel(context, uuid);
        });
      }));
    } else {
      //无任何空闲设备的情况下新增
      DataHelpr.dataHandler('ControlPanel/Scan', {"uuid": uuid}, (rm) {
        DataHelpr.resultHandler(rm, () {
          eventBus.fire(DeviceEvent('refresh', DeviceModel(id: '0', name: uuid),
              0)); //此处name为新增的主板，设备界面刷新后马上跳至该控制面板；
          // SharePrefHelper.removeData(GlobalVar.spdevice);
          // DeviceModel dm = DeviceModel(
          //     id: rm.id,
          //     name: '设备#1',
          //     icon: 'deviceicon.png',
          //     indexno: 1,
          //     model: '202002');

          // GlobalVar.(dm);
        });
      });
    }
  }

  static getQRCodeByScan() async {
    String cameraScanResult = await scanner.scan();
    print("@@@ ScanBO.getQRCodeByScan => " + cameraScanResult);
    // Navigator.of(context).pushNamed("/controlpanel");
    String uuid = AppObjHelper.checkQRCode(cameraScanResult);
    return uuid;
  }
}
