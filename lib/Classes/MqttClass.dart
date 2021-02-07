import 'dart:async';
import 'dart:convert';

import 'package:mqtt_client/mqtt_client.dart';
// import 'package:ovenapp/Models/ControlPanelModel.dart';
import 'package:ovenapp/Models/MqttDataModel.dart';
import 'package:ovenapp/Models/WifiModel.dart';
import 'package:ovenapp/Publics/GlobalVar.dart';
import 'package:typed_data/typed_buffers.dart';

import '../Services/EventBusSrv.dart';

class MqttClass {
  // static MqttClass mqttClass;
  // static initMqttSrv() {
  //    print("@@@ => GlobalVar.initMqttSrv() ...");
  //   mqttClass = new MqttClass();
  //   mqttClass.connect();
  //   // mqttClass.subscribe("/oven/app/13237199233");
  // }
  // static List<MqttClient> lstMqttClient=new List<MqttClient>();
  String loginid = "13237199233";
  String username = "010001";
  String password = "1";
  String server = "www.cfdzkj.com";
  int port = 1888;

  static StringBuffer sbLog = new StringBuffer();
// enum MqttConnectionState {
//   /// The MQTT Connection is in the process of disconnecting from the broker.
//   disconnecting,

//   /// MQTT Connection is not currently connected to any broker.
//   disconnected,

//   /// The MQTT Connection is in the process of connecting to the broker.
//   connecting,

//   /// The MQTT Connection is currently connected to the broker.
//   connected,

//   /// The MQTT Connection is faulted and no longer communicating
//   /// with the broker.
//   faulted
// }
  String mqttClientState = "disconnected";
  Timer tmReConnect;
  // Timer tmSubscribe;
  Map<String, int> mapControlPanel = {};
  // String server = 服务器地址;
  // int port=端口号;  subTopic + "/" + clientIdentifier
  // String clientIdentifier = "13237199233"; //客户端标识;
  String subTopic = "oven/app"; //所有app端都需要订阅的topic;
  // String publishTopic = ""; //发送消息的topic;
  MqttQos qos = MqttQos.atLeastOnce;
  MqttClient mqttClient;
  // MqttClass _instance;String uid

  MqttClass() {
    // clientIdentifier = loginid;
    mapControlPanel[subTopic] = 0;
    // mapControlPanel[subTopic + "/" + GlobalVar.userInfo.loginid] = 0;

    mqttClient = MqttClient.withPort(server, GlobalVar.userInfo.loginid, port);

    ///连接成功回调
    mqttClient.onConnected = _onConnected;

    ///连接断开回调
    mqttClient.onDisconnected = _onDisconnected;

    ///订阅成功回调
    mqttClient.onSubscribed = _onSubscribed;

//取消订阅回调
    mqttClient.onUnsubscribed = _onUnsubscribed;

    ///订阅失败回调
    mqttClient.onSubscribeFail = _onSubscribeFail;

    // mqttClient.pongCallback = _pong;

    // mqttClient.published.listen(_onPublished);
    //  print("@@@ => mqttClient.connect()");
    // mqttClient.connect(username,password);
    // _log("connecting");
  }
  // MqttClass getInstance(String uid) {
  //   clientIdentifier=uid;
  //   // subTopic = sb;
  //   if (_instance == null) {
  //     _instance = MqttClass._();
  //   }
  //   return _instance;
  // }

  ///连接
  connect() {
    // print(
    //     "MQTT--> mqttClient.connect() GlobalVar.isAPConnected : ${GlobalVar.isAPConnected} , GlobalVar.userInfo : ${GlobalVar.userInfo}");
    if (GlobalVar.userInfo == null || GlobalVar.isAPConnected) return;

    try {
      mqttClient.connect(username, password);
    } catch (e) {
      print("*** MQTT--> MqttClass.connect() error : " + e.toString());
    }
    // openConnectTimer(8);
    // _log("connecting");
  }

  ///断开连接
  disconnect() {
    mqttClient.disconnect();
    // _log("@@@ MqttClass.disconnect()");
  }

  ///订阅主题
  subscribe(String topic) {
    if (mqttClientState == "connected") mqttClient.subscribe(topic, qos);
    // _log("@@@ MqttClass.subscribe $topic");
  }

  ///发布消息
  publishMessage(String topic, String msg) {
    if (mqttClient == null || mqttClientState != 'connected') {
      // print(
      //     "*** MQTT--> MqttClass.publishMessage() mqttClientState error => topic : $topic , msg : $msg");
      return;
    }

    ///int数组
    Uint8Buffer uint8buffer = Uint8Buffer();

    ///字符串转成int数组 (dart中没有byte) 类似于java的String.getBytes?
    var codeUnits = msg.codeUnits;
    //uint8buffer.add()
    uint8buffer.addAll(codeUnits);
    mqttClient.publishMessage(topic, qos, uint8buffer);
  }

