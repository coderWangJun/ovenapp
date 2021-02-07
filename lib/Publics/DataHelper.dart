// import 'dart:convert';
// import 'package:flutter/material.dart';
import 'package:ovenapp/Classes/AppToast.dart';

import 'package:ovenapp/Classes/SharePrefHelper.dart';
// import 'package:ovenapp/Models/AdvertModel.dart';
import 'package:ovenapp/Models/HttpRetModel.dart';
// import 'package:ovenapp/Models/MaterialModel.dart';
// import 'package:ovenapp/Models/NewsModel.dart';
// import 'package:ovenapp/Models/RootModel.dart';
// import 'package:ovenapp/Models/TemplateModel.dart';
import 'package:ovenapp/Publics/GlobalVar.dart';
import 'package:ovenapp/Services/HttpCallerSrv.dart';

class DataHelpr {
  static printDataFrom(String module, int datafrom, int len) {
    print("@@@ $module from " +
        (datafrom == 0 ? "Cloud Server" : "Local Storage") +
        " data.length => $len");
  }

  static printData(String module, String str) {
    print("@@@ $module log : $str");
  }

  static printError(String module, String str) {
    print("*** $module error : $str");
  }

  // static getData(
  //     BuildContext context, String action, String spfile, String model,
  //     [Map<String, dynamic> param, String tk]) async {
  //   // print(
  //   //     "@@@ DataHelpr.getData() action : $action , spfile ：$spfile , model ：$model , param : $param , tk : $tk");

  //   int datafrom = 1;
  //   HttpRetModel rm;

  //   String jsonData = "";
  //   var jsonObj = await SharePrefHelper.getData(spfile);
  //   //String jsonData = await SharePrefHelper.getData(spfile); || jsonData == "" jsonObj == null ||
  //   // print("@@@ DataHelpr.getData() get data from Local Storage => " + jsonObj);
  //   if (jsonObj == null || jsonObj.toString() == "") {
  //     // print("@@@ DataHelpr.getData() HttpCallerSrv.get begin ...");
  //     datafrom = 0;
  //     jsonData = await HttpCallerSrv.get(action, param, tk); //param, tk
  //     // jsonData = await HttpCallerSrv.get(action, null);  //param, tk
  //     // print("@@@ DataHelpr.getData() $spfile : get data from Cloud Server => " +
  //     //     jsonData);
  //   } else {
  //     jsonData = jsonObj.toString();
  //     // print(
  //     //     "@@@ DataHelpr.getData() get data from Local Storage => " + jsonObj);
  //   }

  //   // print("@@@ DataHelpr.getData() begin decode jsonData : $jsonData");

  //   try {
  //     RootModel dataModel;
  //     switch (model) {
  //       case "NewsModel":
  //         dataModel = NewsModel();
  //         break;
  //       case "AdvertModel":
  //         dataModel = AdvertModel();
  //         break;
  //       case "MaterialModel":
  //         dataModel = MaterialModel();
  //         break;
  //     }

  //     Map<String, dynamic> ret = json.decode(jsonData);
  //     rm = HttpRetModel.fromJson(ret, dataModel);

  //     if (datafrom == 0 && rm != null) {
  //       SharePrefHelper.saveData(spfile, jsonData);
  //     }
  //   } catch (e) {
  //     rm = HttpRetModel.getEmptyObj(e.toString());
  //     SharePrefHelper.removeData(spfile);
  //     print("*** DataHelpr.getData() $spfile.data => $e");
  //   }

  //   // printDataFrom("DataHelpr.getData() $spfile.data", datafrom, rm.data.length);

  //   return rm;
  // }

  // static removeLocalData(String spfile) {
  //   SharePrefHelper.removeData(spfile);
  // }

  static Map<String, dynamic> _localData = {};

  static setLocalData(String name, dynamic data) {
    _localData[name] = data;
  }

  static removeLocalData(String name) {
    if (_localData.containsKey(name)) _localData.remove(name);
  }

  static getLocalData(String name) {
    var data = _localData[name];
    if (data != null)
      print(
          '@@@ DataHelpr.getLocalData($name) --> data.length : ${data.length}');
    else
      print('@@@ DataHelpr.getLocalData($name) data : null');
    return data;
  }

  // static handleData(String action, Map<String, dynamic> param, var okCallback,
  //     var failCallback, var errCallback, var completeCallback) async {
  //   await HttpCallerSrv.post(action, param, GlobalVar.userInfo.tk).then((f) {
  //     String jsonData = f;
  //     print('@@@ DataHelpr.handleData() f : $f');
  //     try {
  //       Map<String, dynamic> ret = json.decode(jsonData);
  //       print('@@@ DataHelpr.handleData() map : $ret');

  //       HttpRetModel retmodel = HttpRetModel.fromJsonExec(ret);

