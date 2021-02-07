class JPushModel {
  int jtype; //消息类型，0通知，1消息
  String title;
  String alert;
  String message;
  String tags;

  JPushModel({
    this.jtype,
    this.title,
    this.alert,
    this.message,
    this.tags,
  }) : super();

  fromJson(Map<String, dynamic> parsedJson) {
    return JPushModel(
      jtype: parsedJson['jtype'] == null ? 0 : parsedJson['jtype'],
      title: parsedJson['title'] == null ? "" : parsedJson['title'],
      alert: parsedJson['alert'] == null ? "" : parsedJson['alert'],
      message: parsedJson['message'] == null ? "" : parsedJson['message'],
      tags: parsedJson['tags'] == null ? [] : parsedJson['tags'],
    );
  }

  toJsonStr() {
    return '{' +
        '"id":${this.jtype},' +
        '"title":"${this.title}",' +
        '"alert":"${this.alert}",' +
        '"message":"${this.message}",' +
        '"tags":${this.tags},' +
        '}';
  }
}

class PushEventModel {
  String app;
  String module;
  String event;
  String data;
  String data1;
  String data2;
  String data3;

  PushEventModel({
    this.app,
    this.module,
    this.event,
    this.data,
    this.data1,
    this.data2,
    this.data3,
  }) : super();

  static fromJson(Map<String, dynamic> parsedJson) {
    return PushEventModel(
      app: parsedJson['app'] == null ? "" : parsedJson['app'],
      module: parsedJson['module'] == null ? "" : parsedJson['module'],
      event: parsedJson['event'] == null ? "" : parsedJson['event'],
      data: parsedJson['data'] == null ? "" : parsedJson['data'],
      data1: parsedJson['data1'] == null ? "" : parsedJson['data1'],
      data2: parsedJson['data2'] == null ? "" : parsedJson['data2'],
      data3: parsedJson['data3'] == null ? "" : parsedJson['data3'],
    );
  }

  toJsonStr() {
    return '{' +
        '"app":"${this.app}",' +
        '"module":"${this.module}",' +
        '"event":"${this.event}",' +
        '"data":"${this.data}",' +
        '"data1":"${this.data1}",' +
        '"data2":"${this.data2}",' +
        '"data3":"${this.data3}",' +
        '}';
  }
}
