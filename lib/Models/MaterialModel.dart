import 'RootModel.dart';

//"id":1,"indexno":1,"name":"烘焙原料","title":"烘焙原料","icon":"material.png"}
class MaterialModel extends RootModel {
  int id;
  String name;
  String mainpic;
  String memo;
  int t1;
  int t2;
  String param;
  String unit;
  double price;
  String t1n;
  String t2n;
  int companyid;
  int ptype;

  MaterialModel({
    this.id,
    this.mainpic,
    this.name,
    this.t1,
    this.t2,
    this.t1n,
    this.t2n,
    this.param,
    this.companyid,
    this.ptype,
    this.memo,
    this.unit,
    this.price,
  }) : super();

  fromJson(Map<String, dynamic> parsedJson) {
    return MaterialModel(
      id: parsedJson['id'] == null ? 0 : parsedJson['id'],
      name: parsedJson['name'] == null ? '' : parsedJson['name'],
      mainpic: parsedJson['mainpic'] == null ? '' : parsedJson['mainpic'],
      t1: parsedJson['t1'] == null ? 0 : parsedJson['t1'],
      t2: parsedJson['t2'] == null ? 0 : parsedJson['t2'],
      companyid: parsedJson['companyid'] == null ? 0 : parsedJson['companyid'],
      ptype: parsedJson['ptype'] == null ? 0 : parsedJson['ptype'],
      param: parsedJson['param'] == null ? '' : parsedJson['param'],
      memo: parsedJson['memo'] == null ? '' : parsedJson['memo'],
      t1n: parsedJson['t1n'] == null ? '' : parsedJson['t1n'],
      t2n: parsedJson['t2n'] == null ? '' : parsedJson['t2n'],
      unit: parsedJson['unit'] == null ? '' : parsedJson['unit'],
      price: parsedJson['price'] == null ? 0.0 : parsedJson['price'],
    );
  }

  toJsonStr() {
    return '{"id":${this.id},' +
        '"name":"${this.name}",' +
        '"memo":"${this.memo}",' +
        '"mainpic":"${this.mainpic}",' +
        '"param":"${this.param}",' +
        '"t1":${this.t1},' +
        '"t2":${this.t2},' +
        '"t1n":"${this.t1n}",' +
        '"t2n":"${this.t2n}",' +
        '"price":${this.price},' +
        '"unit":"${this.unit}",' +
        '"ptype":${this.ptype},' +
        '"companyid":${this.companyid},' +
        '}';
  }
}
