import 'dart:async';

import 'package:ovenapp/Services/EventBusSrv.dart';

import 'RootModel.dart';

class ControlPanelModel extends RootModel {
  int id;
  int indexno;
  String uuid;
  String did;
  String name;
  String icon;
  String devicename;
  String wifi;
  int iid;
  int state = 0;
  int offcount = 0;
  Timer tm;
  DateTime last;
  int power = 0;
  int runtimes = 0;
  int lasttimes = 0;
  int todaytimes = 0;

  ControlPanelModel({
    this.id,
    this.indexno,
    this.name,
    this.icon,
    this.uuid,
    this.did,
    this.devicename,
    this.wifi,
    this.iid,
    this.power,
    this.runtimes,
    this.lasttimes,
    this.todaytimes,
  }) : super();

  initTimer() {
    if (tm != null) return;
    tm = Timer.periodic(Duration(seconds: 1), (timer) {
      offcount++;
      if (offcount > 6 && state != 0) {
        state = 0;
        //发送掉线消息
        eventBus.fire(DeviceDataEvent(did));
        print(
            "@@@ ControlPanelModel.initTimer()  uuid : $uuid , state : $state , offcount : $offcount");
      }
    });
  }

  setState(v) {
    last = DateTime.now();
    state = v;
    offcount = 0;
  }

  fromJson(Map<String, dynamic> parsedJson) {
    return ControlPanelModel(
      id: parsedJson['id'] == null ? 0 : parsedJson['id'],
      indexno: parsedJson['indexno'] == null ? 0 : parsedJson['indexno'],
      name: parsedJson['name'] == null ? '' : parsedJson['name'],
      icon: parsedJson['icon'] == null ? 'oven.png' : parsedJson['icon'],
      uuid: parsedJson['uuid'] == null ? '0' : parsedJson['uuid'],
      did: parsedJson['did'] == null ? '0' : parsedJson['did'],
      devicename:
          parsedJson['devicename'] == null ? '' : parsedJson['devicename'],
      wifi: parsedJson['wifi'] == null ? '' : parsedJson['wifi'],
      iid: parsedJson['iid'] == null ? 0 : parsedJson['iid'],
      power: parsedJson['power'] == null ? 0 : parsedJson['power'],
      runtimes: parsedJson['runtimes'] == null ? 0 : parsedJson['runtimes'],
      // lasttimes: parsedJson['lasttimes'] == null ? 0 : parsedJson['lasttimes'],
      // todaytimes: parsedJson['todaytimes'] == null ? 0 : parsedJson['todaytimes'],
    );
  }

  toJsonStr() {
    return '{"id":${this.id},' +
        '"name":"${this.name}",' +
        '"indexno":${this.indexno},' +
        '"icon":"${this.icon}",' +
        '"uuid":"${this.uuid}",' +
        '"did":"${this.did}",' +
        '"devicename":"${this.devicename}",' +
        '"state":${this.state},' +
        '"power":${this.power},' +
        '"runtimes":${this.runtimes},' +
        '"lasttimes":${this.lasttimes},' +
        '"todaytimes":${this.todaytimes},' +
        '"offcount":${this.offcount},' +
        '"wifi":"${this.wifi}",' +
        '"last":"${last.toString()}",' +
        '"iid":${this.iid}}';
  }
}

// class ControlPanelDataModel with ChangeNotifier {
//   String _uuid;
//   String get uuid => _uuid;
//   int _state;
//   int get stat => _state;

//   void setUuid(String uuid) {
//     _uuid = uuid;
//     notifyListeners();
//   }

//   void setState(int state) {
//     _state = state;
//     notifyListeners();
//   }
// }
