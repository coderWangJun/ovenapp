import 'package:flutter/material.dart';
import 'dart:convert';
// import 'package:ovenapp/Classes/MqttHelper.dart';
// import '../Classes/MqttClass.dart';
// import '../Classes/MqttHelper.dart';

import 'package:ovenapp/Services/HttpCallerSrv.dart';
import 'package:ovenapp/Publics/GlobalVar.dart';
import 'package:ovenapp/Models/NewsModel.dart';
import 'package:ovenapp/Models/HttpRetModel.dart';

class MaintainPage extends StatefulWidget {
  @override
  _MaintainPageState createState() => new _MaintainPageState();
}

class _MaintainPageState extends State<MaintainPage> {
  List<DropdownMenuItem<String>> sortItems = [];
  String _selectedSort = '排序';
  GlobalKey _key = GlobalKey();
  GlobalKey _key1 = GlobalKey();

  Color bgColor = Colors.white;
  GlobalKey anchorKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    print("@@@ => MaintainPage.initState() ... ");

    sortItems.add(DropdownMenuItem(value: '排序', child: Text('排序')));
    sortItems.add(DropdownMenuItem(value: '价格降序', child: Text('价格降序')));
    sortItems.add(DropdownMenuItem(value: '价格升序', child: Text('价格升序')));
  }

  @override
  void dispose() {
    super.dispose();

    print("@@@ MaintainPage.dispose() ...");
  }

