import 'dart:async';
import 'dart:io';
import 'package:mqtt_client/mqtt_client.dart';

///服务器地址是 test.mosquitto.org ， 端口默认是1883
///自定义端口可以调用 MqttClient.withPort(服务器地址, 身份标识, 端口号);
// final MqttClient client = MqttClient('www.cfdzkj.com', "13237199233");
final MqttClient client =
    MqttClient.withPort('www.cfdzkj.com', "13237199233", 1888);

class MqttHelper {
  Future<int> createMqtt() async {
    client.logging(on: false);

    ///是否开启日志
    client.keepAlivePeriod = 20;

    ///设置超时时间
    client.onDisconnected = onDisconnected; //设置断开连接的回调
    client.onConnected = onConnected; //设置连接成功的回调
    client.onSubscribed = onSubscribed; //订阅的回调
    client.pongCallback = pong; //ping的回调
    try {
      await client.connect("010001","1");

      ///开始连接
    } on Exception catch (e) {
      print('EXAMPLE::client exception - $e');
      client.disconnect();
    }

    ///检查连接结果
    if (client.connectionStatus.state == MqttConnectionState.connected) {
      print('EXAMPLE::Mosquitto client connected');
    } else {
      print(
          'EXAMPLE::ERROR Mosquitto client connection failed - disconnecting, status is ${client.connectionStatus}');
      client.disconnect();
      exit(-1);
    }

    ///订阅一个topic: 服务端定义的事件   当服务器发送了这个消息，就会在 client.updates.listen 中收到
    const String topic = '/05D8FF333136595043187610';
    client.subscribe(topic, MqttQos.atMostOnce);

    ///监听服务器发来的信息
    client.updates.listen((List<MqttReceivedMessage<MqttMessage>> c) {
      final MqttPublishMessage recMess = c[0].payload;

      ///服务器返回的数据信息
      final String pt =
          MqttPublishPayload.bytesToStringAsString(recMess.payload.message);
      print(
          'EXAMPLE::Change notification:: topic is <${c[0].topic}>, payload is <-- $pt -->');
    });

    ///设置public监听，当我们调用 publishMessage 时，会告诉你是都发布成功
    client.published.listen((MqttPublishMessage message) {
      print(
          'EXAMPLE::Published notification:: topic is ${message.variableHeader.topicName}, with Qos ${message.header.qos}');
    });

    ///发送消息给服务器的示例
    const String pubTopic = '/oven/pc/4DBA867919434986A626C9BFC5F100DF';
    final MqttClientPayloadBuilder builder = MqttClientPayloadBuilder();
    builder.addString('Hello from mqtt_client');

    ///这里传 请求信息的json字符串
    client.publishMessage(pubTopic, MqttQos.exactlyOnce, builder.payload);

    ///解除订阅
    client.unsubscribe(topic);

    ///断开连接
    client.disconnect();
    return 0;
  }

  void onSubscribed(String topic) {
    print('EXAMPLE::Subscription confirmed for topic $topic');
  }

  void onDisconnected() {
    print('EXAMPLE::OnDisconnected client callback - Client disconnection');
    if (client.connectionStatus.returnCode == MqttConnectReturnCode.solicited) {
      print('EXAMPLE::OnDisconnected callback is solicited, this is correct');
    }
    exit(-1);
  }

  void onConnected() {
    print(
        'EXAMPLE::OnConnected client callback - Client connection was sucessful');
  }

  void pong() {
    print('EXAMPLE::Ping response client callback invoked');
  }
}
