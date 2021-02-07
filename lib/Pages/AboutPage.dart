import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:ovenapp/Classes/ApkHelper.dart';
import 'package:ovenapp/Classes/SharePrefHelper.dart';
// import 'package:ovenapp/Classes/AppDialog.dart';
import 'package:ovenapp/Controls/AppImage.dart';
import 'package:ovenapp/Pages/PrivateTextPage.dart';
// import 'package:ovenapp/Publics/AppStyle.dart';
import 'package:ovenapp/Publics/GlobalVar.dart';
// import 'package:ovenapp/Classes/AppDialog.dart';
import 'package:ovenapp/Classes/app_dialog_helper.dart';

class AboutPage extends StatelessWidget {
  final String privateStr1 =
      '请你务必审慎阅读、充分理解“服务协议”和“隐私政策”各条款，包括但不限于：为了向你提供即时通讯、内容分享等服务，我们需要收集你的设备信息、操作日志等个人信息。你可以在“设置”中查看、变更、删除个人信息并管理你的授权。你可阅读';
  // '《服务协议》和《隐私政策》
  final String privateStr2 = '了解详细信息。如你同意，请点击“同意”开始接受我们的服务。';
  final List<dynamic> _lstData = [
    '版本更新',
    // '功能介绍',
    // '官网',
    '隐私保护指引',
    // '帮助',
    // '反馈',
  ];

