import 'package:ovenapp/Models/RootModel.dart';

class VideoModel extends RootModel {
  int id;
  String title;
  String url;
  String memo;
  String mainpic;
  int viewcount;
  int attcount;
  int ispublished;
  String t1;
  String t2;
  int cid;
  String cname;

  VideoModel({
    this.id,
    this.cname,
    this.t1,
    this.t2,
    this.cid,
    this.title,
    this.viewcount,
    this.attcount,
    this.ispublished,
    this.mainpic,
    this.url,
    this.memo,
  }) : super();

  fromJson(Map<String, dynamic> parsedJson) {
    return VideoModel(
      id: parsedJson['id'] == null ? 0 : parsedJson['id'],
      viewcount: parsedJson['viewcount'] == null ? 0 : parsedJson['viewcount'],
      attcount: parsedJson['attcount'] == null ? 0 : parsedJson['attcount'],
      ispublished:
          parsedJson['ispublished'] == null ? 0 : parsedJson['ispublished'],
      cid: parsedJson['cid'] == null ? 0 : parsedJson['cid'],
      cname: parsedJson['cname'] == null ? '' : parsedJson['cname'],
      title: parsedJson['title'] == null ? '' : parsedJson['title'],
      t1: parsedJson['t1'] == null ? '' : parsedJson['t1'],
      t2: parsedJson['t2'] == null ? '' : parsedJson['t2'],
      url: parsedJson['url'] == null ? '' : parsedJson['url'],
      mainpic:
          parsedJson['mainpic'] == null ? 'Video.png' : parsedJson['mainpic'],
      memo: parsedJson['memo'] == null ? '' : parsedJson['memo'],
    );
  }

  toJsonStr() {
    return '{' +
        '"id":${this.id},' +
        '"viewcount":${this.viewcount},' +
        '"attcount":${this.attcount},' +
        '"cid":${this.cid},' +
        '"ispublished":${this.ispublished},' +
        '"cname":"${this.cname}",' +
        '"memo":"${this.memo}",' +
        '"mainpic":"${this.mainpic}",' +
        '"title":"${this.title}",' +
        '"t1":"${this.t1}",' +
        '"t2":"${this.t2}",' +
        '"url":"${this.url}",' +
        '}';
  }
}
