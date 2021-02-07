import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:ovenapp/Publics/AppStyle.dart';

// import 'GlobalVar.dart';

class MyControl {
  Widget noContantWidget() {
    return Center(
      child: Column(
        children: <Widget>[
          new Padding(
            padding: new EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 5.0),
            child: new Center(
              child: Icon(
                Icons.block, //.not_interested,
                color: Colors.grey[400],
                size: 40.0,
              ),
              // child: Image.asset('images/ic_msg_press.png', width: 120.0, height: 120.0, ),
            ),
          ),
          new Padding(
            padding: new EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 0.0),
            child: new Center(
              child: new Text(
                '数据为空 ~~~ ！',
                style: new TextStyle(fontSize: 16.0, color: Colors.grey[500]),
              ),
            ),
          ),
        ],
      ),
    );
  }

  static waitingWidget() {
    return Container(
      height: double.infinity,
      width: double.infinity,
      alignment: Alignment.center,
      child:Container(
        height: 120.0,
        width: 120.0,
        margin: EdgeInsets.only(bottom: 40.0),
      child: Column(
        children: <Widget>[
          // new Container(
          //   height: 35.0,  SpinKitHourGlass SpinKitThreeBounce
          // ),
          new Padding(
            padding: new EdgeInsets.fromLTRB(0.0, 35.0, 0.0, 3.0),
            child: new Center(
              child: SpinKitHourGlass(
                color: AppStyle.mainColor,
                size: 35.0,
              ),
            ),
          ),
          new Padding(
            padding: new EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
            child: new Center(
              child: new Text(
                '正在加载数据 ...',
                style: new TextStyle(fontSize: 16.0, color: Colors.grey[500]),
              ),
            ),
          ),
        ],
      ),),
    );
  }

  Widget overtimeWidget() {
    return new Column(
      children: <Widget>[
        new Padding(
          padding: new EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 5.0),
          child: new Center(
            child: Icon(
              Icons.alarm_off, //.not_interested,
              color: Colors.grey[600],
              size: 40.0,
            ),
            // child: Image.asset('images/ic_msg_press.png', width: 120.0, height: 120.0, ),
          ),
        ),
        new Padding(
          padding: new EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 0.0),
          child: new Center(
            child: new Text(
              '获取数据超时 ~~~ ！',
              style: new TextStyle(fontSize: 16.0, color: Colors.grey[500]),
            ),
          ),
        ),
      ],
    );
  }
}