// class MyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("@@@ => MaintainPage.build() ... ");
    return new Scaffold(
        // appBar: new AppBar(
        //   title: new Text('我的'),
        // ),
        body: new SafeArea(
      child: new Column(children: <Widget>[
        new RaisedButton(
          key: _key,
          child: new Text('Query Data'),
          onPressed: () {
            // MqttHelper m = new MqttHelper();
            // m.createMqtt();
            // _getData();
            _getWidgetSize(_key);
            _showPMenu(_offset.dx+_size.width/3,_offset.dy+_size.height/2);
          },
        ),
        DropdownButton(
          value: _selectedSort,
          items: sortItems,
          onChanged: (s) => {},
        ),
        GestureDetector(
          child: Text(
            "张明月最近一直在加班，苦逼苦逼苦逼～～～",
            style:
                TextStyle(backgroundColor: bgColor, height: 1.5, fontSize: 15),
            key: _key1,
          ),
          // onLongPressStart: (detail) {
          //   bgColor = Colors.grey;
          //   setState(() {});
          //   _showMenu(context, detail);
          // },
          onLongPress: () {
            bgColor = Colors.grey;
            setState(() {});
            _showMenu1(_key1.currentContext);
          },
        ),
      ]),
    ));
  }

  PopupMenuButton _popMenu() {
    return PopupMenuButton(
      itemBuilder: (context) => _getPopupMenu(context),
      onSelected: (value) {
        print("onSelected");
        _selectValueChange(value);
      },
      onCanceled: () {
        print("onCanceled");
        bgColor = Colors.white;
        setState(() {});
      },
    );
  }

  _selectValueChange(String value) {
    setState(() {});
  }

  _showMenu(BuildContext context, LongPressStartDetails detail) {
    RenderBox renderBox = anchorKey.currentContext.findRenderObject();
    var offset = renderBox.localToGlobal(Offset(0.0, renderBox.size.height));
    final RelativeRect position = RelativeRect.fromLTRB(
        detail.globalPosition.dx, //取点击位置坐弹出x坐标
        offset.dy, //取text高度做弹出y坐标（这样弹出就不会遮挡文本）
        detail.globalPosition.dx,
        offset.dy);
    var pop = _popMenu();
    showMenu(
      context: context,
      items: pop.itemBuilder(context),
      position: position, //弹出框位置
    ).then((newValue) {
      if (!mounted) return null;
      if (newValue == null) {
        if (pop.onCanceled != null) pop.onCanceled();
        return null;
      }
      if (pop.onSelected != null) pop.onSelected(newValue);
    });
  }

  _showMenu1(BuildContext context) {
    // RenderBox renderBox = anchorKey.currentContext.findRenderObject();
    // var offset = renderBox.localToGlobal(Offset(0.0, renderBox.size.height));
    RenderBox box = context.findRenderObject();
    Offset offset = box.localToGlobal(Offset.zero);
    _offset = offset;
    // print("@@@ => MaintainPage._getWidgetSize($k) offset : $offset");
    //获取size
    Size size = box.size;

    final RelativeRect position = RelativeRect.fromLTRB(
        _offset.dx, //取点击位置坐弹出x坐标
        offset.dy, //取text高度做弹出y坐标（这样弹出就不会遮挡文本）
        10,
        offset.dy);
    var pop = _popMenu();
    showMenu(
      context: context,
      items: pop.itemBuilder(context),
      position: position, //弹出框位置
    ).then((newValue) {
      if (!mounted) return null;
      if (newValue == null) {
        if (pop.onCanceled != null) pop.onCanceled();
        return null;
      }
      if (pop.onSelected != null) pop.onSelected(newValue);
    });
  }

  _getPopupMenu(BuildContext context) {
    return <PopupMenuEntry>[
      PopupMenuItem(
        value: "复制",
        child: Text("复制"),
      ),
      // PopupMenuItem(
      //   value: "收藏",
      //   child: Text("收藏"),
      // ),
    ];
  }

  Offset _offset;
  Size _size;
  _getWidgetSize(GlobalKey k) {
    RenderBox box = k.currentContext.findRenderObject();
    Offset offset = box.localToGlobal(Offset.zero);
    _offset = offset;
    print("@@@ => MaintainPage._getWidgetSize($k) offset : $offset");
    //获取size
    Size size = box.size;
    _size = size;
    print("@@@ => MaintainPage._getWidgetSize($k) size : $size");
  }

  _showPMenu(double l, double t) async {
    print("@@@ AppStyle.getAppBarHeight() l : $l");
    print("@@@ AppStyle.screenSize.width t : $t");
    await showMenu(
      context: context,
      position: RelativeRect.fromLTRB(l, t, 1000.0, 1000.0),
      items: <PopupMenuItem<String>>[
        new PopupMenuItem(value: "0", child: new Text("存为模板")),
        new PopupMenuItem(value: "1", child: new Text("载入模板")),
        new PopupMenuItem(value: "2", child: new Text("报修")),
        new PopupMenuItem(value: "3", child: new Text("设置")),
        new PopupMenuItem(value: "4", child: new Text("帮助")),
      ],
    );
  }

  // int _pn = 1;
  _getData() async {
    // var param = {
    //   "pageno": _pn,
    // };

    String sret =
        await HttpCallerSrv.get("Home/News", null); //, GlobalVar.userInfo.tk);

    // print("@@@ AffairsListPage._getData() data => " + sret);

    if (sret == "http401") {
      Navigator.pop(context);
      Navigator.of(context).pushNamed("/login");
      return;
    }

    try {
      Map<String, dynamic> ret = json.decode(sret);
      HttpRetModel rm = HttpRetModel.fromJson(ret, new NewsModel());

      print("@@@ _getData() rm.data.length => ${rm.data.length}");

      if (rm.ret == 0) {
        if (rm.data.length > 0) {
          for (int i = 0; i < rm.data.length; i++) {
            NewsModel nm = rm.data[i] as NewsModel;
            // _ii = _ii + rm.data.length;
            print("@@@ NewsModel.title => ${nm.title}");
          }
        }
        // _pn++;
      }
    } catch (e) {
      print("*** AffairsListPage._getData() data => $e");
    }
  }
}

/*
        <provider
                android:name="androidx.core.content.FileProvider"
                android:authorities="${applicationId}.fileProvider"
                android:exported="false"
                android:grantUriPermissions="true"
                tools:replace="android:authorities">
            <meta-data
                    android:name="android.support.FILE_PROVIDER_PATHS"
                    android:resource="@xml/filepaths"
                    tools:replace="android:resource"/>
        </provider>
        */
