import 'RootModel.dart';

class SectionTimeModel extends RootModel {
  int id;
  int timer;
  int ups;
  int uptemp;
  int uppower;
  int downs;
  int downtemp;
  int downpower;
  int steamt;
  int tn;
  int sn;
  int tid;

  SectionTimeModel({
    this.id,
    this.timer,
    this.ups,
    this.uptemp,
    this.uppower,
    this.downs,
    this.downtemp,
    this.downpower,
    this.steamt,
    this.tn,
    this.sn,
    this.tid,
  }) : super();
// {"id":1,"tn":1,"sn":1,"timer":22,"ups":1,"uptemp":222,"uppower":3,"downs":1,"downtemp":333,"downpower":4}
  fromJson(Map<String, dynamic> parsedJson) {
    return SectionTimeModel(
      id: parsedJson['id'] == null ? 0 : parsedJson['id'],
      timer: parsedJson['timer'] == null ? 0 : parsedJson['timer'],
      ups: parsedJson['ups'] == null ? 0 : parsedJson['ups'],
      uptemp: parsedJson['uptemp'] == null ? 0 : parsedJson['uptemp'],
      uppower: parsedJson['uppower'] == null ? 0 : parsedJson['uppower'],
      downs: parsedJson['downs'] == null ? 0 : parsedJson['downs'],
      downtemp: parsedJson['downtemp'] == null ? 0 : parsedJson['downtemp'],
      downpower: parsedJson['downpower'] == null ? 0 : parsedJson['downpower'],
      steamt: parsedJson['steamt'] == null ? 0 : parsedJson['steamt'],
      tn: parsedJson['tn'] == null ? 0 : parsedJson['tn'],
      sn: parsedJson['sn'] == null ? 0 : parsedJson['sn'],
      tid: parsedJson['tid'] == null ? 0 : parsedJson['tid'],
    );
  }

  static getEmptyObj() {
    return SectionTimeModel(
      id: 0,
      timer: 0,
      ups: 1,
      uptemp: 0,
      uppower: 0,
      downs: 1,
      downtemp: 0,
      downpower: 0,
      steamt: 0,
      tn: 0,
      sn: 0,
      tid:0,
    );
  }

  // static toJson(SectionTimeModel obj) {
  //   return '{"id":${obj.id},"timer":${obj.timer},"ups":${obj.ups},"uptemp":${obj.uptemp},"uppower":${obj.uppower},"downs":${obj.downs},"downtemp":${obj.downtemp},"downpower":${obj.downpower},"steamt":${obj.steamt},"tn":${obj.tn},"sn":${obj.sn}}';
  // }

   toJsonStr() {
    return '{"id":${this.id},' +
        '"timer":${this.timer},' +
        '"ups":${this.ups},' +
        '"uptemp":${this.uptemp},' +
        '"uppower":${this.uppower},' +
        '"downs":${this.downs},' +
        '"downtemp":${this.downtemp}",' +
        '"downpower":${this.downpower},' +
        '"steamt":${this.steamt},' +
        '"tn":${this.tn},' +
        '"sn":${this.sn},' +
        '"tid":${this.tid}}';
  }
}