  //       print(
  //           '@@@ DataHelpr.handleData() retmodel.message : ${retmodel.message}');
  //       if (retmodel.ret == 0) {
  //         if (okCallback != null) okCallback(retmodel.id);
  //       } else {
  //         if (failCallback != null) failCallback(retmodel.message);
  //       }
  //     } catch (e) {
  //       if (failCallback != null) failCallback('解析错误：' + e.toString());
  //     }
  //   }).catchError((e) {
  //     if (errCallback != null) errCallback(e.toString());
  //   }).whenComplete(() {
  //     if (completeCallback != null) completeCallback();
  //     // isRun = 0;
  //   });
  // }

  static dataHandler(
      String action, Map<String, dynamic> param, var callback) async {
    await HttpCallerSrv.post(action, param, GlobalVar.userInfo.tk).then((f) {
      String jsonData = f;
      // print('@@@ DataHelpr.dataHandler() f : $f');
      if (jsonData == null || jsonData.toString().trim() == '') {
        if (callback != null) callback(HttpRetModel.getErrObj('数据返回为空！'));
      } else {
        try {
          // Map<String, dynamic> ret = json.decode(jsonData);
          // print('@@@ DataHelpr.dataHandler() ret : $ret');
          // HttpRetModel retmodel = HttpRetModel.fromJsonExec(ret);
          // print('@@@ DataHelpr.dataHandler() retmodel.id : ${retmodel.id}');
          HttpRetModel retmodel = HttpRetModel.fromJsonStr(jsonData);
          // print(
          //     '@@@ DataHelpr.dataHandler() retmodel : ${retmodel.toJsonStr()}');

          if (callback != null) callback(retmodel);
        } catch (e) {
          callback(HttpRetModel.getAnalyizeErrObj());
        }
      }
    }).catchError((e) {
      if (callback != null) callback(HttpRetModel.getErrObj(e));
    });
    // .whenComplete(() {
    //   // if (callback != null) completeCallback();
    //   // isRun = 0;
    // });
  }

  static resultHandler(HttpRetModel rm, var okCallback) {
    if (rm.ret == 0) {
      if (okCallback != null)
        okCallback();
      else
        AppToast.showToast('保存失败: ${rm.message}');
    }
  }

  static dataQuerier(String action, Map<String, dynamic> param,
      List<dynamic> lstObj, var callback,
      [String spfile = '']) async {
    await HttpCallerSrv.getData(action, param,
            GlobalVar.userInfo == null ? '' : GlobalVar.userInfo.tk)
        .then((f) {
      // print('@@@ DataHelpr.selectData($action,$param) then --> f : $f');

      if (f == null) {
        if (callback != null) callback(HttpRetModel.getEmptyObj('返回数据为空！'));
        return;
      }

      String jsonData = f
          .toString()
          .replaceAll('\r\n', '')
          .replaceAll('\r', '')
          .replaceAll('\n', '');
      // print('@@@ DataHelpr.selectData() jsonData : $jsonData');
      try {
        // Map<String, dynamic> ret = json.decode(jsonData);
        // HttpRetModel retmodel = HttpRetModel.fromJson(ret, objModel);
        HttpRetModel retmodel = HttpRetModel.fromJsonStr(jsonData, lstObj);

        if (retmodel.ret == 0 && spfile != '')
          SharePrefHelper.saveData(spfile, jsonData);

        // print('@@@ DataHelpr.selectData() %%%%%%%%%%%%%%%%%%%%% retmodel.ret : ${retmodel.ret}');

        if (callback != null) callback(retmodel);
      } catch (e) {
        print(
            '*** DataHelpr.selectData() action : $action , param : $param / decode err --> e : $e');
        callback(HttpRetModel.getAnalyizeErrObj(e));
      }
    }).catchError((e) {
      print(
          '*** DataHelpr.selectData() action : $action ,param : $param / catchError --> e : $e');
      if (callback != null) callback(HttpRetModel.getErrObj(e));
    });
  }

  static String retStr = "";
//执行一个简单的查询结果，不出错即为正确
  static retQuerier(String action, Map<String, dynamic> param) async {
    // String retStr = "";
    try {
      var ret = await HttpCallerSrv.getData(action, param,
          GlobalVar.userInfo == null ? '' : GlobalVar.userInfo.tk);

      // print('@@@ DataHelpr.retQuerier() ret : $ret');

      String jsonData = ret
          .toString()
          .replaceAll('\r\n', '')
          .replaceAll('\r', '')
          .replaceAll('\n', '');

      // print('@@@ DataHelpr.retQuerier() jsonData : $jsonData');

      return HttpRetModel.fromJsonStr(jsonData);
    } catch (e) {
      print('*** DataHelpr.retQuerier() e : ');
      print(e);
      retStr = e.toString();
      return HttpRetModel.getCustomErr(-1, retStr);
    }
  }

//objModel必须继承自 RootModel,带有方法 fromJson
  // static queryData(
  //     String action, Map<String, dynamic> param, objModel, var callback,
  //     [String spfile = '']) async {
  //   await HttpCallerSrv.getData(action, param,
  //           GlobalVar.userInfo == null ? '' : GlobalVar.userInfo.tk)
  //       .then((f) {
  //     // print('@@@ DataHelpr.queryData($action,$param) then --> f : $f');

