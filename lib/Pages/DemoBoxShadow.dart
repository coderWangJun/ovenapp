import 'package:flutter/material.dart';
import 'package:ovenapp/Models/DeviceModel.dart';
import 'package:ovenapp/Publics/AppStyle.dart';

class DemoBoxShadow extends StatefulWidget {
  DemoBoxShadow({Key key, this.deviceModel}) : super(key: key);
  final DeviceModel deviceModel;
  // final List<dynamic> lstControlPanel; this.lstControlPanel,
  @override
  _DemoBoxShadowState createState() => _DemoBoxShadowState();
}

class _DemoBoxShadowState extends State<DemoBoxShadow> {
  @override
  void initState() {
    super.initState();
    // _lstData = [];
    _getData();
    // fData =_getList();// Future.value(_lstData);
    print(
        "@@@ => PowerListPage.initState() ... deviceModel.id : ${widget.deviceModel.id}");
  }

  @override
  void dispose() {
    super.dispose();
    // _streamController.close();
    print("@@@ PowerListPage.dispose() ...");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: AppStyle.mainBackgroundColor,
        title: Text('耗电量报表'),
        // actions: _getActions(),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
             Stack(
              children: <Widget>[
                Container(
                  color: Colors.indigoAccent,
                  width: 60.0,
                  height: 60.0,
                  child: CircularProgressIndicator(
                    value: 0.5,
                    backgroundColor: Colors.grey[200],
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                    // semanticsLabel: '90%',
                    // semanticsValue: '5',
                  ),
                ),
                Container(
                  color: Colors.lime,
                  // alignment: Alignment.center,
                  child: 
                Text('90%'),),
              ],
            ),
            SizedBox(
              height: 30.0,
            ),
            Card(
              elevation: 3.0,
              shape: RoundedRectangleBorder(
                // side: BorderSide(
                //   color: Colors.redAccent,
                //   style: BorderStyle.solid
                //   // width: 5.0,
                // ),
                borderRadius:
                    BorderRadius.all(Radius.circular(10.0)), //设定 Card 的倒角大小
                // borderRadius: BorderRadius.only(
                //   //设定 Card 的每个角的倒角大小
                //   topLeft: Radius.zero, //Radius.circular(20.0),
                //   topRight: Radius.zero,
                //   bottomLeft: Radius.zero, //Radius.circular(10.0),
                //   bottomRight: Radius.zero, //Radius.circular(10.0),
                // ),
              ),
              child: Container(
                height: 80.0,
                width: 220.0,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20.0),
              height: 120.0,
              width: 220.0,
              decoration: BoxDecoration(
                // border: Border.all(color: Color(0xFFFF0000), width: 0.5), // 边色与边宽度
                color: Colors.white, // Color(0xFF9E9E9E), // 底色
                borderRadius: BorderRadius.circular(10.0), // 圆角度
                //  shape: BoxShape.circle,
                // borderRadius: new BorderRadius.vertical(
                //     top: Radius.elliptical(20, 50)), // 也可控件一边圆角大小
                boxShadow: [
                  BoxShadow(
                      color: AppStyle.mainColor, // Color(0x99FFFF00),
                      offset: Offset(0.5, 0.5),
                      blurRadius: 12.0,
                      spreadRadius: 5.0),
                  // BoxShadow(
                  //   color: Colors.orange,
                  //   offset: Offset(5.0, 5.0),
                  // ),
                  // BoxShadow(
                  //   color: Color(0xFF0000FF),
                  //    offset: Offset(5.0, 5.0),
                  // ),
                ],
                // gradient: RadialGradient(colors: [Color(0xFFFFFF00), Color(0xFF00FF00), Color(0xFF00FFFF)],radius: 1, tileMode: TileMode.mirror),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 40.0),
              height: 80.0,
              width: 220.0,
              decoration: BoxDecoration(
                // border: Border.all(color: Color(0xFFFF0000), width: 0.5), // 边色与边宽度
                color: Colors.white, // Color(0xFF9E9E9E), // 底色
                borderRadius: BorderRadius.circular(10.0), // 圆角度
                //  shape: BoxShape.circle,
                // borderRadius: new BorderRadius.vertical(
                //     top: Radius.elliptical(20, 50)), // 也可控件一边圆角大小
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey[400], // Color(0x99FFFF00),
                      offset: Offset(0.4, 0.8),
                      blurRadius: 2.3,
                      spreadRadius: 0.5,),
                  // BoxShadow(
                  //   color: Colors.orange,
                  //   offset: Offset(5.0, 5.0),
                  // ),
                  // BoxShadow(
                  //   color: Color(0xFF0000FF),
                  //    offset: Offset(5.0, 5.0),
                  // ),
                ],
                // gradient: RadialGradient(colors: [Color(0xFFFFFF00), Color(0xFF00FF00), Color(0xFF00FFFF)],radius: 1, tileMode: TileMode.mirror),
              ),
            ),
          ],
        ),
      ),
      // Refresh(
      //   onFooterRefresh: onFooterRefresh,
      //   onHeaderRefresh: onHeaderRefresh,
      //   child: _getBodyUI(),
      //   //ListView.builder(itemCount: _list.length, itemBuilder: _itemBuilder),
      // ), //_getRefreshUI(), //_getTemplateListFB(),
    );
  }

  _getData() {
    //
  }
}
