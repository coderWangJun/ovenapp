import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:ovenapp/Controls/UpDownFireUnit.dart';
import 'package:ovenapp/Models/MqttDataModel.dart';
import 'package:ovenapp/Models/UpDownFireModel.dart';
// import 'package:ovenapp/Publics/GlobalVar.dart';

import '../Publics/AppStyle.dart';

// import '../Classes/AppDialog.dart';

class AppDialog {
  static showYesNoDialog(BuildContext context, String caption, var callback) {
    showDialog<Null>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return new AlertDialog(
          title: Text(
              ""), // Icon(Icons.question_answer,size: GlobalVar.mainIconButtonSize,),
          content: Text(
            caption, //"您确定要发布此消息吗 ... ？",
            style: TextStyle(
              fontSize: 18,
              color: AppStyle.clTitle1FC,
            ),
          ),
          actions: <Widget>[
            new CupertinoButton(
              child: new Text(
                '确定',
                style: TextStyle(
                    fontSize: AppStyle.popupDialogButtonSize,
                    decoration: TextDecoration.underline,
                    color: Colors.blue),
              ),
              onPressed: () {
                callback();
                Navigator.of(context).pop();
              },
            ),
            new CupertinoButton(
              child: new Text(
                '取消',
                style: TextStyle(
                    fontSize: AppStyle.popupDialogButtonSize,
                    decoration: TextDecoration.underline,
                    color: Colors.grey),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    ).then((val) {
      // print("@@@ AppDialog.showYesNoDialog() val => " + val ?? "null");
    });
  }

  // static void showSingleListDialog(
  //     BuildContext context, String caption, List<Widget> list, var callback) {
  //   showDialog<Null>(
  //     context: context,
  //     barrierDismissible: true,
  //     builder: (BuildContext context) {
  //       return SimpleDialog(
  //         title: Text(
  //             caption), // Icon(Icons.question_answer,size: GlobalVar.mainIconButtonSize,),
  //         children: list,
  //       );
  //     },
  //   );
  //   // .then((val) {
  //   //   print("@@@ AppDialog.showYesNoDialog() val => " + val ?? "null");
  //   // }
  // }

  static showYesNoIOS(
      BuildContext context, String title, String content, var callback) {
    return showDialog<String>(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            // title: Text(title),
            content: Column(
              children: <Widget>[
                //标题
                Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.only(
                      top: 20.0, left: 20.0, right: 20.0, bottom: 5.0),
                  padding: EdgeInsets.only(bottom: 10.0),
                  height: 35.0,
                  child: Text(
                    title,
                    style: TextStyle(fontSize: 17.0, color: Colors.blueAccent),
                  ),
                  decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                            color: Colors.grey[400], width: 1.0)), //灰色的一层边框
                    // border:
                    //     Border.all(color: AppStyle.clTitleBC, width: 1.0),
                    // color: Colors.white,
                    // borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  ),
                ),

                //提示
                Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.only(
                      top: 0.0, left: 40.0, right: 20.0, bottom: 5.0),
                  padding: EdgeInsets.only(bottom: 10.0),
                  height: 50.0,
                  child: Text(
                    content,
                    style: TextStyle(fontSize: 16, color: Colors.black54),
                  ),
                  // decoration: BoxDecoration(
                  //   border: Border(
                  //       bottom: BorderSide(
                  //           color: Colors.grey[400], width: 1.0)), //灰色的一层边框
                  // ),
                ),
              ],
            ),

            actions: <Widget>[
              CupertinoDialogAction(
                child: Text('确定'),
                onPressed: () {
                  // print('yes...');
                  // callback();
                  if (callback != null)
                    callback(); //尽量不要采用这种回调的方式，以免前一page退出时返回值错位
                  Navigator.of(context).pop('OK');
                },
              ),
              CupertinoDialogAction(
                child: Text('取消'),
                onPressed: () {
                  // print('no...');
                  Navigator.of(context).pop('Cancel');
                },
              ),
            ],
          );
        });
  }

  static showConfirmIOS(BuildContext context, String title, String content) {
    showDialog<String>(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            // title: Text(title),
            content: Column(
              children: <Widget>[
                //标题
                Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.only(
                      top: 20.0, left: 20.0, right: 20.0, bottom: 5.0),
                  padding: EdgeInsets.only(bottom: 10.0),
                  height: 35.0,
                  child: Text(
                    title,
                    style: TextStyle(fontSize: 17.0, color: Colors.blueAccent),
                  ),
                  decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                            color: Colors.grey[400], width: 1.0)), //灰色的一层边框
                    // border:
                    //     Border.all(color: AppStyle.clTitleBC, width: 1.0),
                    // color: Colors.white,
                    // borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  ),
                ),

                //提示
                Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.only(
                      top: 0.0, left: 40.0, right: 20.0, bottom: 5.0),
                  padding: EdgeInsets.only(bottom: 10.0),
                  height: 50.0,
                  child: Text(
                    content,
                    style: TextStyle(fontSize: 16, color: Colors.black54),
                  ),
                  // decoration: BoxDecoration(
                  //   border: Border(
                  //       bottom: BorderSide(
                  //           color: Colors.grey[400], width: 1.0)), //灰色的一层边框
                  // ),
                ),
              ],
            ),

            actions: <Widget>[
              CupertinoDialogAction(
                child: Text('确定'),
                onPressed: () {
                  Navigator.of(context).pop('OK');
                },
              ),
              CupertinoDialogAction(
                child: Text('取消'),
                onPressed: () {
                  // print('no...');
                  Navigator.of(context).pop('Cancel');
                },
              ),
            ],
          );
        });
  }

  static showInfoIOS(BuildContext context, String title, String content,
      [Color clcontent = Colors.black87]) {
    showDialog<Null>(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(
                  top: 10.0, left: 0.0, right: 0.0, bottom: 10.0),
              padding: EdgeInsets.only(top: 5.0, bottom: 5.0, left: 0.0),
              height: 50.0,
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.black87,
                  fontWeight: FontWeight.normal,
                ),
              ),
              decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(
                        color: Colors.grey[400], width: 1.0)), //灰色的一层边框
                // border:
                //     Border.all(color: AppStyle.clTitleBC, width: 1.0),
                // color: Colors.white,
                // borderRadius: BorderRadius.all(Radius.circular(5.0)),
              ),
            ),
            content: Container(
              // color: Colors.cyanAccent,
              height: 50.0,
              width: double.infinity,
              margin: EdgeInsets.only(
                left: 25.0,
                bottom: 15.0,
              ),
              alignment: Alignment.centerLeft,
              // color: Colors.orangeAccent,
              child: Text(
                content,
                style: TextStyle(
                  color: clcontent,
                  fontSize: 17.0,
                ),
                softWrap: true,
                maxLines: 5,
                overflow: TextOverflow.visible,
                textAlign: TextAlign.left,
              ),
            ),
            actions: <Widget>[
              CupertinoDialogAction(
                child: Text('确定'),
                onPressed: () {
                  // print('yes...');
                  // callback();
                  Navigator.of(context).pop();
                },
              ),
              // CupertinoDialogAction(
              //   child: Text('取消'),
              //   onPressed: () {
              //     // print('no...');
              //     Navigator.of(context).pop();
              //   },
              // ),
            ],
          );
        });
  }

  static showTextFieldIOS(
      BuildContext context, String title, String hinttext, var callback) {
    final TextEditingController textController =
        TextEditingController(text: "");

    showCupertinoDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Container(
              height: 50.0,
              margin: EdgeInsets.only(left: 20.0),
              alignment: Alignment.centerLeft,
              child: Text(
                title,
                style: AppStyle.fsCupertinoDialogActionStyle,
                // style: TextStyle(
                //     fontSize: 16.5,
                //     color: Colors.blueAccent,
                //     fontWeight: FontWeight.normal),
              ),
            ),
            content: Container(
              height: 50.0,
              margin: EdgeInsets.only(
                  left: 40.0, right: 20.0, top: 0.0, bottom: 15.0),
              alignment: Alignment.centerLeft,
              child: CupertinoTextField(
                padding: EdgeInsets.only(
                  left: 10.0,
                  top: 10.0,
                  bottom: 10.0,
                ),
                controller: textController,
                autofocus: true,
                // keyboardType: TextInputType.number,
                // maxLength: 3,
                style: TextStyle(color: Colors.black45, fontSize: 16.5),
                //输入完成时调用
                // onEditingComplete: () {
                //   if (num.parse(tempController.text) > 600) {
                //     tempController.text = '600';
                //   }
                // },
              ),
            ),
            // Card(
            //   elevation: 0.0,
            //   child: Column(
            //     children: <Widget>[
            //       // Text(content),
            //       TextField(
            //         controller: deviceController,
            //         decoration: InputDecoration(
            //           hintText: hinttext,
            //           // filled: true,
            //           fillColor: Colors.grey.shade50,
            //           // border: null,
            //           border: OutlineInputBorder(
            //             borderRadius: BorderRadius.circular(0),
            //             borderSide: BorderSide.none,
            //           ),
            //           // TextDecoration.none,
            //         ),
            //         style: TextStyle(
            //           fontSize: 16,
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            actions: <Widget>[
              CupertinoDialogAction(
                onPressed: () {
                  callback(textController.text);
                  Navigator.pop(context);
                },
                child: Text('确定'),
              ),
              CupertinoDialogAction(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('取消'),
              ),
            ],
          );
        });
  }

  static showItemSelect2IOS(BuildContext context, var callback) {
    showCupertinoDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            // barrierDismissible:false,
            // title: Text(
            //   title,
            //   style: TextStyle(fontSize: 18, color: AppStyle.mainTitle2Color),
            // ),
            content: Column(
              children: <Widget>[
                // Text(content),
                GestureDetector(
                  child: Container(
                    height: 60.0,
                    alignment: Alignment.center,
                    // color: Colors.orangeAccent,
                    child: Text(
                      "从相册选择",
                      style: TextStyle(color: Colors.blue[400], fontSize: 18.0),
                    ),
                  ),
                  onTap: () {
                    callback('menu');
                    Navigator.pop(context);
                  },
                ),
                Container(
                  height: 1,
                  color: Colors.grey[400],
                ),
                GestureDetector(
                  child: Container(
                    height: 60.0,
                    alignment: Alignment.center,
                    // color: Colors.orangeAccent,
                    child: Text(
                      "用相机拍照",
                      style: TextStyle(color: Colors.blue[400], fontSize: 18.0),
                    ),
                  ),
                  onTap: () {
                    callback('camera');
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          );
        });
  }

  static showSelectTextItemIOS(
      BuildContext context, List<String> lstItem, var callback) {
    showCupertinoDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            // barrierDismissible:false,
            content: Column(
              children: _getTextItem(context, lstItem, 60.0, callback),
            ),
          );
        });
  }

  static showSelectedListViewIOS(BuildContext context, String title,
      List<String> lstItem, double centerHeight, var callback) {
    showCupertinoDialog(
        // barrierDismissible:false,
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(
                  top: 20.0, left: 0.0, right: 0.0, bottom: 0.0),
              padding: EdgeInsets.only(bottom: 10.0, left: 30.0),
              height: 35.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    title,
                    style: TextStyle(fontSize: 16, color: Colors.black87),
                  ),
                ],
              ),
              decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(
                        color: Colors.grey[400], width: 1.0)), //灰色的一层边框
              ),
            ),
            content: Container(
              // color: Colors.orangeAccent,
              alignment: Alignment.topLeft,
              padding: EdgeInsets.all(0.0),
              margin: EdgeInsets.only(
                  top: 0.0, left: 20.0, right: 20.0, bottom: 0.0),
              height: centerHeight,
              width: double.maxFinite,
              child: ListView(
                padding: EdgeInsets.all(0.0),
                children: _getTextItem(context, lstItem, 50.0, callback),
              ),
            ),
            actions: <Widget>[
              CupertinoDialogAction(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('取消'),
              ),
            ],
          );
        });
  }

  static _getTextItem(context, lstItem, lineHeight, callback) {
    var _lst = <Widget>[];
    for (int i = 0; i < lstItem.length; i++) {
      var g = GestureDetector(
        child: Container(
          // color: Colors.cyanAccent,
          height: lineHeight,
          width: double.infinity,
          alignment: Alignment.center,
          // color: Colors.orangeAccent,
          child: Text(
            lstItem[i],
            style: TextStyle(color: Colors.blue[400], fontSize: 18.0),
          ),
        ),
        onTap: () {
          if (callback != null) callback(i.toString());
          // Navigator.pop(context);
          Navigator.of(context).pop(i.toString());
        },
      );
      _lst.add(g);
      if (i != (lstItem.length - 1)) {
        _lst.add(Container(
          height: 1,
          color: Colors.grey[400],
        ));
      }
    }
    return _lst;
  }

  static showUpDownFireParamIOS(
      BuildContext context, UpDownFireModel udm, var callback) {
    showCupertinoDialog(
        context: context,
        builder: (context) {
          // int state=0;
          double _power = udm.power;
          // double _temp = udm.temp;
          bool _isOpen = udm.isOpen == 1;
          // int _index = udm.index;
          double dTitleWidth = 80.0;
          double dSubLineLeftEdig = 40.0;
          double dSubLineHeight = 45.0;
          Color clTitleFC = Colors.grey;

          final TextEditingController tempController = TextEditingController();
// text: udm.temp.round().toString()
          print("@@@ showUpDownFireParamIOS() udm : $udm");
          // print(
          //     "@@@ showUpDownFireParamIOS(_power : $_power,_temp : $_temp,_isOpen : $_isOpen)");
          return CupertinoAlertDialog(
            // title: Text(
            //   title,
            //   style: TextStyle(fontSize: 18, color: AppStyle.mainTitle2Color),
            // ),
            // content: Container(
            //   height: 200.0,
            //   child: UpDownFireUnit(upDownFireModel: udm),
            // ),
            content: StatefulBuilder(builder: (context, StateSetter setState) {
              return
                  // SingleChildScrollView(
                  //   child:
                  Column(
                children: <Widget>[
                  //标题
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.only(
                        top: 20.0, left: 20.0, right: 20.0, bottom: 5.0),
                    padding: EdgeInsets.only(bottom: 10.0),
                    height: 35.0,
                    child: Text(
                      (udm.index == 0 ? '上' : '下') + '火参数设置：',
                      style: TextStyle(fontSize: 16, color: Colors.black87),
                    ),
                    decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              color: Colors.grey[400], width: 1.0)), //灰色的一层边框
                      // border:
                      //     Border.all(color: AppStyle.clTitleBC, width: 1.0),
                      // color: Colors.white,
                      // borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    ),
                  ),

                  //开关 温度
                  Container(
                    margin: EdgeInsets.only(
                        top: 0.0, left: dSubLineLeftEdig, right: 20.0),
                    height: dSubLineHeight,
                    alignment: Alignment.center,
                    // color: Colors.orangeAccent, Cupertino
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        SizedBox(
                          width: dTitleWidth,
                          child: Text(
                            "开关：",
                            style: TextStyle(fontSize: 16, color: clTitleFC),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        CupertinoSwitch(
                            value: _isOpen,
                            onChanged: (v) {
                              setState(() {
                                _isOpen = v;
                              });
                            }),
                      ],
                    ),
                    // color: Colors.limeAccent,
                  ),

                  //温度
                  Container(
                    height: dSubLineHeight,
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(
                        top: 0.0, left: dSubLineLeftEdig, right: 20.0),
                    child: Row(
                      children: <Widget>[
                        SizedBox(
                          width: dTitleWidth,
                          child: Text(
                            //"温度 : ${_temp.round()}",
                            "温度 : ",
                            style: TextStyle(
                              fontSize: 16,
                              color: clTitleFC,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Expanded(
                          // color: Colors.pinkAccent,
                          child: CupertinoTextField(
                            padding: EdgeInsets.only(
                              left: 10.0,
                              top: 10.0,
                              bottom: 10.0,
                            ),
                            autofocus: true,
                            controller: tempController,
                            keyboardType: TextInputType.number,
                            maxLength: 3,
                            style: TextStyle(
                                color: Colors.redAccent, fontSize: 18.0),
                            //输入完成时调用
                            onEditingComplete: () {
                              if (num.parse(tempController.text) > 380) {
                                tempController.text = '380';
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                    // color: Colors.indigo,
                  ),

                  //火力
                  Container(
                    height: dSubLineHeight,
                    alignment: Alignment.center,
                    // color: Colors.orangeAccent,
                    margin: EdgeInsets.only(
                        top: 0.0,
                        left: dSubLineLeftEdig,
                        right: 20.0,
                        bottom: 5.0),
                    child: Row(
                      children: <Widget>[
                        SizedBox(
                          width: dTitleWidth,
                          child: Text(
                            "火力 : ${_power.round()}",
                            style: TextStyle(
                              fontSize: 16,
                              color: clTitleFC,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Expanded(
                          child: CupertinoSlider(
                              // label: '$_power',
                              value: _power,
                              // divisions: 1,
                              max: 10,
                              min: 0,
                              onChanged: (v) {
                                setState(() {
                                  _power = v;
                                });
                              }),
                        ),
                      ],
                    ),
                    // color: Colors.purpleAccent,
                  ),
                  // Expanded(child: Text("")),
                  //完毕 ***
                ],
                // ),
              );

              //  _getFireLine(setState,_power),
            }),

            actions: <Widget>[
              CupertinoDialogAction(
                onPressed: () {
                  // Map<String, dynamic> map = {
                  //   "temp": _temp,
                  //   "power": _power,
                  //   "isopen": _isOpen,
                  // };
                  UpDownFireModel um = UpDownFireModel(
                      index: udm.index,
                      temp: tempController.text.trim() == ''
                          ? udm.temp
                          : double.parse(tempController.text),
                      power: _power.round() + 0.0,
                      isOpen: _isOpen ? 1 : 0);
                  callback(um);
                  Navigator.pop(context);
                },
                child: Text('确定'),
              ),
              CupertinoDialogAction(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('取消'),
              ),
            ],
          );
        });
  }

  static showSteamTimeIOS(BuildContext context, int sec, var callback) {
    showCupertinoDialog(
        context: context,
        builder: (context) {
          // int state=0;
          int _second = sec;

          double dSubLineLeftEdig = 40.0;
          double dSubLineHeight = 45.0;

          print("@@@ showSteamTimeIOS() _second : $_second");
          // print(
          //     "@@@ showUpDownFireParamIOS(_power : $_power,_temp : $_temp,_isOpen : $_isOpen)");
          return CupertinoAlertDialog(
            content: StatefulBuilder(builder: (context, StateSetter setState) {
              return Column(
                children: <Widget>[
                  //标题
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.only(
                        top: 20.0, left: 20.0, right: 20.0, bottom: 5.0),
                    padding: EdgeInsets.only(bottom: 10.0),
                    height: 35.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          '蒸汽时间设置：',
                          style: TextStyle(fontSize: 16, color: Colors.black87),
                        ),
                        Text(
                          _second.toString(),
                          style:
                              TextStyle(fontSize: 20, color: Colors.redAccent),
                        ),
                        Text(
                          '秒',
                          style: TextStyle(fontSize: 16, color: Colors.black87),
                        ),
                      ],
                    ),
                    decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              color: Colors.grey[400], width: 1.0)), //灰色的一层边框
                      // border:
                      //     Border.all(color: AppStyle.clTitleBC, width: 1.0),
                      // color: Colors.white,
                      // borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    ),
                  ),

                  //秒
                  Container(
                    height: dSubLineHeight,
                    alignment: Alignment.center,
                    // color: Colors.orangeAccent,
                    margin: EdgeInsets.only(
                        top: 0.0,
                        left: dSubLineLeftEdig,
                        right: 20.0,
                        bottom: 5.0),
                    child: CupertinoSlider(
                        // label: '$_power',
                        value: _second.toDouble(),
                        // divisions: 1,
                        max: 60,
                        min: 0,
                        onChanged: (v) {
                          setState(() {
                            _second = v.toInt();
                          });
                        }),
                  ),
                ],
                // ),
              );
              //  _getFireLine(setState,_power),
            }),
            actions: <Widget>[
              CupertinoDialogAction(
                onPressed: () {
                  callback(_second);
                  Navigator.pop(context);
                },
                child: Text('确定'),
              ),
              CupertinoDialogAction(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('取消'),
              ),
            ],
          );
        });
  }

  static showSteamPramIOS(
      BuildContext context, int isopen, int temp, var callback) {
    showCupertinoDialog(
        context: context,
        builder: (context) {
          // int state=0;
          // double _temp = temp.toDouble();
          // double _temp = udm.temp;
          bool _isOpen = isopen == 1;
          // int _index = udm.index;
          double dTitleWidth = 80.0;
          double dSubLineLeftEdig = 40.0;
          double dSubLineHeight = 45.0;
          Color clTitleFC = Colors.grey;

          final TextEditingController tempController =
              TextEditingController(text: temp.toString());

          print("@@@ showSteamIOS() temp : $temp / isopen : $isopen");
          // print(
          //     "@@@ showUpDownFireParamIOS(_power : $_power,_temp : $_temp,_isOpen : $_isOpen)");
          return CupertinoAlertDialog(
            // title: Text(
            //   title,
            //   style: TextStyle(fontSize: 18, color: AppStyle.mainTitle2Color),
            // ),
            // content: Container(
            //   height: 200.0,
            //   child: UpDownFireUnit(upDownFireModel: udm),
            // ),
            content: StatefulBuilder(builder: (context, StateSetter setState) {
              return
                  // SingleChildScrollView(
                  //   child:
                  Column(
                children: <Widget>[
                  //标题
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.only(
                        top: 20.0, left: 20.0, right: 20.0, bottom: 5.0),
                    padding: EdgeInsets.only(bottom: 10.0),
                    height: 35.0,
                    child: Text(
                      '蒸汽温度参数设置：',
                      style: TextStyle(fontSize: 16, color: Colors.black87),
                    ),
                    decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              color: Colors.grey[400], width: 1.0)), //灰色的一层边框
                      // border:
                      //     Border.all(color: AppStyle.clTitleBC, width: 1.0),
                      // color: Colors.white,
                      // borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    ),
                  ),

                  //开关 温度
                  Container(
                    margin: EdgeInsets.only(
                        top: 0.0, left: dSubLineLeftEdig, right: 20.0),
                    height: dSubLineHeight,
                    alignment: Alignment.center,
                    // color: Colors.orangeAccent, Cupertino
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        SizedBox(
                          width: dTitleWidth,
                          child: Text(
                            "开关：",
                            style: TextStyle(fontSize: 16, color: clTitleFC),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        CupertinoSwitch(
                            value: _isOpen,
                            onChanged: (v) {
                              setState(() {
                                _isOpen = v;
                              });
                            }),
                      ],
                    ),
                    // color: Colors.limeAccent,
                  ),

                  //温度
                  Container(
                    height: dSubLineHeight,
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(
                      top: 0.0,
                      left: dSubLineLeftEdig,
                      right: 20.0,
                      bottom: 20.0,
                    ),
                    child: Row(
                      children: <Widget>[
                        SizedBox(
                          width: dTitleWidth,
                          child: Text(
                            //"温度 : ${_temp.round()}",
                            "温度 : ",
                            style: TextStyle(
                              fontSize: 16,
                              color: clTitleFC,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Expanded(
                          // color: Colors.pinkAccent,
                          child: CupertinoTextField(
                            padding: EdgeInsets.only(
                              left: 10.0,
                              top: 10.0,
                              bottom: 10.0,
                            ),
                            controller: tempController,
                            keyboardType: TextInputType.number,
                            maxLength: 3,
                            style: TextStyle(
                                color: Colors.redAccent, fontSize: 18.0),
                            //输入完成时调用
                            onEditingComplete: () {
                              if (num.parse(tempController.text) > 600) {
                                tempController.text = '600';
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                    // color: Colors.indigo,
                  ),
                ],
                // ),
              );

              //  _getFireLine(setState,_power),
            }),

            actions: <Widget>[
              CupertinoDialogAction(
                onPressed: () {
                  // Map<String, dynamic> map = {
                  //   "temp": _temp,
                  //   "power": _power,
                  //   "isopen": _isOpen,
                  // };
                  UpDownFireModel um = UpDownFireModel(
                      index: 0,
                      temp: double.parse(tempController.text),
                      power: 0.0,
                      isOpen: _isOpen ? 1 : 0);
                  callback(um);
                  Navigator.pop(context);
                },
                child: Text('确定'),
              ),
              CupertinoDialogAction(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('取消'),
              ),
            ],
          );
        });
  }

  static showClockTimeIOS(BuildContext context, int sec, var callback) {
    showCupertinoDialog(
        context: context,
        builder: (context) {
          // int state=0;
          int _second = sec % 60;
          int _minute = sec.toDouble() ~/ 60;
          double dSubLineLeftEdig = 20.0;
          double dSubLineHeight = 45.0;
          Color clTitleFC = Colors.grey;
          // String minute="";
          // String second = "";
          print("@@@ showClockTimeIOS() sec : $sec");
          // print(
          //     "@@@ showUpDownFireParamIOS(_power : $_power,_temp : $_temp,_isOpen : $_isOpen)");
          return CupertinoAlertDialog(
            content: StatefulBuilder(builder: (context, StateSetter setState) {
              return Column(
                children: <Widget>[
                  //标题
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.only(
                        top: 20.0, left: 20.0, right: 20.0, bottom: 5.0),
                    padding: EdgeInsets.only(bottom: 10.0),
                    height: 35.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          '倒计时间设置：',
                          style: TextStyle(fontSize: 16, color: Colors.black87),
                        ),
                        Text(
                          _getHMS(_minute, _second),
                          style:
                              TextStyle(fontSize: 20, color: Colors.redAccent),
                        ),
                      ],
                    ),
                    decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              color: Colors.grey[400], width: 1.0)), //灰色的一层边框
                      // border:
                      //     Border.all(color: AppStyle.clTitleBC, width: 1.0),
                      // color: Colors.white,
                      // borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    ),
                  ),

                  //分钟 <=99
                  Container(
                    height: dSubLineHeight,
                    alignment: Alignment.center,
                    // color: Colors.orangeAccent,
                    margin: EdgeInsets.only(
                        top: 0.0,
                        left: dSubLineLeftEdig,
                        right: 20.0,
                        bottom: 5.0),
                    child: CupertinoSlider(
                        // label: '$_power',
                        value: _minute.toDouble(),
                        // divisions: 1,
                        max: 99,
                        min: 0,
                        onChanged: (v) {
                          setState(() {
                            _minute = v.toInt();
                          });
                        }),
                  ),

                  //秒
                  Container(
                    height: dSubLineHeight,
                    alignment: Alignment.center,
                    // color: Colors.orangeAccent,
                    margin: EdgeInsets.only(
                        top: 0.0,
                        left: dSubLineLeftEdig,
                        right: 20.0,
                        bottom: 5.0),
                    child: CupertinoSlider(
                        // label: '$_power',
                        value: _second.toDouble(),
                        // divisions: 1,
                        max: 60,
                        min: 0,
                        onChanged: (v) {
                          setState(() {
                            _second = v.toInt();
                          });
                        }),
                  ),
                ],
                // ),
              );
              //  _getFireLine(setState,_power),
            }),
            actions: <Widget>[
              CupertinoDialogAction(
                onPressed: () {
                  callback(_minute * 60 + _second);
                  Navigator.pop(context);
                },
                child: Text('确定'),
              ),
              CupertinoDialogAction(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('取消'),
              ),
            ],
          );
        });
  }

  static _getHMS(int min, int sec) {
    String hs = '';
    String ms = '';
    String ss = '';
    if (min > 59) {
      hs = '01:';
      ms = (min - 60).toString().padLeft(2, '0') + ':';
    } else {
      hs = '';
      ms = min.toString().padLeft(2, '0') + ':';
    }
// double m=mm-60;
    ss = sec.toString().padLeft(2, '0');
    return hs + ms + ss;
  }

  static showCenterTempIOS(BuildContext context, int temp, var callback) {
    showCupertinoDialog(
        context: context,
        builder: (context) {
          // int state=0;
          // double _temp = temp.toDouble();

          double dTitleWidth = 80.0;
          double dSubLineLeftEdig = 40.0;
          double dSubLineHeight = 45.0;
          Color clTitleFC = Colors.grey;

          final TextEditingController tempController = TextEditingController();
// text: temp.toString()
          print("@@@ showCenterTempIOS() temp : $temp");

          return CupertinoAlertDialog(
            content: StatefulBuilder(builder: (context, StateSetter setState) {
              return
                  // SingleChildScrollView(
                  //   child:
                  Column(
                children: <Widget>[
                  //标题
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.only(
                        top: 20.0, left: 20.0, right: 20.0, bottom: 5.0),
                    padding: EdgeInsets.only(bottom: 10.0),
                    height: 35.0,
                    child: Text(
                      '设置中心温度：',
                      style: TextStyle(fontSize: 16, color: Colors.black87),
                    ),
                    decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              color: Colors.grey[400], width: 1.0)), //灰色的一层边框
                      // border:
                      //     Border.all(color: AppStyle.clTitleBC, width: 1.0),
                      // color: Colors.white,
                      // borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    ),
                  ),

                  //温度
                  Container(
                    height: dSubLineHeight,
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(
                        top: 20.0,
                        left: dSubLineLeftEdig,
                        right: 20.0,
                        bottom: 20.0),
                    child: Row(
                      children: <Widget>[
                        SizedBox(
                          width: dTitleWidth,
                          child: Text(
                            //"温度 : ${_temp.round()}",
                            "温度 : ",
                            style: TextStyle(
                              fontSize: 16,
                              color: clTitleFC,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Expanded(
                          // color: Colors.pinkAccent,
                          child: CupertinoTextField(
                            padding: EdgeInsets.only(
                              left: 10.0,
                              top: 10.0,
                              bottom: 10.0,
                            ),
                            autofocus: true,
                            controller: tempController,
                            keyboardType: TextInputType.number,
                            maxLength: 3,
                            style: TextStyle(
                                color: Colors.redAccent, fontSize: 18.0),
                            //输入完成时调用
                            onEditingComplete: () {
                              if (num.parse(tempController.text) > 380) {
                                tempController.text = '380';
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                    // color: Colors.indigo,
                  ),
                ],
                // ),
              );
              //  _getFireLine(setState,_power),
            }),
            actions: <Widget>[
              CupertinoDialogAction(
                onPressed: () {
                  if (tempController.text.trim() != '')
                    callback(tempController.text);
                  Navigator.pop(context);
                },
                child: Text('确定'),
              ),
              CupertinoDialogAction(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('取消'),
              ),
            ],
          );
        });
  }

  static showRunConfirmIOS(
      BuildContext context, int state, MqttDataModel mm, var callback) {
    showCupertinoDialog(
        context: context,
        builder: (context) {
          print("@@@ showRunConfirmIOS() MqttDataModel : $mm");
          return CupertinoAlertDialog(
            content: StatefulBuilder(builder: (context, StateSetter setState) {
              return Column(
                children: _getRunParamList(state, mm),
              );
            }),
            actions: <Widget>[
              CupertinoDialogAction(
                onPressed: () {
                  callback();
                  Navigator.pop(context);
                },
                child: Text('确定'),
              ),
              CupertinoDialogAction(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('取消'),
              ),
            ],
          );
        });
  }

  static _getRunParamList(int state, MqttDataModel mm) {
    List<Widget> _lst = List<Widget>();
    _lst.add(Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0, bottom: 5.0),
      padding: EdgeInsets.only(bottom: 10.0),
      height: 30.0,
      child: Text(
        '运行参数：',
        style: TextStyle(fontSize: 16, color: Colors.black87),
      ),
      decoration: BoxDecoration(
        border: Border(
            bottom: BorderSide(color: Colors.grey[400], width: 1.0)), //灰色的一层边框
        // border:
        //     Border.all(color: AppStyle.clTitleBC, width: 1.0),
        // color: Colors.white,
        // borderRadius: BorderRadius.all(Radius.circular(5.0)),
      ),
    ));

    List<String> _lstParam = [
      'state',
      'up',
      'down',
      'steam',
      state == 2 ? 'timer' : 'center',
      // 'timer',
      'water'
    ];
    for (int i = 0; i < _lstParam.length; i++) {
      _lst.add(_getRunParam(state, _lstParam[i], mm));
    }
    _lst.add(SizedBox(
      height: 5.0,
    ));
    return _lst;
  }

  static _getRunParam(int state, String name, MqttDataModel mm) {
    double dSubLineLeftEdig = 40.0;
    double dSubLineHeight = 30.0;
    Color clTitleFC = Colors.grey;
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(
          top: 0.0, left: dSubLineLeftEdig, right: 20.0, bottom: 0.0),
      // padding: EdgeInsets.only(bottom: 10.0),
      height: dSubLineHeight,
      child: Text(
        _getRuntParamText(state, name, mm),
        style: TextStyle(
          fontSize: 16,
          color: clTitleFC,
        ),
        textAlign: TextAlign.left,
      ),
      decoration: BoxDecoration(
          // border: Border(
          //     bottom: BorderSide(
          //         color: Colors.grey[400], width: 0.0)), //灰色的一层边框
          // border:
          //     Border.all(color: AppStyle.clTitleBC, width: 1.0),
          // color: Colors.white,
          // borderRadius: BorderRadius.all(Radius.circular(5.0)),
          ),
    );
  }

  static _getRuntParamText(int state, String name, MqttDataModel mm) {
    String sret = "";
    switch (name) {
      case "state":
        sret = "模式：" + (state == 2 ? '倒计时' : '中心温度');
        break;
      case "up":
        sret = '上火：  ' +
            (mm.ups == 1 ? '开' : '关') +
            ' / ${mm.up[0]} ℃ / 火力：${mm.up[2]}';
        break;
      case "down":
        sret = '下火：  ' +
            (mm.downs == 1 ? '开' : '关') +
            ' / ${mm.down[0]} ℃ / 火力：${mm.down[2]}';
        break;
      case "center":
        sret = '中心温度：  ${mm.center[0]} ℃';
        break;
      case "steam":
        sret = '蒸汽：  ' + (mm.steams == 1 ? '开' : '关') + ' / ${mm.steam[0]}℃';
        break;
      case "timer":
        sret = '倒计时时长：  ${mm.timer[0]} 秒';
        break;
      case "water":
        sret = '进水：  ' + (mm.water == 1 ? '开' : '关') + ' / 时长：${mm.steamt} 秒';
        break;
    }
    return sret;
  }

  static showUpDownFireUnitIOS(
      BuildContext context, UpDownFireModel udm, var callback) {
    showCupertinoDialog(
        context: context,
        builder: (context) {
          print("@@@ showUpDownFireParamIOS() udm : $udm");
          return CupertinoAlertDialog(
            content: Container(
              height: 200.0,
              child: UpDownFireUnit(upDownFireModel: udm),
            ),
            actions: <Widget>[
              CupertinoDialogAction(
                onPressed: () {
                  callback(udm);
                  Navigator.pop(context);
                },
                child: Text('确定'),
              ),
              CupertinoDialogAction(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('取消'),
              ),
            ],
          );
        });
  }

  void showMyDialogWithStateBuilder(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          bool selected = false;
          return new AlertDialog(
            title: new Text("StatefulBuilder"),
            content:
                new StatefulBuilder(builder: (context, StateSetter setState) {
              return Container(
                child: new CheckboxListTile(
                    title: new Text("选项"),
                    value: selected,
                    onChanged: (bool) {
                      setState(() {
                        selected = !selected;
                      });
                    }),
              );
            }),
          );
        });
  }
}
// static showUpDownFireParam(context, power, temp, isOpen, var callback) {
//   showDialog(
//       context: context,
//       builder: (context) {
//         // int state=0;
//         double _power = power;
//         double _temp = temp;
//         bool _isOpen = isOpen;
//         print(
//             "@@@ showUpDownFireParamIOS(_power : $_power,_temp : $_temp,_isOpen : $_isOpen)");
//         return AlertDialog(
//           // title: Text(
//           //   title,
//           //   style: TextStyle(fontSize: 18, color: AppStyle.mainTitle2Color),
//           // ),
//           content: Scaffold(
//             appBar: null,
//             body: Column(
//               children: <Widget>[
//                 Text("上火参数设置："),
//                 Container(
//                   height: 60.0,
//                   alignment: Alignment.center,
//                   // color: Colors.orangeAccent, Cupertino
//                   child: Switch(
//                       value: _isOpen,
//                       onChanged: (v) {
//                         _isOpen = v;
//                       }),
//                 ),
//                 Container(
//                   height: 60.0,
//                   alignment: Alignment.center,
//                   // color: Colors.orangeAccent,
//                   child: Slider(
//                       label: '$_power',
//                       value: _power,
//                       divisions: 1,
//                       max: 10,
//                       min: 0,
//                       onChanged: (v) {
//                         _power = v;
//                       }),
//                 ),
//                 Container(
//                   height: 60.0,
//                   alignment: Alignment.center,
//                   // color: Colors.orangeAccent,
//                   child: Slider(
//                       label: '$_temp',
//                       value: _temp,
//                       divisions: 1,
//                       max: 999,
//                       min: 0,
//                       onChanged: (v) {
//                         _temp = v;
//                       }),
//                 ),
//                 Row(
//                   children: <Widget>[
//                     FlatButton(
//                       onPressed: () {
//                         Map<String, dynamic> map = {
//                           "temp": _temp,
//                           "power": _power,
//                           "isopen": _isOpen,
//                         };
//                         callback(map);
//                         Navigator.pop(context);
//                       },
//                       child: Text('确定'),
//                     ),
//                     FlatButton(
//                       onPressed: () {
//                         Navigator.pop(context);
//                       },
//                       child: Text('取消'),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         );
//       });
// }

// bool _withTree = false;
// showDialog<bool>(
//   context: context,
//   builder: (context) {
//     return AlertDialog(
//       title: Text("提示"),
//       content: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         mainAxisSize: MainAxisSize.min,
//         children: <Widget>[
//           Text("您确定要删除当前文件吗?"),
//           Row(
//             children: <Widget>[
//               Text("同时删除子目录？"),
//               Checkbox(
//                 // 依然使用Checkbox组件
//                 value: _withTree,
//                 onChanged: (bool value) {
//                   // 此时context为对话框UI的根Element，我们
//                   // 直接将对话框UI对应的Element标记为dirty
//                   (context as Element).markNeedsBuild();
//                   _withTree = !_withTree;
//                 },
//               ),
//             ],
//           ),
//         ],
//       ),
//       actions: <Widget>[
//         FlatButton(
//           child: Text("取消"),
//           onPressed: () => Navigator.of(context).pop(),
//         ),
//         FlatButton(
//           child: Text("删除"),
//           onPressed: () {
//             // 执行删除操作
//             Navigator.of(context).pop(_withTree);
//           },
//         ),
//       ],
//     );
//   },
// );
