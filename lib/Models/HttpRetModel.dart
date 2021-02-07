// import 'package:json_annotation/json_annotation.dart';
// import 'dart:convert';

import 'dart:convert';

import 'RootModel.dart';
// import 'NewsModel.dart';

class HttpRetModel {
  int ret;
  String id; //一般用作新记录id或查询单个数据结果的值
  String message;
  int pageno;
  int pagecount;
  int totalcount;
  int pagesize;
  List<dynamic> data = [];
  List<dynamic> data1 = [];
  List<dynamic> data2 = [];
  List<dynamic> data3 = [];
  DateTime dt;

  HttpRetModel({
    this.ret,
    this.id,
    this.message,
    this.data,
    this.data1,
    this.data2,
    this.data3,
    this.dt,
    this.pageno,
    this.pagecount,
    this.pagesize,
    this.totalcount,
  });

  factory HttpRetModel.fromJson(Map<String, dynamic> parsedJson, RootModel rm) {
    return HttpRetModel(
      ret: parsedJson['ret'] == null ? 1 : parsedJson['ret'],
      message: parsedJson['message'] == null
          ? 'Empty Message !'
          : parsedJson['message'],
      data: parsedJson['data'] == null
          ? []
          : (parsedJson['data'] as List)
              .map((item) => rm.fromJson(item))
              .toList(),
      pageno: parsedJson['pageno'] == null ? 0 : parsedJson['pageno'],
      pagecount: parsedJson['pagecount'] == null ? 0 : parsedJson['pagecount'],
      pagesize: parsedJson['pagesize'] == null ? 0 : parsedJson['pagesize'],
      totalcount:
          parsedJson['totalcount'] == null ? 0 : parsedJson['totalcount'],
      dt: parsedJson['dt'] == null
          ? DateTime.now()
          : DateTime.parse(parsedJson['dt']),
    );
  }

  factory HttpRetModel.fromJson1(
      Map<String, dynamic> parsedJson, RootModel rm, RootModel rm1) {
    return HttpRetModel(
      ret: parsedJson['ret'] == null ? 1 : parsedJson['ret'],
      message: parsedJson['message'] == null
          ? 'Empty Message !'
          : parsedJson['message'],
      //data:new List<String>.from(parsedJson['data']),
      // data: new NewsMode.fromJson(parsedJson['data']),
      // data: (parsedJson['data'] as List)
      //     .map((i) => NewsMode.fromJson(i))
      //     .toList(),
      data: parsedJson['data'] == null
          ? []
          : (parsedJson['data'] as List)
              .map((item) => rm.fromJson(item))
              .toList(),
      data1: parsedJson['data1'] == null
          ? []
          : (parsedJson['data1'] as List)
              .map((item) => rm1.fromJson(item))
              .toList(),
      dt: parsedJson['dt'] == null
          ? DateTime.now()
          : DateTime.parse(parsedJson['dt']),
    );
  }

  factory HttpRetModel.fromJson2(Map<String, dynamic> parsedJson, RootModel rm,
      RootModel rm1, RootModel rm2) {
    return HttpRetModel(
      ret: parsedJson['ret'] == null ? 1 : parsedJson['ret'],
      message: parsedJson['message'] == null
          ? 'Empty Message !'
          : parsedJson['message'],
      //data:new List<String>.from(parsedJson['data']),
      // data: new NewsMode.fromJson(parsedJson['data']),
      // data: (parsedJson['data'] as List)
      //     .map((i) => NewsMode.fromJson(i))
      //     .toList(),
      data: parsedJson['data'] == null
          ? []
          : (parsedJson['data'] as List)
              .map((item) => rm.fromJson(item))
              .toList(),
      data1: parsedJson['data1'] == null
          ? []
          : (parsedJson['data1'] as List)
              .map((item) => rm1.fromJson(item))
              .toList(),
      data2: parsedJson['data2'] == null
          ? []
          : (parsedJson['data2'] as List)
              .map((item) => rm2.fromJson(item))
              .toList(),
      dt: parsedJson['dt'] == null
          ? DateTime.now()
          : DateTime.parse(parsedJson['dt']),
    );
  }

