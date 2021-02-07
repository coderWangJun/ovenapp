import 'package:ovenapp/Models/RootModel.dart';

class TModel extends RootModel {
  int id;
  int indexno;
  String name;
  String icon;  

  TModel({
    this.id,
    this.indexno,
    this.name,
    this.icon,
  }) : super();

  fromJson(Map<String, dynamic> parsedJson) {
    return TModel(
      id: parsedJson['id'],
      indexno: parsedJson['indexno'],
      name: parsedJson['name'],
      icon: parsedJson['icon'],
    );
  }
}