  //     if (f == null) {
  //       if (callback != null) callback(HttpRetModel.getEmptyObj('返回数据为空！'));
  //       return;
  //     }

  //     String jsonData = f.toString().replaceAll('\r', '').replaceAll('\r', '');
  //     print('@@@ DataHelpr.queryData() jsonData : $jsonData');
  //     try {
  //       Map<String, dynamic> ret = json.decode(jsonData);
  //       HttpRetModel retmodel = HttpRetModel.fromJson(ret, objModel);
  //       // print(
  //       //     '@@@ DataHelpr.queryData() data.length : ${retmodel.data.length}');
  //       if (spfile != '') SharePrefHelper.saveData(spfile, jsonData);

  //       if (callback != null) callback(retmodel);
  //     } catch (e) {
  //       print('*** DataHelpr.queryData() decode err --> e : $e');
  //       callback(HttpRetModel.getAnalyizeErrObj(e));
  //     }
  //   }).catchError((e) {
  //     print('*** DataHelpr.queryData() catchError --> e : $e');
  //     if (callback != null) callback(HttpRetModel.getErrObj(e));
  //   });
  // }

  //objModel必须继承自 RootModel,带有方法 fromJson
  // static queryData2(
  //     String action, Map<String, dynamic> param, objModel, objModel2,
  //     [String spfile, var callback]) async {
  //   print('@@@ DataHelpr.queryData2($action,$param,$spfile) ...');
  //   await HttpCallerSrv.getData(action, param, GlobalVar.userInfo.tk).then((f) {
  //     // print('@@@ DataHelpr.queryData2() then --> f : $f'); //$action,$param

  //     if (f == null) {
  //       if (callback != null) callback(HttpRetModel.getEmptyObj('返回数据为空！'));
  //       return;
  //     }

  //     String jsonData = f.toString().replaceAll('\r', '').replaceAll('\r', '');
  //     try {
  //       // print('@@@ DataHelpr.queryData2() jsonData : $jsonData');
  //       Map<String, dynamic> ret = json.decode(jsonData);
  //       // print('@@@ DataHelpr.queryData2() ret : $ret');
  //       HttpRetModel retmodel =
  //           HttpRetModel.fromJson1(ret, objModel, objModel2);
  //       // print(
  //       //     '@@@ DataHelpr.queryData() data.length : ${retmodel.data.length},data1.length : ${retmodel.data1.length}');

  //       // if (spfile != null && spfile.trim() != '') {
  //       //   SharePrefHelper.saveData(spfile, jsonData);
  //       // }

  //       if (callback != null) {
  //         callback(retmodel);
  //       }
  //     } catch (e) {
  //       print('@@@ DataHelpr.queryData() decode error --> e : $e');
  //       callback(HttpRetModel.getAnalyizeErrObj(e));
  //     }
  //   }).catchError((e) {
  //     print('@@@ DataHelpr.queryData() catchError --> e : $e');
  //     if (callback != null) callback(HttpRetModel.getErrObj(e));
  //   });
  // }

  // static queryResult(
  //     String action, Map<String, dynamic> param, var callback) async {
  //   await HttpCallerSrv.getData(action, param,
  //           GlobalVar.userInfo == null ? '' : GlobalVar.userInfo.tk)
  //       .then((f) {
  //     // print('@@@ DataHelpr.queryData($action,$param) then --> f : $f');

  //     if (f == null) {
  //       if (callback != null) callback(HttpRetModel.getEmptyObj('返回数据为空！'));
  //       return;
  //     }

  //     String jsonData = f.toString().replaceAll('\r', '').replaceAll('\r', '');
  //     try {
  //       // print('@@@ DataHelpr.queryData() jsonData : $jsonData');Type t,
  //       Map<String, dynamic> ret = json.decode(jsonData);
  //       HttpRetModel retmodel = HttpRetModel.fromJsonResult(ret);
  //       // print(
  //       //     '@@@ DataHelpr.queryData() data.length : ${retmodel.data.length}');

  //       if (callback != null) callback(retmodel);
  //     } catch (e) {
  //       print('*** DataHelpr.queryData() decode err --> e : $e');
  //       callback(HttpRetModel.getAnalyizeErrObj(e));
  //     }
  //   }).catchError((e) {
  //     print('*** DataHelpr.queryData() catchError --> e : $e');
  //     if (callback != null) callback(HttpRetModel.getErrObj(e));
  //   });
  // }
}
