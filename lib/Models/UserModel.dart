import 'RootModel.dart';

class UserModel extends RootModel {
  String id;
  String loginid; //登录id
  String name;
  String avatar; //头像
  int cid;
  int ot;
  String pn;
  String sn;
  String tk;
  String mp;
  int iid = 0;

  UserModel({
    this.id,
    this.loginid,
    this.name,
    this.avatar,
    this.cid,
    this.ot,
    this.pn,
    this.sn,
    this.tk,
    this.iid,
    this.mp,
  }) : super();

  fromJson(Map<String, dynamic> parsedJson) {
    return _getObjFromMap(parsedJson);
  }

  static _getObjFromMap(parsedJson) {
    return UserModel(
      id: parsedJson['id'] == null ? "0" : parsedJson['id'],
      loginid: parsedJson['loginid'] == null ? "" : parsedJson['loginid'],
      name: parsedJson['name'] == null ? "" : parsedJson['name'],
      avatar: parsedJson['avatar'] == null ? "" : parsedJson['avatar'],
      ot: parsedJson['ot'] == null ? 0 : parsedJson['ot'],
      cid: parsedJson['cid'] == null ? 0 : parsedJson['cid'],
      sn: parsedJson['sn'] == null ? "" : parsedJson['sn'],
      pn: parsedJson['pn'] == null ? "" : parsedJson['pn'],
      tk: parsedJson['tk'] == null ? "" : parsedJson['tk'],
      iid: parsedJson['iid'] == null ? 0 : parsedJson['iid'],
      mp: parsedJson['mp'] == null ? "mypic_2.jpg" : parsedJson['mp'],
    );
  }

  static fromjson(Map<String, dynamic> parsedJson) {
    return _getObjFromMap(parsedJson);
  }

  String tojson() {
    return '{"id":"${this.id}","loginid":"${this.loginid}","name":"${this.name}","avatar":"${this.avatar}","cid":${this.cid},"ot":${this.ot},"sn":"${this.sn}","pn":"${this.pn}","iid":${this.iid},"tk":"${this.tk}","mp":"${this.mp}"}';
  }
}
