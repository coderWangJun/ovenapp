import 'package:ovenapp/Models/RootModel.dart';

class WifiModel extends RootModel{
  String uuid;
  int state;
  String ssid;
  String password;
  String server;
  int port;
  int uptime;  

  WifiModel({
    this.uuid,
    this.state,
    this.ssid,
    this.password,
    this.server,
    this.port,
    this.uptime,   
  }) : super();

  fromJson(Map<String, dynamic> parsedJson) {
    return WifiModel(
      uuid: parsedJson['uuid']==null?"0":parsedJson['uuid'],
      state: parsedJson['state']==null?0:parsedJson['state'],
      ssid: parsedJson['ssid']==null?'0':parsedJson['ssid'],
      password: parsedJson['password']==null?'0':parsedJson['password'],
      server: parsedJson['server']==null?'0':parsedJson['server'],
      port: parsedJson['port']==null?0:parsedJson['port'],
      uptime: parsedJson['uptime']==null?0:parsedJson['uptime'],
    );
  }
}