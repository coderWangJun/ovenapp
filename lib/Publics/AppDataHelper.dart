//多线程 isolate 数据处理
import 'dart:isolate';

import 'package:ovenapp/Models/HttpRetModel.dart';
import 'package:ovenapp/Publics/GlobalVar.dart';
import 'package:ovenapp/Services/HttpCallerSrv.dart';

class AppDataHelper {
  static HttpRetModel httpRetModel;
  static int n = 12;
  static Future<dynamic> dataQuerier (
      String action, Map<String, dynamic> param, List<dynamic> lstObj) async {
    //首先创建一个ReceivePort，为什么要创建这个？
    //因为创建isolate所需的参数，必须要有SendPort，SendPort需要ReceivePort来创建
    final response = ReceivePort();
    //开始创建isolate,Isolate.spawn函数是isolate.dart里的代码,_isolate是我们自己实现的函数
    //_isolate是创建isolate必须要的参数。
    await Isolate.spawn(_isolate, response.sendPort);
    //获取sendPort来发送数据
    final sendPort = await response.first as SendPort;
    //接收消息的ReceivePort
    final answer = ReceivePort();
    //发送数据
    sendPort.send([answer.sendPort, action, param, lstObj]);
    //获得数据并返回
     print('@@@ AppDataHelper.dataQuerier() ${DateTime.now()}');
    return answer.first;
  }

//创建isolate必须要的参数
  static _isolate(SendPort initialReplyTo) {
    final port = ReceivePort();
    //绑定
    initialReplyTo.send(port.sendPort);
    //监听
    port.listen((param) {
      //获取数据并解析
      final send = param[0] as SendPort;
      final action = param[1] as String;
      final mpParam = param[2] as Map<String, dynamic>;
      final lstObj = param[3] as List<dynamic>;
      // final data = message[0] as int;
      //返回结果
      send.send(_getData(action, mpParam, lstObj));
    });
  }

  static _getData(
      String action, Map<String, dynamic> param, List<dynamic> lstObj) {
        print('@@@ AppDataHelper._getData() Begin : ${DateTime.now()}');

        return HttpRetModel.getAnalyizeErrObj('高档多线程~~~');
//     httpRetModel = null;
//     HttpCallerSrv.getData(action, param,
//             GlobalVar.userInfo == null ? '' : GlobalVar.userInfo.tk)
//         .then((f) {
//       // print('@@@ DataHelpr.selectData($action,$param) then --> f : $f');
// print('@@@ AppDataHelper._getData() End : ${DateTime.now()}');
//       if (f == null) {
//         print('@@@ AppDataHelper._getData() f is null');
//         // if (callback != null) callback(HttpRetModel.getEmptyObj('返回数据为空！'));
//         httpRetModel = HttpRetModel.getEmptyObj('返回数据为空！');
//         return httpRetModel;
//       }

//       String jsonData = f
//           .toString()
//           .replaceAll('\r\n', '')
//           .replaceAll('\r', '')
//           .replaceAll('\n', '');
//       // print('@@@ DataHelpr.selectData() jsonData : $jsonData');
//       try {
//         // Map<String, dynamic> ret = json.decode(jsonData);
//         // HttpRetModel retmodel = HttpRetModel.fromJson(ret, objModel);
//         // HttpRetModel retmodel = HttpRetModel.fromJsonStr(jsonData, lstObj);
//         httpRetModel = HttpRetModel.fromJsonStr(jsonData, lstObj);
//         print('@@@ AppDataHelper._getData() %%%%%%%%%%%%%%%%%%%%% httpRetModel.ret : ${httpRetModel.ret} , ${httpRetModel.data.length}');
//         print('@@@ AppDataHelper._getData() Ret End : ${DateTime.now()}');
//         return httpRetModel;
//         // if (retmodel.ret == 0 && spfile != '')
//         //   SharePrefHelper.saveData(spfile, jsonData);


//         // if (callback != null) callback(retmodel);
//       } catch (e) {
//         print(
//             '*** AppDataHelper._getData() action : $action , param : $param / decode err --> e : $e');
//         httpRetModel = HttpRetModel.getAnalyizeErrObj(e);
//         return httpRetModel;
//         // callback(HttpRetModel.getAnalyizeErrObj(e));
//       }
//     }).catchError((e) {
//       print(
//           '*** AppDataHelper._getData() action : $action ,param : $param / catchError --> e : $e');
//       // if (callback != null) callback(HttpRetModel.getErrObj(e));
//       httpRetModel = HttpRetModel.getErrObj(e);
//       return httpRetModel;
//     });
// print('@@@ AppDataHelper._getData() Finished : ${DateTime.now()}');
    // return httpRetModel;
  }
}
