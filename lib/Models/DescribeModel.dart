import 'package:ovenapp/Models/RootModel.dart';

class DescribeModel  extends RootModel{
   int id;
  int indexno;
  String memo;
  String mainpic;
  int tid;
  int ttype;

  DescribeModel({
    this.id,
    this.memo,
    this.indexno,
    this.mainpic,
    this.tid,
    this.ttype,
  }) : super();

  fromJson(Map<String, dynamic> parsedJson) {
    return DescribeModel(
      id: parsedJson['id'] == null ? 0 : parsedJson['id'],
      indexno: parsedJson['indexno'] == null ? 0 : parsedJson['indexno'],
      memo: parsedJson['memo'] == null ? "" : parsedJson['memo'],
      ttype: parsedJson['ttype'] == null ? 0 : parsedJson['ttype'],
      mainpic:
          parsedJson['mainpic'] == null ? "camera.png" : parsedJson['mainpic'],
      tid: parsedJson['tid'] == null ? 0 : parsedJson['tid'],
    );
  }

  toJsonStr() {
    return '{"id":${this.id},' +
        '"indexno":${this.indexno},' +
        '"memo":"${this.memo}",' +
        '"mainpic":"${this.mainpic}",' +
        '"tid":${this.tid},' +
        '"ttype":${this.ttype}}';
  }
}