  ///消息监听
  // _onData(List<MqttReceivedMessage<MqttMessage>> data) {
  //   Uint8Buffer uint8buffer = Uint8Buffer();
  //   var messageStream = MqttByteBuffer(uint8buffer);
  //   data.forEach((MqttReceivedMessage<MqttMessage> m) {
  //     ///将数据写入到messageStream数组中
  //     m.payload.writeTo(messageStream);

  //     ///打印出来
  //     print(uint8buffer.toString());
  //   });
  // }

  _onDataReceived(List<MqttReceivedMessage<MqttMessage>> data) {
    final MqttPublishMessage recMess = data[0].payload;

    ///服务器返回的数据信息
    int isok = 1;
    MqttDataModel mm;
    final String pm =
        MqttPublishPayload.bytesToStringAsString(recMess.payload.message);
    try {
      // print('topic : <${data[0].topic}>, payload : $pm');
      Map<String, dynamic> ms = json.decode(pm);
      mm = MqttDataModel.fromJson(ms);
      mm.uuid = data[0].topic;
      if (mm.uuid == '/05DAFF333136595043187617') {
        if (GlobalVar.isPrintMqttData == 1)
          print('${DateTime.now()} : ${mm.toJsonStr()}');
      }
      // if (GlobalVar.isPrintMqttData == 1)
      //   print('${DateTime.now()} : ${mm.toJsonStr()}');
    } catch (e) {
      isok = 0;
      mm = null;
      print(
          '*** MqttClass._onDataReceived message:$pm , error : ${e.toString()}');
    }

    if (isok == 1 && mm != null) {
      //5 getWifi返回
      if (mm.state == 5 || mm.state == 6) {
        // print('@@@ MqttClass._onDataReceived wifi data : $pm');
        if (mm.state == 5) {
          WifiModel wm = WifiModel(
              uuid: mm.uuid,
              ssid: mm.ssid,
              server: mm.server,
              port: int.parse(mm.port),
              password: mm.password,
              uptime: int.parse(mm.uptime));
          eventBus.fire(WifiInfoEvent(wm));
        }
        return;
      }

      if (mm.state == -1) {
        print(
            '@@@ MqttClass._onDataReceived mm.state : ${mm.toJsonStr()} / ${DateTime.now()}');
      }

      {
        eventBus.fire(MqttPayloadEvent(mm));
      }
    }
  }

  _onConnected() {
    // _log("onConnected");
    // print("@@@ MqttClass._onConnected datetime => ${DateTime.now()}");
    // print("@@@ MqttClass._onConnected mapControlPanel => $mapControlPanel");

    if (tmReConnect != null) {
      tmReConnect.cancel();
      tmReConnect = null;
    }

    mqttClient.updates.listen(_onDataReceived);
    mqttClientState = "connected";

    //连接成功的时候重新订阅消息
    openSubscribeTimer();
    // mqttClient.updates.listen(_onData);
  }

  _onDisconnected() {
    mqttClientState = "disconnected";
    // _log("_onDisconnect");

    //连接断开的时候将所有要订阅的消息状态变为0
    mapControlPanel.forEach((k, v) {
      mapControlPanel[k] = 0;
    });

    //隔5秒后再连
    openConnectTimer(5);
    // mqttClient.onDisconnected();
  }

  openConnectTimer(int sec) {
    // print(
    //     "MQTT--> mqttClient.openConnectTimer($sec) mapControlPanel : $mapControlPanel , GlobalVar.isAPConnected : ${GlobalVar.isAPConnected} , GlobalVar.userInfo : ${GlobalVar.userInfo}");

    // if (tmReConnect == null) {
    tmReConnect = Timer.periodic(Duration(seconds: 5), (timer) {
      // if (GlobalVar.userInfo == null) return;
      if (GlobalVar.userInfo == null || GlobalVar.isAPConnected) return;

      if (mqttClient == null) {
        GlobalVar.initMqttSrv();
        return;
      }

      if (mqttClientState != "connected") {
        String log = "MqttClientState : " +
            mqttClientState +
            " / mqttClient.connect() ... / " +
            DateTime.now().toString();

        // print("MQTT-->$log");
        sbLog.writeln(log);
        connect();
      }

      // if (mqttClientState == "connected") {
      //   tmReConnect.cancel();
      //   tmReConnect = null;
      // }
    });
    // }
  }

