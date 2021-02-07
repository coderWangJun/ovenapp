import 'dart:io';
import 'dart:async';
// import 'dart:convert';

import 'dart:typed_data';

class SocketManage {
  static String host = '10.10.10.1';
  static int port = 4567;
  static Socket mSocket;
  static Stream<List<int>> mStream;

  static initSocket() async {
    await Socket.connect(host, port).then((Socket socket) {
      mSocket = socket;
      mStream = mSocket.asBroadcastStream(); //多次订阅的流 如果直接用socket.listen只能订阅一次
      print('@@@ Socket.connect OK !');
    }).catchError((e) {
      print('connectException:$e');
      initSocket();
    });
  }

  static void addParams(List<int> params) {
    mSocket.add(params);
  }

  static void dispos() {
    mSocket.close();
  }

  static sendData(String param) async {
    //建立连接
    var socket = await Socket.connect(host, port);

    socket.listen(decodeHandle);
    //根据http协议，发送请求头
    socket.writeln(param);
    await socket.flush(); //发送
    //读取返回内容
    // utf8.decode();
    // _response =await socket.transform().join();
    await socket.close();
    print('@@@ sendData Finished ! ' + param);
  }

/*
   * 解码处理方法
   * 处理服务器发过来的数据，注意，这里要处理粘包，这个data参数不一定是一个完整的包
   */
/* 消息长度用2个字节描述 */
  static int msgByteLen = 2;

/* 消息号用2个字节描述 */
  static int msgCodeByteLen = 2;

/* 最小的消息长度为4个字节（即消息长度+消息号） */
  static int minMsgByteLen = msgByteLen + msgCodeByteLen;

  static Int8List cacheData = Int8List(0);
  static void decodeHandle(newData) {
    //拼凑当前最新未处理的网络数据
    cacheData = Int8List.fromList(cacheData + newData);
    print('@@@ SocketManage.decodeHandle() cacheData : $cacheData');

    //缓存数据长度符合最小包长度才尝试解码
    while (cacheData.length >= minMsgByteLen) {
      //读取消息长度
      var byteData = cacheData.buffer.asByteData();
      var msgLen = byteData.getInt16(0);

      //数据长度小于消息长度，说明不是完整的数据，暂不处理
      if (cacheData.length < msgLen + msgByteLen) {
        return;
      }
      //读取消息号
      int msgCode = byteData.getInt16(msgCodeByteLen);
      //读取pb数据
      int pbLen = msgLen - msgCodeByteLen;
      Int8List pbBody;
      if (pbLen > 0) {
        pbBody = cacheData.sublist(minMsgByteLen, msgLen + msgByteLen);
      }

      //整理缓存数据
      int totalLen = msgByteLen + msgLen;
      cacheData = cacheData.sublist(totalLen, cacheData.length);

      // Function handler = msgHandlerPool[msgCode];
      // if(handler == null){
      //   print("没有找到消息号$msgCode的处理器");
      //   return;
      // }

      // //处理消息
      // handler(pbBody);
    }

    //   void errorHandler(error, StackTrace trace){
    //   print("捕获socket异常信息：error=$error，trace=${trace.toString()}");
    //   socket.close();
    // }

    // void doneHandler(){
    //   socket.destroy();
    //   print("socket关闭处理");
    // }
  }
  // static sendData(String param) async {
  //   //建立连接
  //   var socket = await Socket.connect(host, port);
  //   //根据http协议，发送请求头
  //   socket.writeln(param);
  //   await socket.flush(); //发送
  //   //读取返回内容
  //   // utf8.decode();
  //   // _response =await socket.transform().join();
  //   await socket.close();
  //   print('@@@ sendData Finished ! '+param);
  // }

  // static sendData(String param) {
  //   //建立连接
  //   var socket = Socket.connect(host, port);
  //   socket.writeln(param);
  //   socket.flush(); //发送
  //   //读取返回内容
  //   // _response =await socket.transform(utf8.decoder).join();
  //   socket.close();
  // }
}
