import 'RootModel.dart';

class NewsModel extends RootModel {
  int id;
  String title;
  String mainpic;
  String text;
  String url;
  String createdt;
  // String publishdt;
  String author;
  int companyid;
  int collect;
  int ctype;  //内容类型，0文本，1网页
  int ntype;  //新闻类型，0新闻，1广告，，，9未知
  // int viewstatus;

  NewsModel({
    this.id,
    this.title,
    this.mainpic,
    this.text,
    this.url,
    this.createdt,
    // this.publishdt,
    this.author,
    this.companyid,
    this.collect,
    this.ctype,
    this.ntype,
    // this.status,
    // this.viewstatus,
  }) : super();

  fromJson(Map<String, dynamic> parsedJson) {
    return NewsModel(
      id: parsedJson['id']==null?0:parsedJson['id'],
      title: parsedJson['title']==null?'':parsedJson['title'],
      mainpic: parsedJson['mainpic'] == null ? '' : parsedJson['mainpic'],
      // text: parsedJson['text']==null?'':parsedJson['text'],
      url: parsedJson['url']==null?'':parsedJson['url'],
      createdt: parsedJson['createdt']==null?DateTime.now().toString():parsedJson['createdt'],
      // publishdt: parsedJson['publishdt']==null?0:parsedJson['publishdt'],
      author: parsedJson['author']==null?'':parsedJson['author'],
      collect: parsedJson['collect']==null?0:parsedJson['collect'],
       ctype: parsedJson['ctype']==null?0:parsedJson['ctype'],
        ntype: parsedJson['ntype']==null?9:parsedJson['ntype'],
      companyid: parsedJson['companyid']==null?0:parsedJson['companyid'],
    );
  }

    toJsonStr() {
    return '{"id":${this.id},' +
        '"mainpic":"${this.mainpic}",' +
        '"text":"${this.text}",' +
        '"url":"${this.url}",' +
        '"title":"${this.title}",' +
        '"ctype":${this.ctype},' +        
        '}';
  }
}