  openSubscribeTimer([int sec = 3]) {
    // print(
    //     "MQTT--> mqttClient.openSubscribeTimer($sec) mapControlPanel : $mapControlPanel");

    // if (tmSubscribe == null) {
    Timer.periodic(Duration(seconds: sec), (timer) {
      if (mqttClient == null ||
          mqttClientState != "connected" ||
          GlobalVar.isAPConnected) return;
      // print(
      //     'openSubscribeTimer begin : ${GlobalVar.mqttClass.mapControlPanel}');
      // if (mqttClientState == "connected" && mapControlPanel.length > 0) {
      try {
        GlobalVar.lstControlPanel.forEach((k, v) {
          if (!mapControlPanel.containsKey(k))
            mapControlPanel[k] = 0; //GlobalVar.addSubscribe(k);
        });

        List<String> _lstDelete = [];

        mapControlPanel.forEach((k, v) {
          if (!k.startsWith('oven') &&
              !GlobalVar.lstControlPanel.containsKey(k)) {
            _lstDelete.add(k);
            mqttClient.unsubscribe('/' + k);
            // print('MQTT --> openSubscribeTimer() *unsubscribe : $k');
          } else {
            if (v == 0) {
              mqttClient.subscribe('/' + k, qos);
              // print('MQTT --> openSubscribeTimer() subscribe : $k');
              // mapControlPanel[k] = 1;
            }
          }
        });

        if (_lstDelete.length > 0) {
          _lstDelete.forEach((key) {
            mapControlPanel.remove(key);
          });
        }

        // print(
        //     'openSubscribeTimer end : ${GlobalVar.mqttClass.mapControlPanel}');
      } catch (e) {
        print('*** MQTT --> openSubscribeTimer() e : $e');
        timer.cancel();
        timer = null;
        openSubscribeTimer();
        return;
      }

      timer.cancel();
      timer = null;
      // }
    });
    // }

//原来的逻辑
    // if (tmSubscribe == null) {
    //   tmSubscribe = Timer.periodic(Duration(seconds: sec), (timer) {
    //     if (mqttClientState == "connected" && mapControlPanel.length > 0) {
    //       mapControlPanel.forEach((k, v) {
    //         if (v == 0) {
    //           mqttClient.subscribe(k, qos);
    //           String log = "MqttClientState : " +
    //               mqttClientState +
    //               " / mqttClient.subscribe($k-$v) ... / " +
    //               DateTime.now().toString();
    //           // print("MQTT-->$log");
    //           sbLog.writeln(log);
    //           mapControlPanel[k] = 1;
    //         }
    //       });

    //       tmSubscribe.cancel();
    //       tmSubscribe = null;
    //     }
    //   });
    // }
  }

  _onSubscribed(String topic) {
    String uuid = topic.substring(1);
    if (mapControlPanel != null &&
        mapControlPanel.containsKey(uuid) &&
        mapControlPanel[uuid] == 0) mapControlPanel[uuid] = 1;
    // _log("_onSubscribed");

    // print('MQTT--> _onSubscribed() topic : $topic ${DateTime.now()}');

    ///在订阅成功的时候注册消息监听
    // mqttClient.updates.listen(_onData);
  }

  _onUnsubscribed(String topic) {
    // String uuid=topic.substring(1);
    // if (mapControlPanel != null &&
    //     mapControlPanel.containsKey(uuid))
    //     mapControlPanel.remove(uuid);
    // print(
    //     'MQTT--> _onUnsubscribed() topic : ${topic ?? "0"} ${DateTime.now()}');
  }

  _onSubscribeFail(String topic) {
    _log("_onSubscribeFail");
  }

  addSubscribe(topic) {
    if (!mapControlPanel.containsKey(topic)) {
      mapControlPanel[topic] = 0;
      // openSubscribeTimer();
    }
  }

  clearSubscribe() {
    if (mapControlPanel != null && mapControlPanel.length > 0) {
      mapControlPanel.forEach((k, v) {
        if (k != 'oven/app') {
          mqttClient.unsubscribe('/' + k);
        }
      });
      mapControlPanel.clear();
    }
  }

  _log(String msg) {
    print("### MQTT--> $msg");
  }

  // static MqttClient createMqttClient(String clientIdentifier, String subTopic) {
  //   MqttClient mc = MqttClient.withPort(_ip, clientIdentifier, _port);
  //   mc.connect().then(
  //     mc.subscribe(subTopic, qosLevel);
  //   );

  //   // ///连接成功回调
  //   // mc.onConnected = _onConnected;

  //   // ///连接断开回调
  //   // mc.onDisconnected = _onDisconnected();

  //   // ///订阅成功回调
  //   // mc.onSubscribed = _onSubscribed;

  //   // ///订阅失败回调
  //   // mc.onSubscribeFail = _onSubscribeFail;

  //   return mc;
  // }

  void _pong() {
    //  print("MQTT-->_pong");
    // print('MQTT --> Ping response client callback invoked');
  }

  void _onPublished(MqttPublishMessage message) {
    print(
        'EXAMPLE::Published notification:: topic is ${message.variableHeader.topicName}, with Qos ${message.header.qos}');
  }

  close() {
    if (mqttClient != null) {
      tmReConnect.cancel();
      tmReConnect = null;
    }
    if (mqttClient != null) mqttClient.disconnect();
  }
}
