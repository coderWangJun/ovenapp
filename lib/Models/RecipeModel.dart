import 'package:ovenapp/Models/RootModel.dart';

class RecipeModel extends RootModel {
  int id;
  int indexno;
  String name;
  String memo;
  String mainpic;
  double amount;
  String unit;
  int tid;

  RecipeModel({
    this.id,
    this.indexno,
    this.name,
    this.memo,
    this.mainpic,
    this.amount,
    this.unit,
    this.tid,
  }) : super();

  fromJson(Map<String, dynamic> parsedJson) {
    return RecipeModel(
      id: parsedJson['id'] == null ? 0 : parsedJson['id'],
      indexno: parsedJson['indexno'] == null ? 0 : parsedJson['indexno'],
      name: parsedJson['name'] == null ? "" : parsedJson['name'],
       memo: parsedJson['memo'] == null ? "" : parsedJson['memo'],
      unit: parsedJson['unit'] == null ? "" : parsedJson['unit'],
      mainpic:
          parsedJson['mainpic'] == null ? "camera.png" : parsedJson['mainpic'],
      tid: parsedJson['tid'] == null ? 0 : parsedJson['tid'],
      amount: parsedJson['amount'] == null ? 0.0 : parsedJson['amount'],
    );
  }

  toJsonStr() {
    return '{"id":${this.id},' +
        '"indexno":${this.indexno},' +
        '"name":"${this.name}",' +
        '"memo":"${this.memo}",' +
        '"unit":"${this.unit}",' +
        '"mainpic":"${this.mainpic}",' +
        '"tid":${this.tid},' +
        '"amount":${this.amount}}';
  }
}
