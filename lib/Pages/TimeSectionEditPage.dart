// import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ovenapp/BusinessObjects/TemplateBO.dart';
// import 'package:ovenapp/BusinessObjects/TemplateBO.dart';
// import 'package:ovenapp/Classes/AppDialog.dart';
import 'package:ovenapp/Classes/AppToast.dart';
import 'package:ovenapp/Classes/SharePrefHelper.dart';
import 'package:ovenapp/Controls/AppWidget.dart';
// import 'package:ovenapp/Models/HttpRetModel.dart';
import 'package:ovenapp/Models/SectionTimeModel.dart';
import 'package:ovenapp/Models/TemplateModel.dart';
import 'package:ovenapp/Publics/AppPublicData.dart';
// import 'package:ovenapp/Publics/AppObjHelper.dart';
// import 'package:ovenapp/Models/TemplateModel.dart';
import 'package:ovenapp/Publics/AppStyle.dart';
import 'package:ovenapp/Publics/DataHelper.dart';
import 'package:ovenapp/Publics/GlobalVar.dart';
// import 'package:ovenapp/Publics/GlobalVar.dart';
// import 'package:ovenapp/Services/HttpCallerSrv.dart';

// ignore: must_be_immutable
class TimeSectionEditPage extends StatelessWidget {
  TimeSectionEditPage({Key key, this.tn, this.sn, this.edittype})
      : super(key: key);

// final SectionTimeModel sectionTimeModel;
  final int tn;
  final int sn;
  // final SectionTimeModel sectionTimeModel;this.sectionTimeModel
  final int edittype;
  // final int tid;, this.tid

  final double dTitleWidth = 80.0;
  final double dSubLineLeftEdig = 20.0;
  final double dSubLineHeight = 45.0;

  final Color clTitleFC = Colors.grey;

  final TextEditingController timerController = TextEditingController();
  // final TextEditingController upsController = TextEditingController();
  final TextEditingController uptempController = TextEditingController();
  final TextEditingController uppowerController = TextEditingController();
  // final TextEditingController downsController = TextEditingController();
  final TextEditingController downtempController = TextEditingController();
  final TextEditingController downpowerController = TextEditingController();
  final TextEditingController steamtController = TextEditingController();
  final TextStyle titleTextStyle = TextStyle(
    color: AppStyle.clTitle2FC,
    fontSize: 16.5,
  );

  int ups = 1;
  int downs = 1;
  // static const EdgeInsets editPadding = EdgeInsets.only(
  //   left: 10.0,
  //   top: 10.0,
  //   bottom: 10.0,
  // );

