import 'RootModel.dart';

class MyShareModel extends RootModel {
  int id;
  String title;
  String mainpic;
  String pictures;
  String memo;
  int ot;
  int viewcount;
  int likecount;
  int favoritecount;
  int commentcount;
  String createdt;

  MyShareModel({
    this.id,
    this.title,
    this.mainpic,
    this.pictures,
    this.createdt,
    // this.publishdt,
    this.memo,
    this.ot,
    this.viewcount,
    this.likecount,
    this.favoritecount,
    this.commentcount,
    // this.status,
    // this.viewstatus,
  }) : super();

  fromJson(Map<String, dynamic> parsedJson) {
    return MyShareModel(
      id: parsedJson['id'] == null ? 0 : parsedJson['id'],
      title: parsedJson['title'] == null ? '' : parsedJson['title'],
      mainpic: parsedJson['mainpic'] == null ? '' : parsedJson['mainpic'],
      pictures: parsedJson['pictures'] == null ? '' : parsedJson['pictures'],
      createdt: parsedJson['createdt'] == null
          ? DateTime.now().toString()
          : parsedJson['createdt'],
      memo: parsedJson['memo'] == null ? '' : parsedJson['memo'],
      ot: parsedJson['ot'] == null ? 0 : parsedJson['ot'],
      viewcount: parsedJson['viewcount'] == null ? 0 : parsedJson['viewcount'],
      likecount: parsedJson['likecount'] == null ? 0 : parsedJson['likecount'],
      favoritecount:
          parsedJson['favoritecount'] == null ? 0 : parsedJson['favoritecount'],
      commentcount:
          parsedJson['commentcount'] == null ? 0 : parsedJson['commentcount'],
    );
  }
}
