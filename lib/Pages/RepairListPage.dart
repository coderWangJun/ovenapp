import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ovenapp/Controls/AppImage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ovenapp/Models/HttpRetModel.dart';
import 'package:ovenapp/Models/NewsModel.dart';
import 'package:ovenapp/Publics/AppDataHelper.dart';
import 'package:ovenapp/Publics/AppFileHelper.dart';
import 'package:ovenapp/Publics/AppStyle.dart';
import 'package:ovenapp/Publics/DataHelper.dart';
import 'package:ovenapp/Publics/GlobalVar.dart';

class RepairListPage extends StatefulWidget {
  @override
  _RepairListPageState createState() => _RepairListPageState();
}

class _RepairListPageState extends State<RepairListPage> {
  @override
  void initState() {
    super.initState();
    // _lstData = [];
    // _getData();
    // fData =_getList();// Future.value(_lstData);
    print("@@@ => NewsListPage.initState() ... ");
  }

  @override
  void dispose() {
    super.dispose();
    // _streamController.close();
    print("@@@ NewsListPage.dispose() ...");
  }

  @override
  Widget build(BuildContext context) {
    print("@@@ NewsListPage.build() ...");
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: AppStyle.mainBackgroundColor,
        title: Text('维修列表'),
        // actions: _getActions(),
      ),
      body: Container(
        height: double.infinity,
        alignment: Alignment.center,
        child: Text(
          '您还没有维修记录~',
          style: TextStyle(
            fontFamily: AppStyle.ffPF,
            fontSize: 18.5,
            color: Colors.grey,
          ),
        ),
      ),
      // _getBodyUI(),
      // Refresh(
      //   onFooterRefresh: onFooterRefresh,
      //   onHeaderRefresh: onHeaderRefresh,
      //   child: _getBodyUI(),
      //   //ListView.builder(itemCount: _list.length, itemBuilder: _itemBuilder),
      // ), //_getRefreshUI(), //_getTemplateListFB(),
    );
  }

  String _imgfile = 'square_0.jpg';
  _getBodyUI() {
    return Wrap(
      children: <Widget>[
        Container(
          child: AppImage.circleImage(_imgfile, 80),
        ),
        Container(
          child: AppImage.squareImage(_imgfile, 80),
        ),
        Container(
          child: AppImage.rectImage(_imgfile, 80, 120),
        ),
        Container(
          child: AppImage.circleAssertImage(
            'images/power2.png',
            40.0,
            32.0,
            Colors.red,
            Colors.blueAccent,
          ),
          //,Colors.red,Colors.blueAccent,8.0,1.2,Colors.grey[200]
        ),
        Container(
          child: AppImage.rectAssertImage('images/power2.png', 60, 40, 24, 5.0,
              Colors.red, Colors.blueAccent, 1.8, Colors.cyanAccent),
          //,Colors.red,Colors.blueAccent,8.0,1.2,Colors.grey[200]
        ),
        Container(
          margin: EdgeInsets.all(9.0),
          child: AppImage.squareAssertImage(
            'images/power2.png',
            50,
            32,
            5.0,
            Colors.red,
            Colors.deepOrangeAccent,
            1.0,
            Colors.white,
          ),
          //,Colors.red,Colors.blueAccent,8.0,1.2,Colors.grey[200]
        ),
        Container(
          width: 48,
          height: 48,
          child: CircularProgressIndicator(),
        ),
        RaisedButton(
          onPressed: () {
            _imgfile = 'v_1.jpg';
            setState(() {});
          },
          child: Text('vert'),
        ),
        RaisedButton(
          onPressed: () {
            _imgfile = 'h_2.jpg';
            setState(() {});
          },
          child: Text('horz'),
        ),
        RaisedButton(
          onPressed: () {
            _imgfile = 'square_0.jpg';
            setState(() {});
          },
          child: Text('square'),
        ),
        RaisedButton(
          onPressed: () {
            // String ss = '20200430170631212127_1.jpg';
            // String sst = AppFileHelper.getLocalFile(ss);
            // print(
            //     '@@@ GlobalVar.appLocalPath : ${GlobalVar.appLocalPath} , sst : $sst}');
            // File _picFile =
            //     File(GlobalVar.appLocalPath + AppFileHelper.getLocalFile(sst));
            // bool blFileExist = _picFile.existsSync();
            // print('@@@ MyPage._getBackImage() blFileExist : $blFileExist');
            _queryData();
            // Size size = _getImageSize();
            // print(
            //     '@@@ RepairListPage._getImageSize() img.height : ${size.height} , img.width : ${size.width} , time : ${DateTime.now()}');
          },
          child: Text('AppDataHelper'),
        ),
        RaisedButton(
          onPressed: () {
            _getData();
          },
          child: Text('Http Srv'),
        ),
        RaisedButton(
          onPressed: () {
            _getAsyncComputeData();
          },
          child: Text('async Count'),
        ),
        RaisedButton(
          onPressed: () {
            _getComputeData();
          },
          child: Text('Compute Count'),
        ),
      ],
    );
  }

  _queryData() async {
    var param = {
      "pageno": 1,
      "orderby": "CreateDT DESC",
      // "cid": GlobalVar.userInfo.id,
    };

    // HttpRetModel rm =rm.data.length : ${rm.data.length} ,
    var htm = await AppDataHelper.dataQuerier('News/List', param, [NewsModel()])
        .then((rm) {
      print(
          '@@@ RepairListPage._queryData() then  => rm.ret : ${rm?.ret} ,  ${DateTime.now()}');
    });

    print(
        '@@@ RepairListPage._queryData() OK htm.ret : ${htm?.ret} , ${DateTime.now()}');
    // print('@@@ RepairListPage._queryData() rm.ret : ${rm.ret}'); as HttpRetModel
  }

  _getData() async {
    var param = {
      "pageno": 1,
      "orderby": "CreateDT DESC",
    };

    if (GlobalVar.userInfo != null)
      param = {
        "pageno": 1,
        "orderby": "CreateDT DESC",
        "cid": GlobalVar.userInfo.id,
      };
    print('@@@ RepairListPage._getData() Begin 1 : ${DateTime.now()}');
    await DataHelpr.dataQuerier('News/List', param, [NewsModel()], (ret) {
      print('@@@ RepairListPage._getData() End 1 : ${DateTime.now()}');
      HttpRetModel rm = ret as HttpRetModel;
      // print(
      //     '@@@ NewsListPage._getData rm.pagecount : ${rm.pagecount} , rm.totalcount : ${rm.totalcount} , data.length : ${rm.data.length}');
      if (rm.ret == 0) {
        print(
            '@@@ RepairListPage._getData() Ret 1 : ${DateTime.now()} , rm.data.length : ${rm.data.length}');
      }
      // print(
      //     '@@@ NewsListPage._getData _lstData.length : ${_lstData.length}, _pn:$_pn');
    });
  }

  static int countEven(int num) {
    int count = 0;
    while (num > 0) {
      if (num % 2 == 0) {
        count++;
      }
      num--;
    }
    return count;
  }

  _getComputeData() async {
    // print('@@@ RepairListPage._getComputeData() begin : ${DateTime.now()}');
    // int _count = await compute(countEven, 10000);
    // print(
    //     '@@@ RepairListPage._getComputeData() _count : $_count / ${DateTime.now()}');
    double d = 4.0 / 3.0;
    print('@@@ RepairListPage._getComputeData() d : ${d.toStringAsFixed(3)}');
  }

  _getAsyncComputeData() async {
    print(
        '@@@ RepairListPage._getAsyncComputeData() begin : ${DateTime.now()}');
    int _count = await asyncCountEven(100000);
    print(
        '@@@ RepairListPage._getAsyncComputeData() _count : $_count / ${DateTime.now()}');
  }

  Future<int> asyncCountEven(int num) async {
    int count = 0;
    while (num > 0) {
      if (num % 2 == 0) {
        count++;
      }
      num--;
    }
    return count;
  }
}
