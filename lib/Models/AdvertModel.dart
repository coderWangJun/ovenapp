import 'RootModel.dart';

class AdvertModel extends RootModel {
  int id;
  String title;
  String mainpic;
  String url;
  String text;
  int atype;

  AdvertModel({
    this.id,
    this.title,
    this.mainpic,
    this.atype,
    this.url,
    this.text,
  }) : super();

  fromJson(Map<String, dynamic> parsedJson) {
    return AdvertModel(
      id: parsedJson['id'] == null ? 0 : parsedJson['id'],
      mainpic: parsedJson['mainpic'] == null ? '' : parsedJson['mainpic'],
      url: parsedJson['url'] == null ? '' : parsedJson['url'],
      text: parsedJson['text'] == null ? '' : parsedJson['text'],
      title: parsedJson['title'] == null ? '' : parsedJson['title'],
      atype: parsedJson['atype'] == null ? 0 : parsedJson['atype'],
    );
  }

  toJsonStr() {
    return '{"id":${this.id},' +
        '"mainpic":"${this.mainpic}",' +
        '"text":"${this.text}",' +
        '"url":"${this.url}",' +
        '"title":"${this.title}",' +
        '"atype":${this.atype},' +        
        '}';
  }
}
