import 'RootModel.dart';
// "indexno":1,"imageurl":"B7E7C219CA73.jpg","text":"","ttype":0,"halign":"left"
class ImageTextModel extends RootModel {
  int indexno;
  String imageurl;
  String text;
  String halign;
  int ttype;

  ImageTextModel({
    this.indexno,
    this.imageurl,
    this.text,
    this.halign,
    this.ttype,
  }) : super();

  fromJson(Map<String, dynamic> parsedJson) {
    return ImageTextModel(
      indexno: parsedJson['indexno'] == null ? 0 : parsedJson['indexno'],
      imageurl: parsedJson['imageurl'] == null ? '' : parsedJson['imageurl'],
      halign: parsedJson['halign'] == null ? 'center' : parsedJson['halign'],
      text: parsedJson['text'] == null ? '' : parsedJson['text'],
      ttype: parsedJson['ttype'] == null ? 0 : parsedJson['ttype'],
    );
  }

  toJsonStr() {
    return '{"indexno":${this.indexno},' +
        '"imageurl":"${this.imageurl}",' +
        '"text":"${this.text}",' +
        '"halign":"${this.halign}",' +
        '"ttype":${this.ttype},' +        
        '}';
  }
}