  @override
  Widget build(BuildContext context) {
    print("@@@ => TimeSectionEditPage.build() ... tn ：$tn");

    double dCardElevation = 0.0;
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('时段设置'),
        backgroundColor: AppStyle.mainBackgroundColor,
        elevation: 0.0,
        shape: AppWidget.getAppBarBottomBorder(),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        // controller: controller,

        child: Container(
          margin: EdgeInsets.all(10.0),
          child: Column(children: <Widget>[
            Container(
              margin: EdgeInsets.only(bottom: 10.0),
              decoration: BoxDecoration(
                color: Colors.white,
                border:
                    Border.all(color: Colors.grey[300], width: 0.8), //灰色的一层边框
                // color: Colors.orange,
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
              ),
              // elevation: dCardElevation,
              //  shape: Border(
              //     bottom: BorderSide(
              //       width: 0.8,
              //       color:
              //           Colors.greenAccent, // AppStyle.clAppBarBottomLineColor,
              //     ),
              //   ),
              child: _getTextField("运行时间 : ", '分钟', timerController, 99),
            ),
            // Card(
            //   margin: EdgeInsets.only(bottom: 10.0),
            //   elevation: dCardElevation,
            //   child: _getTextField("进水时间 : ", '秒', steamtController, 100),
            // ),
            Container(
              margin: EdgeInsets.only(bottom: 10.0),
              decoration: BoxDecoration(
                color: Colors.white,
                border:
                    Border.all(color: Colors.grey[300], width: 0.8), //灰色的一层边框
                // color: Colors.orange,
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
              ),
              child: _getUpDownTextField('up'),
            ),

            Container(
              margin: EdgeInsets.only(bottom: 10.0),
              decoration: BoxDecoration(
                color: Colors.white,
                border:
                    Border.all(color: Colors.grey[300], width: 0.8), //灰色的一层边框
                // color: Colors.orange,
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
              ),
              child: _getUpDownTextField('down'),
            ),

            _getLoginButton(context, 'save'),
            // _getLoginButton(context, 'exit'),
            // RaisedButton(
            //   child: Text('取消'),
            //   onPressed: () {
            //     Navigator.of(context).pop();
            //   },
            // ),
          ]),
        ),
      )),
    );
  }

  final double dButtonHeight = 45.0;

  _getLoginButton(context, String name) {
    return Container(
      margin: EdgeInsets.only(top: 10.0),
      width: double.infinity,
      height: dButtonHeight,
      child: RaisedButton(
        color: name == 'save' ? AppStyle.mainColor : Colors.redAccent,
        child: Text(
          name == 'save' ? '保 存' : '取 消',
          style: TextStyle(
            // height: 2.2,
            color: Colors.white,
            fontSize: 19,
            fontFamily: "微软雅黑",
            // backgroundColor: AppStyle.mainColor,
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(3.0),
          // side: BorderSide(color: Colors.red),
          //size:Size(width, height),
        ), //圆角大小
        onPressed: () {
          if (name == 'save')
            _saveData(context);
          else
            Navigator.of(context).pop('Cancel');
        },
      ),
    );
  }

  _getTextField(String name, String unit, TextEditingController controller,
      int maxValue) {
    return Container(
      // color: Colors.orangeAccent,
      margin: EdgeInsets.only(left: 2.0, right: 2.0, bottom: 0.0),
      height: 50.0,
      // margin: EdgeInsets.all(0.0),
      width: double.infinity,
      padding: EdgeInsets.only(left: 15.0, right: 15.0, bottom: 0.0),
      child: Row(
        children: <Widget>[
//子控件开始

//倒计时
          Container(
            // width: 100.0,
            child: Text(
              '运行(分钟) : ',
              style: titleTextStyle,
              // TextStyle(
              //   color: AppStyle.clTitle2FC,
              //   fontSize: 16.5,
              // ),
            ),
          ),
          Expanded(
            child: _getCupertinoTF('timer'),
          ),
          Container(
            width: 20.0,
          ),
          //进水时间
          Container(
            // width: 100.0,
            child: Text(
              '进水(秒) : ',
              style: titleTextStyle,
            ),
          ),
          Expanded(
            child: _getCupertinoTF('steamt'),
          ),

          //子控件结束
        ],
      ),
    );
  }

  _getUpDownTextField(String name) {
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(
              top: 5.0, left: dSubLineLeftEdig, right: 20.0, bottom: 5.0),
          height: dSubLineHeight,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border(
                bottom:
                    BorderSide(color: Colors.grey[200], width: 1.0)), //灰色的一层边框

            // border:
            //     Border.all(color: AppStyle.clTitleBC, width: 1.0),
            // color: Colors.white,
            // borderRadius: BorderRadius.all(Radius.circular(5.0)),
            // borderRadius: BorderRadius.only(
            //   bottomLeft: Radius.circular(3.0),
            //   bottomRight: Radius.circular(3.0),
            //   topLeft: Radius.zero,
            //   topRight: Radius.zero,
            // ),
          ),
          // color: Colors.orangeAccent, Cupertino
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              SizedBox(
                width: dTitleWidth,
                child: Text(
                  name == 'up' ? "上火：" : '下火：',
                  style: titleTextStyle,
                  textAlign: TextAlign.left,
                ),
              ),
              CupertinoSwitch(
                  value: true, // sectionTimeModel.ups == 1,
                  onChanged: (v) {
                    if (name == 'up')
                      ups = (v ? 1 : 0);
                    else
                      downs = (v ? 1 : 0);
                    // setState(() {
                    //   _isOpen = v;
                    // });
                  }),
            ],
          ),
          // color: Colors.limeAccent,
        ),
        Container(
          height: dSubLineHeight,
          alignment: Alignment.center,
          margin: EdgeInsets.only(
              top: 0.0, left: dSubLineLeftEdig, right: 20.0, bottom: 10.0),
          child: Row(
            children: <Widget>[
              Container(
                // width: dTitleWidth,
                child: Text(
                  //"温度 : ${_temp.round()}",
                  "温度(℃) : ",
                  style: titleTextStyle,
                  // textAlign: TextAlign.left,
                ),
              ),
              Expanded(
                // color: Colors.pinkAccent,
                child: _getCupertinoTF(name + 'temp'),
              ),
              Container(
                // width: dTitleWidth,
                margin: EdgeInsets.only(left: 25.0),
                child: Text(
                  //"温度 : ${_temp.round()}",
                  "火力 : ",
                  style: titleTextStyle,
                  // textAlign: TextAlign.left,
                ),
              ),
              Expanded(
                // color: Colors.pinkAccent,
                child: _getCupertinoTF(name + 'power'),
              ),
            ],
          ),
          // color: Colors.indigo,
        ),
      ],
    );
  }

  _getCupertinoTF(String name) {
    TextEditingController tc;
    int maxValue = 10;
    switch (name) {
      case 'timer':
        tc = timerController;
        maxValue = 99;
        break;
      case 'steamt':
        tc = steamtController;
        maxValue = 60;
        break;
      case 'uptemp':
        tc = uptempController;
        maxValue = 380;
        break;
      case 'uppower':
        tc = uppowerController;
        maxValue = 10;
        break;
      case 'downtemp':
        tc = downtempController;
        maxValue = 380;
        break;
      case 'downpower':
        tc = downpowerController;
        maxValue = 10;
        break;
    }

    return CupertinoTextField(
      padding: const EdgeInsets.only(
        right: 10.0,
        top: 7.0,
        bottom: 7.0,
        left: 10.0,
      ),
      autofocus: name == 'timer',
      controller: tc,
      keyboardType: TextInputType.number,
      maxLength: 3,
      style: const TextStyle(
        color: Colors.redAccent,
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
      ),
      textAlign: TextAlign.right,
      //输入完成时调用
      onEditingComplete: () {
        if (num.parse(tc.text) > maxValue) {
          tc.text = maxValue.toString();
        }
      },
    );
  }

  _saveData(context) async {
    SectionTimeModel dataModel = SectionTimeModel.getEmptyObj();

    if (timerController.text.trim() != '') {
      dataModel.timer = int.parse(timerController.text) * 60;
    }
    if (steamtController.text.trim() != '') {
      dataModel.steamt = int.parse(steamtController.text);
    }
    if (uptempController.text.trim() != '') {
      dataModel.uptemp = int.parse(uptempController.text);
    }
    if (uppowerController.text.trim() != '') {
      dataModel.uppower = int.parse(uppowerController.text);
    }
    if (downtempController.text.trim() != '') {
      dataModel.downtemp = int.parse(downtempController.text);
    }
    if (downpowerController.text.trim() != '') {
      dataModel.downpower = int.parse(downpowerController.text);
    }
    if (steamtController.text.trim() != '') {
      dataModel.steamt = int.parse(steamtController.text);
    }

    dataModel.tn = tn;
    dataModel.sn = sn; // TemplateBO.tsCount;// sectionTimeModel.sn;
    dataModel.tid = tn;
    // AppObjHelper.getJsonStrFormObj(dataModel);

// json.encode(SectionTimeModel);
    // String jsonStr =
    //     SectionTimeModel.toJson(dataModel); // json.encode(SectionTimeModel);
    // print("@@@ _saveData() SectionTimeModel : $jsonStr");

    // Map<String, dynamic> param = {
    //   "phoneno": phoneController.text.trim(),
    //   "code": codeController.text.trim()
    // };
    // Map<String, dynamic> param = json.decode(jsonStr);
    Map<String, dynamic> param = {
      "Template_ID": dataModel.tn,
      "IndexNo": dataModel.sn,
      "Timer": dataModel.timer,
      "UpS": ups,
      "UpTemp": dataModel.uptemp,
      "UpPower": dataModel.uppower,
      "DownS": downs,
      "DownTemp": dataModel.downtemp,
      "DownPower": dataModel.downpower,
      "SteamT": dataModel.steamt,
      // "EditType": edittype,
    };

    // if (edittype == 0) {
    //   param['id']=sectionTimeModel.id;
    // }

    await DataHelpr.dataHandler('TimeSection/Add', param, (ret) {
// DataHelpr.resultHandler(rm, (){});
      if (ret.ret == 0) {
        AppToast.showToast("保存成功！");
        print("@@@ _saveData() ret.id : ${ret.id}");
        dataModel.id = int.parse(ret.id);

        // String spfile = TemplateBO.getSpfile(tn);
        // TemplateModel templateModel = AppPublicData.mpDataModel[spfile];
        // Widget.templateModel.lstSection.add(dataModel);
        TemplateModel templateModel = GlobalVar.lstTemplate[dataModel.tn];
        templateModel.lstSection.add(dataModel);
        // AppPublicData.removeData(spfile);
        // SharePrefHelper.removeData(TemplateBO.getSpfile());
        TemplateBO.cleanCache();

        Navigator.of(context).pop('OK');
      } else {
        AppToast.showToast("保存失败：${ret.message}", 2);
      }
    });

    // HttpCallerSrv.post('TimeSection/Add',param, GlobalVar.userInfo.tk)
    //     .then((f) {
    //   String jsonData = f;

    //   Map<String, dynamic> ret = json.decode(jsonData);
    //   HttpRetModel retmodel = HttpRetModel.fromJsonExec(ret);

    //   if (retmodel.ret == 0) {
    //     AppToast.showToast("保存成功！");
    //     Navigator.of(context).pop('OK');
    //   } else {
    //     AppToast.showToast("保存失败：${retmodel.message}", 2);
    //   }
    // }).catchError((e) {
    //   AppToast.showToast("保存失败：$e", 2);
    // }).whenComplete(() {
    //   // isRun = 0;
    // });
  }
}
