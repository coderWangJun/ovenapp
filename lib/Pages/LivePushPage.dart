import 'package:flutter/material.dart';
// import 'package:flutter_rtmp_publisher/flutter_rtmp_publisher.dart';

class LivePushPage extends StatefulWidget {
  @override
  _LivePushPageState createState() => _LivePushPageState();
}

class _LivePushPageState extends State<LivePushPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter RTMP Demo'),
      ),
      body: Container(
        child: RaisedButton(
          child: Text("Start Stream"),
          onPressed: () {
            // RTMPPublisher.streamVideo("rtmp://91150.livepush.myqcloud.com/live/livebake?txSecret=2dd4ac7980521d42dcb908dc2575b640&txTime=5EB824FF ");
          },
        ),
      ),
    );
  }
}