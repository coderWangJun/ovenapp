import 'package:ovenapp/Models/RootModel.dart';

class AttentionModel extends RootModel {
  String id;
  String memo; 
  String name;
  String avatar; 
  int iid = 0;
  int attcount=0;
  String livepic;
  String livetitle;

  AttentionModel({
    this.id,
    this.attcount,
    this.name,
    this.avatar,
    this.memo,
    this.iid,
    this.livepic,
    this.livetitle,
  }) : super();

  fromJson(Map<String, dynamic> parsedJson) {
    return _getObjFromMap(parsedJson);
  }

  static _getObjFromMap(parsedJson) {
    return AttentionModel(
      id: parsedJson['id'] == null ? "0" : parsedJson['id'],
      memo: parsedJson['memo'] == null ? "敬请关注 ..." : parsedJson['memo'],
      name: parsedJson['name'] == null ? "" : parsedJson['name'],
      avatar: parsedJson['avatar'] == null ? "header.png" : parsedJson['avatar'],
      attcount: parsedJson['attcount'] == null ? 0 : parsedJson['attcount'],
      iid: parsedJson['iid'] == null ? 0 : parsedJson['iid'],
      livepic: parsedJson['livepic'] == null ? "livepic.jpg" : parsedJson['livepic'],     
      livetitle: parsedJson['livetitle'] == null ? "" : parsedJson['livetitle'],    
    );
  }

  static fromjson(Map<String, dynamic> parsedJson) {
    return _getObjFromMap(parsedJson);
  }

  String toJson() {
    return '{"id":"${this.id}","memo":"${this.memo}","name":"${this.name}","avatar":"${this.avatar}","livepic":"${this.livepic}","livetitle":"${this.livetitle}","attcount":${this.attcount},"iid":${this.iid}"}';
  }
}