  factory HttpRetModel.fromJson3(Map<String, dynamic> parsedJson, RootModel rm,
      RootModel rm1, RootModel rm2, RootModel rm3) {
    return HttpRetModel(
      ret: parsedJson['ret'] == null ? 1 : parsedJson['ret'],
      message: parsedJson['message'] == null
          ? 'Empty Message !'
          : parsedJson['message'],
      //data:new List<String>.from(parsedJson['data']),
      // data: new NewsMode.fromJson(parsedJson['data']),
      // data: (parsedJson['data'] as List)
      //     .map((i) => NewsMode.fromJson(i))
      //     .toList(),
      data: parsedJson['data'] == null
          ? []
          : (parsedJson['data'] as List)
              .map((item) => rm.fromJson(item))
              .toList(),
      data1: parsedJson['data1'] == null
          ? []
          : (parsedJson['data1'] as List)
              .map((item) => rm1.fromJson(item))
              .toList(),
      data2: parsedJson['data2'] == null
          ? []
          : (parsedJson['data2'] as List)
              .map((item) => rm2.fromJson(item))
              .toList(),
      data3: parsedJson['data3'] == null
          ? []
          : (parsedJson['data3'] as List)
              .map((item) => rm3.fromJson(item))
              .toList(),
      dt: parsedJson['dt'] == null
          ? DateTime.now()
          : DateTime.parse(parsedJson['dt']),
    );
  }

  factory HttpRetModel.fromMap(Map<String, dynamic> parsedJson,
      [List<dynamic> lstObj]) {
    return _getHttpRetModelFromMap(parsedJson, lstObj);
  }

  factory HttpRetModel.fromJsonStr(String jsonData, [List<dynamic> lstObj]) {
    if (jsonData == null || jsonData.trim() == '')
      return getAnalyizeErrObj('解析字符为空！');

    try {
      Map<String, dynamic> parsedJson = json.decode(jsonData);
      return _getHttpRetModelFromMap(parsedJson, lstObj);
    } catch (e) {
      return getAnalyizeErrObj();
    }
  }

  static _getHttpRetModelFromMap(Map<String, dynamic> parsedJson,
      [List<dynamic> lstObj]) {
    // HttpRetModel rm=HttpRetModel();
    if (parsedJson == null) return getEmptyObj("操作失败！");

    if (parsedJson['ret'] == null) return getAnalyizeErrObj();

    HttpRetModel hm = HttpRetModel(
        ret: parsedJson['ret'] == null ? 1 : parsedJson['ret'],
        message: parsedJson['message'] == null
            ? 'Empty Message !'
            : parsedJson['message'],
        id: parsedJson['id'] == null ? '0' : parsedJson['id'].toString(),
        pageno: parsedJson['pageno'] == null ? 0 : parsedJson['pageno'],
        pagecount:
            parsedJson['pagecount'] == null ? 0 : parsedJson['pagecount'],
        pagesize: parsedJson['pagesize'] == null ? 0 : parsedJson['pagesize'],
        totalcount:
            parsedJson['totalcount'] == null ? 0 : parsedJson['totalcount'],
        dt: parsedJson['dt'] == null
            ? DateTime.now()
            : DateTime.parse(parsedJson['dt']));

    if (lstObj != null && lstObj.isNotEmpty) {
      // String dm='data';
      for (int i = 0; i < lstObj.length; i++) {
        String dm = 'data${i == 0 ? "" : i.toString()}';

        RootModel rm = lstObj[i] as RootModel;
        switch (i) {
          case 0:
            hm.data = _getData(parsedJson, rm, dm);
            break;
          case 1:
            hm.data1 = _getData(parsedJson, rm, dm);
            break;
          case 2:
            hm.data2 = _getData(parsedJson, rm, dm);
            break;
          case 3:
            hm.data3 = _getData(parsedJson, rm, dm);
            break;
          default:
        }
      }
    }

    return hm;
  }

  static _getData(Map<String, dynamic> parsedJson, RootModel rm, String dm) {
    if (parsedJson[dm] == null)
      return [];
    else
      return (parsedJson[dm] as List).map((item) => rm.fromJson(item)).toList();
  }

  // List<dynamic> _getData1(Map map, RootModel rm) {
  //   if (map == null) return null;
  //   return (map['data'] as List).map((item) => rm.fromJson(item)).toList();
  // }

