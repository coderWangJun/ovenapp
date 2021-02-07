import 'RootModel.dart';

class PowerModel extends RootModel {
  String id;
  int runtimes = 0;
  int lasttimes = 0;
  int todaytimes = 0;
  int power = 0;
  double totalpower = 0.0;
  double lastpower = 0.0;
  double todaypower = 0.0;

  PowerModel({
    this.id,
    this.runtimes,
    this.lasttimes,
    this.todaytimes,
    this.power,
    this.totalpower,
    this.lastpower,
    this.todaypower,
  }) : super();

  static getEmptyObj() {
    return PowerModel(
      id: '0',
      runtimes: 0,
      lasttimes: 0,
      todaytimes: 0,
      totalpower: 0.0,
      lastpower: 0.0,
      todaypower: 0.0,
      power: 0,
    );
  }

  fromJson(Map<String, dynamic> parsedJson) {
    return PowerModel(
      id: parsedJson['id'] == null ? '0' : parsedJson['id'],
      runtimes: parsedJson['runtimes'] == null ? 0 : parsedJson['runtimes'],
      lasttimes: parsedJson['lasttimes'] == null ? 0 : parsedJson['lasttimes'],
      todaytimes:
          parsedJson['todaytimes'] == null ? 0 : parsedJson['todaytimes'],
      power: parsedJson['power'] == null ? 0 : parsedJson['power'],
      totalpower:
          parsedJson['totalpower'] == null ? 0.0 : parsedJson['totalpower'],
      lastpower:
          parsedJson['lastpower'] == null ? 0.0 : parsedJson['lastpower'],
      todaypower:
          parsedJson['todaypower'] == null ? 0.0 : parsedJson['todaypower'],
    );
  }

  toJsonStr() {
    return '{"id":"${this.id}",' +
        '"runtimes":${this.runtimes},' +
        '"lasttimes":${this.lasttimes},' +
        '"todaytimes":${this.todaytimes},' +
        '"power":${this.power},' +
        '"totalpower":${this.totalpower},' +
        '"lastpower":${this.lastpower},' +
        '"todaypower":${this.todaypower},' +
        '}';
  }
}
