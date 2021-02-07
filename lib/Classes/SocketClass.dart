import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'dart:typed_data';

// import 'package:ovenapp/Publics/GlobalVar.dart';
// import 'package:ovenapp/Services/EventBusSrv.dart';

class SocketClass {
  String host = '10.10.10.1';
  int port = 4567;
  Socket socket;
  Stream<List<int>> mStream;
  static int socketConnected = 0; //连接AP Socket 是否成功OK ，0没有，1成功
  static int sendRet = 0; //AP返回数据是否OK ，0不是，1是
  // var clientCallback;
// var callback
  initSocket() async {
    // clientCallback = callback;
    await Socket.connect(host, port).then((Socket s) {
      socket = s;
      mStream = socket.asBroadcastStream(); //多次订阅的流 如果直接用socket.listen只能订阅一次
      print('@@@ Socket.connect OK !');
      socket.listen(decodeHandle,
          onError: errorHandler, onDone: doneHandler, cancelOnError: false);
      socketConnected = 1;
      // clientCallback('connect', 'OK');
    }).catchError((e) {
      print('*** SocketClass.initSocket() Socket.connect catchError e:$e');
      // clientCallback('connect', e);
      // initSocket();
    });
  }

  void addParams(List<int> params) {
    socket.add(params);
  }

  void dispos() {
    socket.close();
  }

  sendData(String param) async {
    //建立连接
    // var socket = await Socket.connect(host, port);
    print("@@@ SocketClass.sendData() param : $param , socket : $socket");
    if (socket == null) {
      print("@@@ SocketClass.sendData() socket is null !");
      return;
    }
    // socket.listen(decodeHandle);
    //根据http协议，发送请求头
    try {
      socket.writeln(param);
      await socket.flush();

      // Timer(Duration(seconds: 1), () async {
      //   socket.writeln(param);
      //   await socket.flush();
      // });
      socket.writeln(param);
      await socket.flush();
    } catch (e) {
      print("*** SocketClass.sendData() e : $e");
    }
    // .then((f) {
    //   print('@@@ SocketClass.sendData() then f : $f');
    //   // clientCallback('send','OK');
    // }).catchError((e) {
    //   print('@@@ SocketClass.sendData() catchError e : $e');
    //   // clientCallback('send',e);
    // }); //发送
    //读取返回内容
    // utf8.decode();
    // _response =await socket.transform().join();
    // await socket.close();
    // print('@@@ sendData Finished ! ' + param);
  }

/*
   * 解码处理方法
   * 处理服务器发过来的数据，注意，这里要处理粘包，这个data参数不一定是一个完整的包
   */
/* 消息长度用2个字节描述 */
  int msgByteLen = 2;

/* 消息号用2个字节描述 */
  int msgCodeByteLen = 2;

/* 最小的消息长度为4个字节（即消息长度+消息号） */
  int minMsgByteLen = 1; //msgByteLen + msgCodeByteLen;

  Int8List cacheData = Int8List(0);
  void decodeHandle(newData) {
    var rawData = utf8.decode(newData);
    print('@@@ rawData : $rawData');
    // clientCallback('listen', 'OK');
    if (rawData != null && rawData.indexOf('OK') > -1) //.startsWith('OK')
      sendRet = 1; //_initValue();
    // var byteData = newData.buffer.asByteData();
    // var msgLen = byteData.getInt16(0);
    // print('@@@ newData : $newData');
    // print('@@@ msgLen : $msgLen');
    // //拼凑当前最新未处理的网络数据
    // cacheData = Int8List.fromList(cacheData + newData);

    // print('@@@ cacheData : $cacheData');
  }

  void errorHandler(error, StackTrace trace) {
    print("捕获socket异常信息：error=$error，trace=${trace.toString()}");
    // clientCallback('listen', error);
    socket.close();
  }

  void doneHandler() {
    // _initValue();
    socket.destroy();
    print("socket关闭处理");
  }

  // _initValue() {
  //   GlobalVar.isAPConnected = false;
  //   eventBus.fire(DialogCloseEvent());
  // }
//   static Future<String> getNetworkData(ipAddr,port) async {
//   Socket s = await Socket.connect(ipAddr, port);
//   s.add(utf8.encode(request));
//   String result = await s.transform(utf8.decoder).join();
//   await s.close(); // probably need to close the socket
//   return result;
// }

// static Future<String> getSocketData(ipAddr, port) async {
//   String rawData;
//   await Socket.connect(ipAddr, port).then((Socket socket) {
//     socket.add(utf8.encode(request));
//     socket.listen((var data) {
//       rawData = utf8.decode(data);
//     });

//   return rawData;
// }
}