  factory HttpRetModel.fromJsonExec(Map<String, dynamic> parsedJson) {
    if (parsedJson == null) return getEmptyObj("操作失败！");

    if (parsedJson['ret'] == null) return getAnalyizeErrObj();

    //  print('@@@ HttpRetModel.fromJsonExec() parsedJson[id] : ${parsedJson['id']}');

    return HttpRetModel(
      ret: parsedJson['ret'] == null ? 2 : parsedJson['ret'],
      message: parsedJson['message'] == null
          ? 'Empty Message !'
          : parsedJson['message'],
      id: parsedJson['id'] == null ? '0' : parsedJson['id'].toString(),
      //可利用分页参数传递额外的数据
      pageno: parsedJson['pageno'] == null ? 0 : parsedJson['pageno'],
      pagecount: parsedJson['pagecount'] == null ? 0 : parsedJson['pagecount'],
      pagesize: parsedJson['pagesize'] == null ? 0 : parsedJson['pagesize'],
      totalcount:
          parsedJson['totalcount'] == null ? 0 : parsedJson['totalcount'],
      dt: parsedJson['dt'] == null
          ? DateTime.now()
          : DateTime.parse(parsedJson['dt']),
    );
  }

  factory HttpRetModel.fromJsonResult(Map<String, dynamic> parsedJson) {
    if (parsedJson == null) return getEmptyObj("查询失败！");
    if (parsedJson['ret'] == null) return getAnalyizeErrObj();
    return HttpRetModel(
      ret: parsedJson['ret'] == null ? 1 : parsedJson['ret'],
      message: parsedJson['message'] == null
          ? 'Empty Message !'
          : parsedJson['message'],
      id: parsedJson['id'] == null ? '0' : parsedJson['id'].toString(),
      dt: parsedJson['dt'] == null
          ? DateTime.now()
          : DateTime.parse(parsedJson['dt']),
    );
  }

  static getEmptyObj(String msg) {
    return HttpRetModel(
      ret: 101,
      id: "0",
      message: msg,
      data: [],
      data1: [],
      data2: [],
      data3: [],
      dt: DateTime.now(),
      // pageno: 0,
      // pagecount: 0,
      // pagesize: 10,
      // totalcount: 0,
    );
  }

  static HttpRetModel getAnalyizeErrObj([String err = '解析错误！']) {
    return HttpRetModel(
      ret: 102,
      id: "0",
      message: err,
      dt: DateTime.now(),
    );
  }

  static HttpRetModel getCustomErr(int code, String msg) {
    return HttpRetModel(
      ret: code,
      message: msg,
      dt: DateTime.now(),
    );
  }

  static HttpRetModel getExecRet(var jsonStr) {
    print("@@@ HttpRetModel.getExecRet(jsonStr : $jsonStr)");
    try {
      Map map = json.decode(jsonStr.toString());

      HttpRetModel retmodel = HttpRetModel.fromJsonExec(map);
      return retmodel;
    } catch (e) {
      return getAnalyizeErrObj();
    }
  }

  static HttpRetModel getErrObj(String msg) {
    return HttpRetModel(
      ret: 104,
      id: "0",
      message: msg,
      dt: DateTime.now(),
    );
  }

  static HttpRetModel getFinishObj(String msg) {
    return HttpRetModel(
      ret: 103,
      id: "0",
      message: msg,
      dt: DateTime.now(),
    );
  }

  static HttpRetModel getNullParam() {
    return HttpRetModel(
      ret: 105,
      id: "0",
      message: '对象为NULL',
      dt: DateTime.now(),
    );
  }

  toJsonStr() {
    return '{' +
        '"ret":${this.ret},' +
        '"id":"${this.id}",' +
        '"message":"${this.message}",' +
        '"pageno":${this.pageno},' +
        '"pagecount":${this.pagecount},' +
        '"pagesize":${this.pagesize},' +
        '"totalcount":${this.totalcount},' +
        '"data.length":${this.data?.length},' +
        '"data1.length":${this.data1?.length},' +
        '"data2.length":${this.data2?.length}' +
        '"data3.length":${this.data3?.length}' +
        '"dt":"${this.dt}"' +
        '}';
  }

  // factory HttpRetModel.fromJson(Map<String, dynamic> parsedJson,RootModel rm) {
  //   return HttpRetModel(
  //     ret: parsedJson['ret'],
  //     message: parsedJson['message'],
  //     //data:new List<String>.from(parsedJson['data']),
  //     // data: new NewsMode.fromJson(parsedJson['data']),
  //     // data: (parsedJson['data'] as List)
  //     //     .map((i) => NewsMode.fromJson(i))
  //     //     .toList(),
  //     data: (parsedJson['data'] as List)
  //         .map((i) => rm.fromJson(i))
  //         .toList(),
  //     dt: DateTime.parse(parsedJson['dt']),
  //   );
  // }

  // _getList(String js) {
  //   Map<String, dynamic> ret = json.decode(js);
  //   return NewsMode.fromJson(ret);
  // }
}
