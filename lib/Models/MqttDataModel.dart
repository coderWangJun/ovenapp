// import 'dart:async';

class MqttDataModel {
  String uuid;
  int state;
  int ups;
  List up;
  int downs;
  List down;
  List timer;
  List steam;
  List center;
  int gate;
  int light;
  int fan;
  int steams;
  int water;
  int gas;
  //int steamt;
  List steamt;
  int tn;
  int sn;
  int warn;
  String ssid;
  String password;
  String server;
  String port;
  String uptime;
  int uprises;
  int downrises;

  MqttDataModel({
    this.uuid,
    this.state,
    this.ups,
    this.up,
    this.downs,
    this.down,
    this.timer,
    this.steam,
    this.center,
    this.gate,
    this.light,
    this.fan,
    this.steams,
    this.water,
    this.gas,
    this.steamt,
    this.tn,
    this.sn,
    this.warn,
    this.ssid,
    this.password,
    this.server,
    this.port,
    this.uptime,
    this.uprises,
    this.downrises,
  }) : super();

  static fromJson(Map<String, dynamic> parsedJson) {
    return MqttDataModel(
      uuid: parsedJson['uuid'] == null ? "0" : parsedJson['uuid'],
      state: parsedJson['state'] == null ? 0 : parsedJson['state'],
      ups: parsedJson['ups'] == null ? 0 : parsedJson['ups'],
      up: parsedJson['up'] == null ? [0, 0, 0] : parsedJson['up'],
      downs: parsedJson['downs'] == null ? 0 : parsedJson['downs'],
      down: parsedJson['down'] == null ? [0, 0, 0] : parsedJson['down'],
      timer: parsedJson['timer'] == null ? [0, 0] : parsedJson['timer'],
      steam: parsedJson['steam'] == null ? [0, 0] : parsedJson['steam'],
      center: parsedJson['center'] == null ? [0, 0] : parsedJson['center'],
      gate: parsedJson['gate'] == null ? 0 : parsedJson['gate'],
      light: parsedJson['light'] == null ? 0 : parsedJson['light'],
      fan: parsedJson['fan'] == null ? 0 : parsedJson['fan'],
      steams: parsedJson['steams'] == null ? 0 : parsedJson['steams'],
      water: parsedJson['water'] == null ? 0 : parsedJson['water'],
      gas: parsedJson['gas'] == null ? 0 : parsedJson['gas'],
      steamt: parsedJson['steamt'] == null ? [0, 0] : parsedJson['steamt'],
      tn: parsedJson['tn'] == null ? 0 : parsedJson['tn'],
      sn: parsedJson['sn'] == null ? 0 : parsedJson['sn'],
      warn: parsedJson['warn'] == null ? 0 : parsedJson['warn'],
      ssid: parsedJson['ssid'] == null ? '0' : parsedJson['ssid'],
      password: parsedJson['passwd'] == null ? '0' : parsedJson['passwd'],
      server: parsedJson['server'] == null ? '0' : parsedJson['server'],
      port: parsedJson['port'] == null ? '0' : parsedJson['port'],
      uptime: parsedJson['uptime'] == null ? '0' : parsedJson['uptime'],
      uprises: parsedJson['uprises'] == null ? 0 : parsedJson['uprises'],
      downrises: parsedJson['downrises'] == null ? 0 : parsedJson['downrises'],
    );
  }

  toJsonStr() {
    return '{' +
        '"uuid":${this.uuid},' +
        '"state":${this.state},' +
        '"ups":${this.ups},' +
        '"uprises":${this.uprises},' +
        '"up":${this.up},' +
        '"downs":${this.downs},' +
        '"downrises":${this.downrises},' +
        '"down":${this.down},' +
        '"steams":${this.steams},' +
        '"steamt":${this.steamt},' +
        '"steam":${this.steam},' +
        '"timer":${this.timer},' +
        '"center":${this.center},' +
        '"light":${this.light},' +
        '"water":${this.water},' +
        '"gas":${this.gas},' +
        '"warn":${this.warn},' +
        '"fan":${this.fan}' +
        '"tn":${this.tn},' +
        '"sn":${this.sn}' +
        '}';
  }
 
 static getEmptyModel(){
   return MqttDataModel(
    uuid: "0",
    state: 0,
    timer: [420, 0],
    ups: 0,
    up: [200, 0, 0],
    downs: 0,
    down: [200, 0, 0],
    steam: [200, 0],
    center: [200, 0],
    steams: 0,
    steamt: [20, 0],
    gate: 0,
    light: 0,
    fan: 0,
    water: 0,
    gas: 0,
    sn: 0,
    tn: 0,
  );
 }
// factory HttpRetModel.fromJsonExec(Map<String, dynamic> parsedJson) {
//     return HttpRetModel(
//       ret: parsedJson['ret'],
//       message: parsedJson['message'],
//       id: parsedJson['id'],
//       dt: DateTime.parse(parsedJson['dt']),
//     );
//   }
  // String tojson() {
  //   return '{"id":' +
  //       id.toString() +
  //       ',"loginid":"' +
  //       loginid +
  //       ',"name":"' +
  //       name +
  //       '","avatar":"' +
  //       avatar +
  //       '","companyid":' +
  //       companyid.toString() +
  //       ',"userlevel":' +
  //       userlevel.toString() +
  //       ',"sn":"' +
  //       sn +
  //       '","tk":"' +
  //       tk +
  //       '"}';
  // }
}