  final Color clService = Color(0xFF004696);
  final TextStyle tsService = TextStyle(color: Colors.grey, fontSize: 16.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        leading: null,
        title: Text('关于烘焙之光与帮助'),
        elevation: 0.0,
        backgroundColor: Colors.greenAccent,
      ),
      body:
          // SingleChildScrollView(
          //   child:
          //    AnnotatedRegion<SystemUiOverlayStyle>(
          // value: SystemUiOverlayStyle.light,
          // child:
          Container(
        height: MediaQuery.of(context).size.height,
        child: _getMainUI(context),
        // Stack(
        //   children: <Widget>[
        //     _getMainUI(),
        //   ],
        // ),
      ),
      // ),
      // ),
    );
  }

  _getMainUI(context) {
    return Container(
      // child: SingleChildScrollView(
      height: double.infinity,
      child: Column(
        children: <Widget>[
          _getHeaderUI(),
          _getListUI(context),
          _getAgreementUI(context),
        ],
      ),
      // ),
    );
  }

  _getHeaderUI() {
    return AspectRatio(
      aspectRatio: 6.5 / 3,
      child: Container(
        color: Colors.grey[100],
        width: double.infinity,
        // height: 150.0,
        child: Column(
          children: <Widget>[
            Expanded(
              child: Text(''),
              flex: 2,
            ),
            AppImage.circleAssertImage(
              'hpzj.png',
              70.0,
              70.0,
              Color(0xFFA80A16),
              // Colors.transparent,
              // 1.0,
            ),
            // Image.asset('images/downfire.png'),
            SizedBox(
              height: 8.0,
            ),
            Container(
              height: 22.0,
              child: Text(
                '烘焙之光',
                style: TextStyle(color: Colors.black, fontSize: 18.0),
              ),
            ),
            SizedBox(
              height: 8.0,
            ),
            Container(
              height: 20.0,
              child: Text(
                'V' + ApkHelper.version,
                style: TextStyle(color: Colors.grey, fontSize: 18.0),
              ),
            ),
            Expanded(
              child: Text(''),
              flex: 1,
            ),
          ],
        ),
      ),
    );
  }

  _getListUI(context) {
    return Expanded(
      flex: 1,
      child: Container(
        color: Colors.white,
        // constraints: BoxConstraints.expand(height: double.infinity,),
        // height: 600,
        // height: double.infinity,
        child: _getListViewUI(context),
        // child: Column(
        //   children: _getListItemUI(),
        // ),
      ),
    );
  }

  // _getListItemUI() {
  //   List<Widget> _lst = [];
  //   for (int i = 0; i < _lstData.length; i++) {
  //     _lst.add(_getListItem(i));
  //   }
  //   return _lst;
  // }

  _getListViewUI(context) {
    Widget divider1 = Divider(
      height: 4.0,
      color: Colors.grey[300],
      indent: 18.0,
      endIndent: 0.0,
      thickness: 0.5,
    );
    // List<Widget> _lst=[];
    // _lst
    return ListView.separated(
      padding: EdgeInsets.all(0.0),
      itemCount: _lstData.length,
      itemBuilder: (BuildContext context, int position) {
        return _getListItem(context, position);
      },
      separatorBuilder: (BuildContext context, int index) {
        // return index % 2 == 0 ? divider1 : divider2;
        return divider1;
      },
    );
  }

  _getListItem(context, index) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 0.0, bottom: 0.0),
      // decoration: BoxDecoration(
      //   border: Border(
      //     bottom: BorderSide(
      //         color: AppStyle.clSplitterLineColor,
      //         width: 0.6,
      //         style: BorderStyle.solid),
      //   ),
      // ),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        // EdgeInsets.only(left: 20.0, right: 10.0, top: 0.0, bottom: 0.0),
        // dense: true,
        // leading: Icon(
        //   _lstIcon[index], //Icons.recent_actors,
        //   size: 26.0,
        //   color: AppStyle.mainColor, // Colors.blue[500],
        // ),
        title: Text(
          _lstData[index],
          // 'List $index',
          style: TextStyle(color: Colors.black87, fontSize: 18.0),
        ),
        selected: true,
        trailing: _getTrailingUI(index),
        // Icon(
        //   Icons.keyboard_arrow_right,
        //   color: Colors.grey[300],
        //   size: 30.0,
        // ),
        onTap: () {
          _showPage(context, index);
        },
      ),
    );
  }

  _getTrailingUI(index) {
    List<Widget> _lst = [];
    if (_lstData[index] == '版本更新') {
      // print(
      //     "@@@ => AboutPage._getTrailingUI($index) ApkHelper.newversion : ${ApkHelper.newversion} , ApkHelper.version : ${ApkHelper.version}");
      if (ApkHelper.newversion == ApkHelper.version) {
        // return Row(children: <Widget>[
        _lst.add(Text(
          '已是最新版本',
          style: tsService,
        ));
        // ],);
      } else {
        _lst.add(_getNewUI());
        _lst.add(
          SizedBox(
            width: 0.0,
          ),
        );
        _lst.add(Text(
          '有新版本可用',
          style: tsService,
        ));
      }
    } else if (_lstData[index] == '隐私保护指引') {
      // print(
      //     "@@@ => AboutPage._getTrailingUI($index) GlobalVar.hasreadprivateprotect：${GlobalVar.hasreadprivateprotect}");
      if (GlobalVar.hasreadprivateprotect == 0) {
        _lst.add(_getNewUI());
      }
    }
    _lst.add(Icon(
      Icons.keyboard_arrow_right,
      color: Colors.grey[300],
      size: 30.0,
    ));

    return Container(
      alignment: Alignment.centerRight,
      // color: Colors.yellow[50],
      width: 180.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: _lst,
      ),
    );
  }

  _getNewUI() {
    return RawChip(
      label: Text('NEW'),
      labelStyle: TextStyle(color: Colors.white, fontSize: 13.5),
      labelPadding: EdgeInsets.symmetric(horizontal: 10),
      backgroundColor: Colors.red,
      // padding: EdgeInsets.zero,
    ); //Text('NEW')
  }

  _getAgreementUI(context) {
    return Container(
      height: 60.0,
      // color: Colors.yellowAccent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 4.0,
          ),
          Container(
            height: 30.0,
            // color: Colors.tealAccent,
            alignment: Alignment.bottomCenter,
            // padding: EdgeInsets.fromLTRB(0,0,0,8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                FlatButton(
                  onPressed: () {
                    _showService(context, 0);
                  },
                  child: Text(
                    '服务协议',
                    style: TextStyle(
                      color: clService,
                      fontSize: 17.5,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
                Container(
                  width: 1.0,
                  color: clService,
                  height: 16,
                ),
                FlatButton(
                  onPressed: () {
                    _showService(context, 1);
                  },
                  child: Text(
                    '隐私政策',
                    style: TextStyle(
                      color: clService,
                      fontSize: 17.5,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 24.0,
            alignment: Alignment.topCenter,
            child: Text(
              'Copyright © 2013-2020 Cfdz.All Rights Reserved',
              style: TextStyle(color: Colors.grey, fontSize: 14.0),
            ),
          ),
        ],
      ),
    );
  }

  _showService(context, ft) {
    print("@@@ => AboutPage._showService($ft) ... ");
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => PrivateTextPage(
                  tt: ft,
                )));
  }

  _showPage(context, index) {
    switch (_lstData[index]) {
      case '版本更新':
        if (Platform.isAndroid) ApkHelper.getVersion(context, 1);
        break;
      case '隐私保护指引':
        _showPrivate(context);
        break;
      case '功能介绍':
        _showFuncIntroPage(context);
        break;
    }
    print("@@@ => AboutPage._showPage($index) ... ");
  }

  _showFuncIntroPage(context) async {
    // List<ActionButtonModel> _lstAB = [];
    // _lstAB.add(ActionButtonModel(
    //     id: 1, title: '确定')); //,foreColor: CupertinoColors.systemBlue

    // List<ContentTextModel> _lstText = [
    //   ContentTextModel(text: '您当前使用的是最新版本！', foreColor: Colors.green[700])
    // ];

    // var ret = await AppDiaglogHelper.showTitleTextButtonsDialog(
    //     context, TitleTextModel(text: '提示'), _lstText, _lstAB);
    // print("@@@ ApkHelper => _showNoUpdate ret : $ret");
  }

  _showPrivate(context) async {
    List<ActionButtonModel> _lstAB = [];
    _lstAB.add(
        ActionButtonModel(id: 0, title: '暂不使用', foreColor: Colors.black87));
    _lstAB.add(ActionButtonModel(
        id: 1, title: '同意')); //,foreColor: CupertinoColors.systemBlue

    RichText rt = RichText(
      text: TextSpan(
          // style: DefaultTextStyle.of(context).style,
          style: TextStyle(
              color: Colors.black87, fontSize: 16.0, fontFamily: '.SF UI Text'),
          children: <InlineSpan>[
            TextSpan(text: privateStr1),
            TextSpan(
              text: '《服务协议》',
              style: TextStyle(color: Colors.blue[300]),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  print(
                      "@@@ AboutPage => _showPrivate.TapGestureRecognizer 《服务协议》");
                  Navigator.of(context).pop(2);
                },
            ),
            TextSpan(text: '和'),
            TextSpan(
              text: '《隐私政策》',
              style: TextStyle(color: Colors.blue[300]),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  print(
                      "@@@ AboutPage => _showPrivate.TapGestureRecognizer 《隐私政策》");
                  Navigator.of(context).pop(3);
                },
            ),
            TextSpan(text: privateStr2),
          ]),
    );

    var ret = await AppDiaglogHelper.showRichTextButtonsDialog(
        context, TitleTextModel(text: '服务协议和隐私政策'), rt, _lstAB);
    if (ret != null) {
      if (ret == 1)
        SharePrefHelper.saveData("privateprotect", 'agreed');
      else if (ret == 2)
        _showService(context, 0);
      else if (ret == 3) _showService(context, 1);
    }
    print("@@@ => AboutPage._showPrivate ret : $ret");
  }
// List<ActionButtonModel> _lstAB=[];
// _lstAB.add(ActionButtonModel(id:0,title: '暂不升级',foreColor: Colors.grey));
// _lstAB.add(ActionButtonModel(id:2,title: '再看看吧',foreColor: Colors.grey));
// _lstAB.add(ActionButtonModel(id:1,title: '立即升级',foreColor: Colors.black, backgroundColor: Colors.yellowAccent));  //,foreColor: CupertinoColors.systemBlue

// List<ContentTextModel> _lstText=[];
// _lstText.add(ContentTextModel(text: '高档升级1'));
// _lstText.add(ContentTextModel(text: '中档下载2'));
// _lstText.add(ContentTextModel(text: '低档下载3'));

//     var ret = await AppDiaglogHelper.showTitleTextButtonsDialog(context, TitleTextModel(text:'发现新版本'), _lstText,_lstAB);
//     print("@@@ => AboutPage._showPrivate ret : $ret");
//   }
}
//发现新版本@#版本：1.20.337  大小：37.6M@#本次更新@#1.修改了图文显示；@#2.增加商城产品；@#3.增加远程视频在线教学功能；@#https://www.cfdzkj.com/downloads/app/cleveroven.apkss
