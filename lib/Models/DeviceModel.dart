import 'package:ovenapp/Models/ControlPanelModel.dart';

import 'RootModel.dart';

class DeviceModel extends RootModel {
  String id;
  int indexno;
  String name;
  String icon;
  String model;
  String memo;
  int runtimes = 0;
  int lasttimes = 0;
  int todaytimes = 0;
  double totalpower = 0.0;
  double lastpower = 0.0;
  double todaypower = 0.0;
  int power = 0;
  // int ccount=0;
  List<ControlPanelModel> lstCP = [];

  DeviceModel({
    this.id,
    this.indexno,
    this.name,
    this.icon,
    this.model,
    this.memo,
    this.runtimes,
    this.lasttimes,
    this.todaytimes,
    this.totalpower,
    this.lastpower,
    this.todaypower,
    this.power,
  }) : super();

  fromJson(Map<String, dynamic> parsedJson) {
    return DeviceModel(
      id: parsedJson['id'] == null ? '0' : parsedJson['id'],
      indexno: parsedJson['indexno'] == null ? 0 : parsedJson['indexno'],
      name: parsedJson['name'] == null ? '设备_#0' : parsedJson['name'],
      icon: parsedJson['icon'] == null ? 'deviceicon.png' : parsedJson['icon'],
      model: parsedJson['model'] == null ? '202002' : parsedJson['model'],
      memo: parsedJson['memo'] == null ? '' : parsedJson['memo'],
      runtimes: parsedJson['runtimes'] == null ? 0 : parsedJson['runtimes'],
    );
  }

  getState() {
    if (lstCP.length == 0) return 0;
    int ret = 0;
    lstCP.forEach((cpm) {
      if (cpm.state != 0) ret = 1;
    });
    return ret;
  }

  toJsonStr() {
    return '{"id":"${this.id}",' +
        '"indexno":${this.indexno},' +
        '"name":"${this.name}",' +
        '"memo":"${this.memo}",' +
        '"icon":"${this.icon}",' +
        '"model":"${this.model}",' +
        '"runtimes":${this.runtimes},' +
        '"lasttimes":${this.lasttimes},' +
        '"todaytimes":${this.todaytimes},' +
        '"totalpower":${this.totalpower},' +
        '"lastpower":${this.lastpower},' +
        '"todaypower":${this.todaypower},' +
         '"power":${this.power},' +
        '"lstCP.length":${this.lstCP?.length},' +
        '}';
  }
}
