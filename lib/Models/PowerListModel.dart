import 'RootModel.dart';

class PowerListModel extends RootModel {
  String deviceid;
  String begindt;
  String enddt;
  int worktimes;
  double power;
  String dt;
  String tb;
  String te;
  int ttype;
  String clientid;
  String controlpanelid;
  String name;

  PowerListModel({
    this.deviceid,
    this.begindt,
    this.enddt,
    this.dt,
    this.tb,
    this.te,
    this.worktimes,
    this.ttype,
    this.clientid,
    this.controlpanelid,
    this.power,
    this.name,
  }) : super();

  fromJson(Map<String, dynamic> parsedJson) {
    return PowerListModel(
      deviceid: parsedJson['deviceid'] == null ? '0' : parsedJson['deviceid'],
      begindt: parsedJson['begindt'] == null ? '' : parsedJson['begindt'],
      enddt: parsedJson['enddt'] == null ? '' : parsedJson['enddt'],
      dt: parsedJson['dt'] == null ? '' : parsedJson['dt'],
      tb: parsedJson['tb'] == null ? '' : parsedJson['tb'],
      te: parsedJson['te'] == null ? '' : parsedJson['te'],
      clientid: parsedJson['clientid'] == null ? '' : parsedJson['clientid'],
      controlpanelid: parsedJson['controlpanelid'] == null
          ? ''
          : parsedJson['controlpanelid'],
      worktimes: parsedJson['worktimes'] == null ? 0 : parsedJson['worktimes'],
      ttype: parsedJson['ttype'] == null ? 0 : parsedJson['ttype'],
      power: parsedJson['power'] == null ? 0 : parsedJson['power'],
      name: parsedJson['name'] == null ? '' : parsedJson['name'],
    );
  }

  toJsonStr() {
    return '{' +
        '"deviceid":"${this.deviceid}",' +
        '"begindt":"${this.begindt}",' +
        '"enddt":"${this.enddt}",' +
        '"dt":"${this.dt}",' +
        '"tb":"${this.tb}",' +
        '"te":"${this.te}",' +
        '"clientid":"${this.clientid}",' +
        '"controlpanelid":"${this.controlpanelid}",' +
        '"name":"${this.name}",' +
        '"worktimes":${this.worktimes},' +
        '"ttype":${this.ttype},' +
        '"power":${this.power},' +
        '}';
  }
}
