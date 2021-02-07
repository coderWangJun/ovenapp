// import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ovenapp/BusinessObjects/TemplateBO.dart';
import 'package:ovenapp/Classes/AppDialog.dart';
// import 'package:ovenapp/Classes/SharePrefHelper.dart';
import 'package:ovenapp/Controls/AppWidget.dart';
// import 'package:ovenapp/Controls/DataWidget.dart';
// import 'package:ovenapp/Models/HttpRetModel.dart';
import 'package:ovenapp/Models/SectionTimeModel.dart';
import 'package:ovenapp/Models/TemplateModel.dart';
// import 'package:ovenapp/Models/TemplateModel.dart';
import 'package:ovenapp/Pages/TimeSectionEditPage.dart';
// import 'package:ovenapp/Publics/AppPublicData.dart';
import 'package:ovenapp/Publics/AppStyle.dart';
// import 'package:ovenapp/Publics/AppStyle.dart';
import 'package:ovenapp/Publics/DataHelper.dart';
import 'package:ovenapp/Publics/DateTimeHelper.dart';
// import 'package:ovenapp/Models/TemplateModel.dart';
import 'package:ovenapp/Publics/GlobalVar.dart';
// import 'package:ovenapp/Services/EventBusSrv.dart';
// import 'package:ovenapp/Services/HttpCallerSrv.dart';

class TLSectionPage extends StatefulWidget {
  // TLSectionPage({key:key,this.tid}) : super(key: key);
  TLSectionPage({Key key, this.id}) : super(key: key);
  final int id;
  @override
  _TLSectionPageState createState() => _TLSectionPageState();
}

class _TLSectionPageState extends State<TLSectionPage> {
  // var _onMqttPayloadEvent;
  List<dynamic> _lstData = [];
  Future<List<dynamic>> fData;

  double dTitleWidth = 80.0;
  double dSubLineLeftEdig = 20.0;
  double dSubLineHeight = 45.0;

  Color clTitleFC = Colors.grey;

  String spfile = GlobalVar.spsection;
  TemplateModel templateModel;
  final dItemHeight = 110.0;

  @override
  void initState() {
    super.initState();

    // spfile = TemplateBO.getSpfile();
    // templateModel = AppPublicData.mpDataModel[spfile];
    templateModel = GlobalVar.lstTemplate[widget.id];
    _lstData = GlobalVar
        .lstTemplate[widget.id].lstSection; // templateModel.lstSection;

    print("@@@ TLSectionPage.initState() ... template_id : ${widget.id}");

    // fData = Future.value(_getData());

    // _onMqttPayloadEvent = eventBus.on<TimeSectionEvent>().listen((event) {
    //   // DataHelpr.removeLocalData(spfile);
    //   String tid = event.tid;
    //   print('@@@ TLSectionPage.initState() _onMqttPayloadEvent tid : $tid');
    //   _refreshData();
    // });
    // tabController = new TabController(length: 3, vsync: this);
    // tabController.
  }

  @override
  void dispose() {
    super.dispose();
    // _streamController.close();

    // _onMqttPayloadEvent.cancel();
    print("@@@ TLSectionPage.dispose() ... ${DateTime.now()}");
    // tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("@@@ => TLSectionPage.build() ... ${DateTime.now()}");

    return Scaffold(
      // key: _scaffoldkey,
      appBar: AppBar(
        backgroundColor: AppStyle.mainBackgroundColor, //Color(0xFFE82662),//
        title: Text(templateModel.name),
        actions: _getActions(),
        elevation: 0.0,
        shape: AppWidget.getAppBarBottomBorder(),
      ),
      body:
          // Container(
          //   margin: EdgeInsets.only(top: 12.0),
          //   child:
          SafeArea(
        // minimum: EdgeInsets.only(top: 12.0),
        child: _getBodyUI(),
      ),
      // Refresh(
      //   onFooterRefresh: onFooterRefresh,
      //   onHeaderRefresh: onHeaderRefresh,
      //   child: _queryData(),
      //   //ListView.builder(itemCount: _list.length, itemBuilder: _itemBuilder),
      // ), //_getRefreshUI(), //_getTemplateListFB(),
    );
  }

  _getActions() {
    return <Widget>[
      IconButton(
          icon: Icon(Icons.add),
          color: AppStyle.clTitle2FC,
          iconSize: 28.0,
          onPressed: () {
            _add();
          }),
    ];
  }

  bool blChanged = false;

  _add() async {
    await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => TimeSectionEditPage(
                  tn: templateModel.id,
                  sn: (templateModel.lstSection == null
                      ? 1
                      : templateModel.lstSection.length + 1),
                  edittype: 1,
                ))).then((ret) {
      print('@@@ TLSectionPage._add() ret : $ret');
      if (ret != null && ret == 'OK') {
        // eventBus.fire(TimeSectionEvent(templateModel.id.toString()));
        _refreshData();
      }
    });
  }

  _getBodyUI() {
    // print('@@@ TLSectionPage._getBodyUI() ...');

    if (GlobalVar.userInfo == null ||
        _lstData == null ||
        _lstData.length == 0) {
      return AppWidget.getEmptyData(() {
        _refreshData();
      });
    }

    // if (querycount == 0) return AppWidget.getCircularProgress();

    // if (_lstData.length == 0) {
    //   return AppWidget.getEmptyData(() {
    //     _refreshData();
    //   });
    // }

    // return ListView.builder(itemCount: _list.length, itemBuilder: _itemBuilder);
    return _getListViewUI();
  }

// _getBodyFB(){
//   return FutureBuilder(
//       future: fData, //_getData(context), //_getDataList(),//
//       builder: (context, snapshot) {
//         switch (snapshot.connectionState) {
//           case ConnectionState.none:
//           case ConnectionState.active:
//           case ConnectionState.waiting:
//             print(snapshot.connectionState);
//             return Center(child: CupertinoActivityIndicator());
//           case ConnectionState.done:
//             // print('done');

//             if (snapshot.hasError) {
//               return Center(
//                 child: Text('网络请求出错'),
//               );
//             }
//             // _newsData = snapshot.data;
//             return _getUI(context, snapshot.data);
//           default:
//             return DataWidget.emptyData();
//         }
//         // return null;
//       },
//     );
// }
  // Future<List<dynamic>> _getDataList() async {
  //   print("@@@ TLSectionPage._getDataList() begin --> ${DateTime.now()}");
  //   return fData;
  // }

//   Future<List<dynamic>> _getData() async {
//     // print("@@@ TLSectionPage._getData() begin --> ${DateTime.now()}");

// // print("@@@ TLSectionPage._getData() spfile : $spfile");

//     var data = DataHelpr.getLocalData(spfile);
//     // print("@@@ TLSectionPage._getData() data : $data");
//     if (data != null) {
//       TemplateBO.tsCount = data.length + 1;
//       return data;
//     }

//     // int datafrom = 1;
//     // String jsonData = await SharePrefHelper.getData(GlobalVar.sptemplate);
//     // print(
//     //     "@@@ TLSectionPage._getData() SharePrefHelper.getData jsonData.isEmpty : ${jsonData.isEmpty}");
//     // if (jsonData != null && jsonData != "") {
//     //   // print("@@@ DeviceBO._getDeviceData() from SharePref : $jsonData");
//     //   // sret = spdata;
//     // } else {
//     // print("@@@ TLSectionPage._getData() get ... ${DateTime.now()}");

//     String jsonData = await HttpCallerSrv.get(
//         "TimeSection/List", {"template_id": widget.tid}, GlobalVar.userInfo.tk);

//     // print("@@@ TLSectionPage._getData() from Cloud Server : $jsonData");

//     // if (jsonData == "http401") {
//     //   // Navigator.pop(context);
//     //   // Navigator.of(context).pushNamed("/login");
//     //   return [];
//     // }
//     //   datafrom = 0;
//     //   SharePrefHelper.saveData(GlobalVar.sptemplate, jsonData);
//     // }

//     // print("@@@ TLSectionPage._getData() jsonData => " + jsonData);

//     HttpRetModel rm;
//     try {
//       Map<String, dynamic> ret = json.decode(jsonData);
//       rm = HttpRetModel.fromJson(ret, SectionTimeModel());

//       // print("@@@ TLSectionPage._getData() from " +
//       //     (datafrom == 0 ? "Cloud Server" : "Local Storage") +
//       //     " data.length => ${rm.data.length}");
//       if (rm.data.length == 0)
//         _lstData = [];
//       else {
//         // print("@@@ TLSectionPage._getData() rm.data.length => ${rm.data.length}");
//         _lstData = rm
//             .data; // as List<SectionTimeModel>; 此处不可直接转换成 List<SectionTimeModel>，不然报错  type 'List<dynamic>' is not a subtype of type 'List<SectionTimeModel>' in type cast
//       }

//       TemplateBO.tsCount = _lstData.length + 1;
//       print(
//           "@@@ TLSectionPage._getData() _lstData : ${_lstData.length} , tsCount : ${TemplateBO.tsCount}");
//     } catch (e) {
//       _lstData = [];
//       // SharePrefHelper.removeData(GlobalVar.sptemplate);
//       print("*** TLSectionPage._getData() data => $e");
//     }

//     DataHelpr.setLocalData(spfile, _lstData);

//     return _lstData;
//   }

  _getListViewUI() {
    //BuildContext context, List<dynamic> data
    // print("@@@ TLSectionPage._getUI() begin --> ${DateTime.now()}");
    // print("@@@ TLSectionPage._getUI() data.length --> ${data.length}");

    List<Widget> _lst = new List<Widget>();
    // if (GlobalVar.userInfo == null) return ListView(children: _lst);

    // if (data.length > 0) {
    for (int i = 0; i < _lstData.length; i++) {
      SectionTimeModel tm = _lstData[i] as SectionTimeModel;

      // print("@@@ DeviceBO._getDeviceUI() dm.name => ${dm.name}");

      Widget w =
          _getItemUI(tm); // Text(tm.tn.toString() + '.' + tm.sn.toString());
      _lst.add(w);
    }

    _lst.add(SizedBox(
      height: 80.0,
    ));
    // } else {
    //   return DataWidget.emptyData();
    // }

    return ListView(children: _lst);
  }

  _getItemUI(SectionTimeModel stm) {
    return Container(
      // color: Colors.orange,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border(
            bottom: BorderSide(color: Colors.grey[300], width: 1.0)), //灰色的一层边框
        // color: Colors.orange,
      ),
      height: dItemHeight,
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.baseline,
        children: <Widget>[
          //倒计时
          _getClockTimeUI(stm.timer),

          // 上下火
          Expanded(
            child: Container(
              // color: Colors.tealAccent,
              height: double.infinity,
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  // 上火
                  _getUpDownFireUI(stm, 'up'),

                  Container(
                    color: Colors.grey[200],
                    width: double.infinity,
                    height: 0.8,
                  ),
                  // 下火
                  _getUpDownFireUI(stm, 'down'),
                ],
              ),
            ),
          ),

          // 进水
          _getSteamTUI(stm.steamt.toString()),

          //编辑
          _getEditorUI(stm),
        ],
      ),
    );
  }

  _getClockTimeUI(timer) {
    return Container(
      alignment: Alignment.center,
      width: 70.0,
      height: 70.0,
      margin: EdgeInsets.all(10.0),
      padding: EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        // image: Image.asset('images/clock3.png'),
        border: Border.all(color: Colors.grey[300], width: 0.8),
        borderRadius: BorderRadius.all(
          Radius.circular(35.0),
        ),
        // image: new DecorationImage(
        //   image: new AssetImage('images/clock3.png'),
        //   fit: BoxFit.fill,
        //   //这里是从assets静态文件中获取的，也可以new NetworkImage(）从网络上获取
        //   //  centerSlice: new Rect.fromLTRB(270.0, 180.0, 1360.0, 730.0),
        // ),
        color: Colors.grey[200],
      ),
      child: Text(
        DateTimeHelper.changeSecToMS(timer),
        style: TextStyle(
            color: Colors.black45, fontWeight: FontWeight.bold, fontSize: 22.0),
        // stm.timer.toString(),
      ),
    );
  }

  _getSteamTUI(steamt) {
    return Container(
      width: 60.0,
      // margin: EdgeInsets.only(
      //   left: 5.0,
      //   right: 5.0,
      // ),
      // color: Colors.blueGrey,
      alignment: Alignment.center,
      // width: 80.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            child: Image.asset(
              'images/waterin.png',
              height: 20.0,
              width: 20.0,
              color: Colors.black54,
            ), // Text('进水', style: AppStyle.titleTextStyle),
          ),
          Container(
            alignment: Alignment.topCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  steamt.toString(),
                  style: TextStyle(
                      color: Colors.purple,
                      fontWeight: FontWeight.bold,
                      fontSize: 24.0),
                ),
                Text(
                  'S',
                  style: TextStyle(color: Colors.black54),
                ),
              ],
            ),
          ),
        ],
      ), //stm.steamt.toString()
    );
  }

  _getEditorUI(SectionTimeModel stm) {
    return Container(
      width: 40.0,
      alignment: Alignment.center,
      // color: Colors.tealAccent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          IconButton(
              icon: Icon(
                Icons.add_to_photos,
                color: Colors.black45,
              ),
              iconSize: 28.0,
              padding: EdgeInsets.zero,
              onPressed: () {
                _insertSection(stm);
              }),
          IconButton(
              icon: Icon(
                Icons.clear,
                color: Colors.black45,
              ),
              iconSize: 28.0,
              padding: EdgeInsets.zero,
              onPressed: () {
                print("@@@ TLSectionPage._getEditorUI() stm.tn : ${stm.tn}");
                AppDialog.showYesNoIOS(context, '删除确认', '您确定要删除该项时段吗？', () {
                  _delete(stm);
                });
              }),
        ],
      ),
    );
  }

  _insertSection(sm) async {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => TimeSectionEditPage(
                  tn: sm.tn,
                  sn: sm.sn,
                  edittype: 2,
                ))).then((ret) {
      // print('@@@ ret : $ret');
      if (ret != null && ret == 'OK') {
        // SharePrefHelper.removeData(GlobalVar.spsection + sm.id.toString());
        // DataHelpr.removeLocalData(spfile);
        _refreshData();
      }
    });
  }

  _refreshData() {
    blChanged = true;
    // TemplateBO.cleanCache();
    setState(() {});
    // DataHelpr.removeLocalData(spfile);
    // setState(() {
    //   //注：以静态数据为基础的刷新，必须带上这句，不然即使 setState 数据也不会获取；***有误，还是每次刷新都提了数据
    //   fData = Future.value(_getData());
    // });
  }

  _delete(stm) async {
    print("@@@ TLSectionPage._delete => ${stm.id}");

    Map<String, dynamic> param = {"id": stm.id};
    DataHelpr.dataHandler('TimeSection/Delete', param, (ret) {
      DataHelpr.resultHandler(ret, () {
        templateModel.lstSection.remove(stm);
        TemplateBO.cleanCache();
        _refreshData();
      });
    });
    // String sret = await HttpCallerSrv.post(
    //     "TimeSection/Delete", param, GlobalVar.userInfo.tk);

    // print("@@@ TLSectionPage._deleteSection() data => " + sret);
    // Map<String, dynamic> ret = json.decode(sret);
    // HttpRetModel retmodel = HttpRetModel.fromJsonExec(ret);
    // //  print("@@@ DevicePage.retmodel => ");
    // print(retmodel);
    // if (retmodel.ret == 0) {
    //   // SharePrefHelper.removeData(spfile);
    //   // DataHelpr.removeLocalData(spfile);
    //   _refreshData();
    // }
  }

  _getUpDownFireUI(SectionTimeModel stm, String name) {
    return Expanded(
      child: Container(
        // color: Colors.indigoAccent,
        alignment: Alignment.center,
        // decoration: BoxDecoration(
        //   border: Border(
        //       bottom:
        //           BorderSide(color: Colors.grey[200], width: 1.0)), //灰色的一层边框
        //   // color: Colors.indigoAccent,
        // ),

        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            // Expanded(
            // flex: 10,
            // child:
            Container(
              alignment: Alignment.center,
              width: 55.0,
              child: Image.asset(
                'images/' + (name == 'up' ? 'upfire' : 'downfire') + '.png',
                height: 32.0,
                width: 28.0,
                // fit: BoxFit.fill,
                color: name == 'up'
                    ? (stm.ups == 0 ? Colors.grey[400] : Colors.redAccent)
                    : (stm.downs == 0
                        ? Colors.grey[400]
                        : Colors.red), //Colors.red,
              ),
            ),

            Expanded(
              flex: 20,
              child: Container(
                // width: dTitleWidth,
                alignment: Alignment.centerRight,
                // margin: EdgeInsets.only(left: 25.0),
                child: Text(
                  //"温度 : ${_temp.round()}", + ' ℃'
                  name == 'up'
                      ? stm.uptemp.toString()
                      : stm.downtemp.toString(),
                  style: TextStyle(
                    color: name == 'up' ? Colors.redAccent : Colors.red,
                    fontSize: 28.0,
                    fontWeight: FontWeight.bold,
                  ),
                  // textAlign: TextAlign.left,
                ),
              ),
            ),
            Container(
              width: 20.0,
              alignment: Alignment.bottomCenter,
              margin: const EdgeInsets.only(bottom: 15.0),
              child: const Text(
                '℃',
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 20.0,
                ),
              ),
            ),

            Expanded(
              flex: 13,
              child: Container(
                // width: 50.0,
                alignment: Alignment.centerRight,
                // margin: EdgeInsets.only(left: 25.0),
                child: Text(
                  //"温度 : ${_temp.round()}",
                  name == 'up'
                      ? stm.uppower.toString()
                      : stm.downpower.toString(),
                  style: const TextStyle(
                    color: Colors.blueAccent,
                    fontSize: 28.0,
                    fontWeight: FontWeight.bold,
                  ),
                  // textAlign: TextAlign.left,
                ),
              ),
            ),

            Container(
              width: 20.0,
              // height: 100.0,
              alignment: Alignment.bottomCenter,
              margin: const EdgeInsets.only(bottom: 15.0),
              child: const Text(
                'P',
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 20.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
