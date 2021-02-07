import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:ovenapp/Classes/AppToast.dart';
import 'package:ovenapp/Classes/MediaPlayer.dart';
import 'package:ovenapp/Controls/AppWidget.dart';
import 'package:ovenapp/Publics/GlobalVar.dart';
import 'package:ovenapp/Services/EventBusSrv.dart';

class DialogBO {
  static showSteamTimeIOS(BuildContext context, int sec, var callback) {
    showCupertinoDialog(
        context: context,
        builder: (context) {
          // int state=0;
          int _second = sec;

          double dSubLineLeftEdig = 40.0;
          double dSubLineHeight = 45.0;

          final TextEditingController steamtController =
              TextEditingController();

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
                          '蒸汽时间设置(秒)：',
                          style: TextStyle(fontSize: 16, color: Colors.black87),
                        ),
                        // Text(
                        //   _second.toString(),
                        //   style:
                        //       TextStyle(fontSize: 20, color: Colors.redAccent),
                        // ),
                        // Text(
                        //   '秒',
                        //   style: TextStyle(fontSize: 16, color: Colors.black87),
                        // ),
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
                    child: CupertinoTextField(
                      padding: EdgeInsets.only(
                        left: 10.0,
                        top: 10.0,
                        bottom: 10.0,
                      ),
                      autofocus: true,
                      controller: steamtController,
                      keyboardType: TextInputType.number,
                      maxLength: 2,
                      style: TextStyle(color: Colors.redAccent, fontSize: 18.0),
                      //输入完成时调用
                      onEditingComplete: () {
                        if (num.parse(steamtController.text) > 60) {
                          steamtController.text = '60';
                        }
                      },
                    ),
                    // CupertinoSlider(
                    //     // label: '$_power',
                    //     value: _second.toDouble(),
                    //     // divisions: 1,
                    //     max: 60,
                    //     min: 0,
                    //     onChanged: (v) {
                    //       setState(() {
                    //         _second = v.toInt();
                    //       });
                    //     }),
                  ),
                ],
                // ),
              );
              //  _getFireLine(setState,_power),
            }),
            actions: <Widget>[
              CupertinoDialogAction(
                onPressed: () {
                  callback(steamtController.text);
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

  static showClockTimeIOS(BuildContext context, var callback) {
    showCupertinoDialog(
        context: context,
        builder: (context) {
          // int state=0;int sec,
          // int _second = sec % 60;
          // int _minute = sec.toDouble() ~/ 60;
          double dSubLineLeftEdig = 20.0;
          double dSubLineHeight = 45.0;
          // Color clTitleFC = Colors.grey;
          // String minute="";
          // String second = "";
          double dTitleWidth = 80.0;
          Color clTitleFC = Colors.grey;

          final TextEditingController secondController =
              TextEditingController();

          final TextEditingController minutesController =
              TextEditingController();
          // print("@@@ showClockTimeIOS() sec : $sec");
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
                        // Text(
                        //   _getHMS(_minute, _second),
                        //   style:
                        //       TextStyle(fontSize: 20, color: Colors.redAccent),
                        // ),
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
                    margin: EdgeInsets.only(
                        top: 8.0,
                        left: dSubLineLeftEdig,
                        right: 20.0,
                        bottom: 8.0),
                    child: Row(
                      children: <Widget>[
                        SizedBox(
                          width: dTitleWidth,
                          child: Text(
                            //"温度 : ${_temp.round()}",
                            "分钟 : ",
                            style: TextStyle(
                              fontSize: 16,
                              color: clTitleFC,
                            ),
                            textAlign: TextAlign.center,
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
                            controller: minutesController,
                            keyboardType: TextInputType.number,
                            maxLength: 2,
                            style: TextStyle(
                                color: Colors.redAccent, fontSize: 18.0),
                            //输入完成时调用
                            onEditingComplete: () {
                              if (num.parse(minutesController.text) > 99) {
                                minutesController.text = '99';
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                    // color: Colors.indigo,
                  ),

                  //秒
                  Container(
                    height: dSubLineHeight,
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(
                        top: 0.0,
                        left: dSubLineLeftEdig,
                        right: 20.0,
                        bottom: 10.0),
                    child: Row(
                      children: <Widget>[
                        SizedBox(
                          width: dTitleWidth,
                          child: Text(
                            //"温度 : ${_temp.round()}",
                            "秒 : ",
                            style: TextStyle(
                              fontSize: 16,
                              color: clTitleFC,
                            ),
                            textAlign: TextAlign.center,
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
                            controller: secondController,
                            keyboardType: TextInputType.number,
                            maxLength: 2,
                            style: TextStyle(
                                color: Colors.redAccent, fontSize: 18.0),
                            //输入完成时调用
                            onEditingComplete: () {
                              if (num.parse(secondController.text) > 60) {
                                secondController.text = '60';
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
                  int _minute = 0;
                  if (minutesController.text != '')
                    _minute = int.parse(minutesController.text);
                  int _second = 0;
                  if (secondController.text != '')
                    _second = int.parse(secondController.text);
                  int sec = _minute * 60 + _second;
                  if (sec == 0) {
                    AppToast.showToast('请输入时间！');
                    return;
                  }
                  callback(sec);
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

  static showWifiIOS(
      BuildContext context, String ssid, String pwd, var callback) {
    showCupertinoDialog(
        context: context,
        builder: (context) {
          // int state=0;int sec,
          // int _second = sec % 60;
          // int _minute = sec.toDouble() ~/ 60;
          double dSubLineLeftEdig = 20.0;
          double dSubLineHeight = 45.0;
          // Color clTitleFC = Colors.grey;
          // String minute="";
          // String second = "";
          double dTitleWidth = 50.0;
          Color clTitleFC = Colors.grey;

          final TextEditingController ssidController =
              TextEditingController(text: ssid);

          final TextEditingController pwdController =
              TextEditingController(text: pwd);
          // print("@@@ showClockTimeIOS() sec : $sec");
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
                          'Wifi 设置：',
                          style: TextStyle(fontSize: 16, color: Colors.black87),
                        ),
                        // Text(
                        //   _getHMS(_minute, _second),
                        //   style:
                        //       TextStyle(fontSize: 20, color: Colors.redAccent),
                        // ),
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

                  //SSID
                  Container(
                    height: dSubLineHeight,
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(
                        top: 8.0,
                        left: dSubLineLeftEdig,
                        right: 20.0,
                        bottom: 8.0),
                    child: Row(
                      children: <Widget>[
                        SizedBox(
                          width: dTitleWidth,
                          child: Text(
                            //"温度 : ${_temp.round()}",
                            "SSID : ",
                            style: TextStyle(
                              fontSize: 16,
                              color: clTitleFC,
                            ),
                            textAlign: TextAlign.center,
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
                            controller: ssidController,
                            // keyboardType: TextInputType.number,
                            // maxLength: 2,
                            style: TextStyle(
                                color: Colors.redAccent, fontSize: 18.0),
                            //输入完成时调用
                            // onEditingComplete: () {
                            //   if (num.parse(minutesController.text) > 99) {
                            //     minutesController.text = '99';
                            //   }
                            // },
                          ),
                        ),
                      ],
                    ),
                    // color: Colors.indigo,
                  ),

                  //密码
                  Container(
                    height: dSubLineHeight,
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(
                        top: 0.0,
                        left: dSubLineLeftEdig,
                        right: 20.0,
                        bottom: 10.0),
                    child: Row(
                      children: <Widget>[
                        SizedBox(
                          width: dTitleWidth,
                          child: Text(
                            //"温度 : ${_temp.round()}",
                            "密码 : ",
                            style: TextStyle(
                              fontSize: 16,
                              color: clTitleFC,
                            ),
                            textAlign: TextAlign.center,
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
                            controller: pwdController,
                            // keyboardType: TextInputType.number,
                            // maxLength: 2,
                            style: TextStyle(
                                color: Colors.redAccent, fontSize: 18.0),
                            //输入完成时调用
                            // onEditingComplete: () {
                            //   if (num.parse(secondController.text) > 60) {
                            //     secondController.text = '60';
                            //   }
                            // },
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
                  if (ssidController.text.trim() == '') {
                    AppToast.showToast('SSID不能为空，请输入！');
                    return;
                  }
                  callback(
                      ssidController.text.trim(), pwdController.text.trim());
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

  static showWaitting(BuildContext context) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            content: StatefulBuilder(builder: (context, StateSetter setState) {
              // return Text('data');
              return Container(
                alignment: Alignment.center,
                // margin: EdgeInsets.only(
                //     top: 20.0, left: 20.0, right: 20.0, bottom: 5.0),
                // padding: EdgeInsets.only(bottom: 10.0),
                height: 64.0,
                width: 64.0,
                decoration: BoxDecoration(
                  // border: Border(
                  //     bottom: BorderSide(
                  //         color: Colors.grey[400], width: 1.0)), //灰色的一层边框
                  // border:
                  //     Border.all(color: AppStyle.clTitleBC, width: 1.0),
                  // color: Colors.white,
                  color: Colors.lightBlue,
                  // borderRadius: BorderRadius.all(Radius.circular(5.0)),
                ),
                child: Text(
                  '正在设置，请耐心等待 ... ',
                  style: TextStyle(fontSize: 18.0, color: Colors.white),
                ),
              );
            }),
          );
        });
  }

//   static showCircleWaitting(BuildContext context,
//       [int sect =5,String title = '正在查询 ...', String proc = '进度 ']) {
// //         var _onDialogCloseEvent=eventBus.on<DialogCloseEvent>().listen((event) {
// //  Navigator.of(context).pop();
// //         });
//     var progress = 0.0;
//     StateSetter stateSetter;
//     Timer timer;
//     Timer.periodic(Duration(milliseconds: 100), (t) {
//       //计时器模拟进度增加 if(mounted){mounted &&
//       timer = t;

//       progress += 0.1;

//       if (stateSetter != null) {
//         stateSetter(() {});
//       }
//       if (progress >= sect) {
//         timer.cancel();
//         stateSetter = null;
//         Navigator.of(context).pop();
//       }
//     });

//     var statefulBuilder = StatefulBuilder(
//       builder: (ctx, state) {
//         stateSetter = state;
//         return Center(
//           child: SizedBox(
//             width: 150,
//             height: 150,
//             child: Card(
//               elevation: 24.0,
//               color: Colors.blue.withAlpha(240),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: <Widget>[
//                   CircularProgressIndicator(
//                     backgroundColor: Colors.grey,
//                     valueColor: AlwaysStoppedAnimation(Colors.white),
//                     value: null, //progress,
//                   ),
//                   SizedBox(
//                     height: 20.0,
//                   ),
//                   Text(
//                     // "Loading...",
//                     title,
//                     style: TextStyle(color: Colors.white),
//                   ),
//                   SizedBox(
//                     height: 5,
//                   ),
//                   Text(
//                     proc + ' ${(progress * 20).toInt()}' + '%',
//                     // "done ${((progress - 0.1) * 100).toStringAsFixed(1)}%",
//                     style: TextStyle(color: Colors.white),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//     showDialog(
//         barrierDismissible: false,
//         context: context,
//         builder: (ctx) => statefulBuilder).whenComplete(() {
//       timer.cancel();
//       stateSetter = null;
//     });
//   }
  static String waitHint = '正在连接设备 ...';
//计时、等待消息后退出
  static showCircleWait(BuildContext context,
      [int sec = 10, String title = '正在查询 ...', String proc = '进度 ']) {
    var _onDialogCloseEvent;
    var progress = 0.0;
    double dD = 1.0; //sec.toDouble() / 100.0;

    print("@@@ showCircleWait(sec : $sec) dD : $dD");
    StateSetter stateSetter;
    Timer timer;
    Timer.periodic(Duration(milliseconds: 1000), (t) {
      //计时器模拟进度增加 if(mounted){mounted &&
      timer = t;

      progress += dD; // sec.toDouble()/100.0;

      if (stateSetter != null) {
        stateSetter(() {});
      }

      if (progress >= sec.toDouble()) {
        timer.cancel();
        stateSetter = null;
        if (sec < 22)
          AppToast.showToast('连接主板失败，请确保主板处于出厂模式状态后再试...！');
        else
          AppToast.showToast('请检查设备wifi设置是否成功，如没成功请重新设置。');
        Navigator.of(context).pop();
      }
    });

    var statefulBuilder = StatefulBuilder(
      builder: (ctx, state) {
        stateSetter = state;
        return Center(
          child: SizedBox(
            width: 150,
            height: 150,
            child: Card(
              elevation: 24.0,
              color: Colors.blue.withAlpha(240),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircularProgressIndicator(
                    backgroundColor: Colors.grey,
                    valueColor: AlwaysStoppedAnimation(Colors.white),
                    value: null, //progress,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    // "Loading...",
                    // title,
                    waitHint,
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    // proc + ' ${(progress * sec).toInt()}' + '%',
                    proc + ' ${((progress / sec.toDouble()) * 100).toInt()}%',
                    // "done ${((progress - 0.1) * 100).toStringAsFixed(1)}%",
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );

    final bool isCancel = true;
    showDialog(
        // barrierDismissible: false,
        context: context,
        builder: (ctx) {
          _onDialogCloseEvent = eventBus.on<DialogCloseEvent>().listen((event) {
            print("@@@ DialogBO.showCircleWait() DialogCloseEvent beep ...");
            Navigator.of(context).pop();
          });
          return WillPopScope(
            onWillPop: () async {
              return isCancel;
            }, // 拦截Android返回键
            child: statefulBuilder,
          );
        }).whenComplete(() {
      _onDialogCloseEvent.cancel();
      stateSetter = null;
      if (timer != null) {
        timer.cancel();
        timer = null;
      }
    });
  }

  //等待消息后退出
  static showWaittingCircle(BuildContext context, [String title = '正在查询 ...']) {
    var _onDialogCloseEvent;

    var statefulBuilder = StatefulBuilder(
      builder: (ctx, state) {
        return Center(
          child: SizedBox(
            width: 150,
            height: 150,
            child: Card(
              elevation: 24.0,
              color: Colors.blue.withAlpha(240),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircularProgressIndicator(
                    backgroundColor: Colors.grey,
                    valueColor: AlwaysStoppedAnimation(Colors.white),
                    value: null, //progress,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    // "Loading...",
                    title,
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );

    final bool isCancel = true;
    showDialog(
        // barrierDismissible: false,
        context: context,
        builder: (ctx) {
          _onDialogCloseEvent = eventBus.on<DialogCloseEvent>().listen((event) {
            print(
                "@@@ DialogBO.showWaittingCircle() DialogCloseEvent beep ...");
            Navigator.of(context).pop();
          });
          return WillPopScope(
            onWillPop: () async {
              return isCancel;
            }, // 拦截Android返回键
            child: statefulBuilder,
          );
        }).whenComplete(() {
      _onDialogCloseEvent.cancel();
    });
  }

  static showAudioWarn(BuildContext context,
      [int sec = 30, String title = '报警 ...']) {
    var _onWarnCloseEvent;
    int progress = 0;
    // double dD = 1.0; //sec.toDouble() / 100.0;

    print("@@@ showAudioWarn(sec : $sec)");
    // StateSetter stateSetter;
    Timer timer;
    Timer.periodic(Duration(seconds: 1), (t) {
      //计时器模拟进度增加 if(mounted){mounted &&
      timer = t;

      progress++; // sec.toDouble()/100.0;

      // if (stateSetter != null) {
      //   stateSetter(() {});
      // }
      if (progress >= sec) {
        t.cancel();
        // stateSetter = null;
        Navigator.of(context).pop();
      }
    });

    var mainWidget = GestureDetector(
      child: Center(
        child: SizedBox(
          width: 150,
          height: 150,
          child: Card(
            elevation: 24.0,
            color: Colors.redAccent, // Colors.blue.withAlpha(240),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SpinKitHourGlass(
                  color: Colors.white, //.redAccent,
                ),
                // HourGlass(),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  // "Loading...",
                  title,
                  style: TextStyle(color: Colors.white, fontSize: 18.0),
                ),
                SizedBox(
                  height: 5,
                ),
              ],
            ),
          ),
        ),
      ),
      onTap: () {
        // stateSetter = null;
        // GlobalVar.closeWarnAudio();
        Navigator.of(context).pop();
      },
    );

    final bool isCancel = true;
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (ctx) {
          _onWarnCloseEvent = eventBus.on<WarnCloseEvent>().listen((event) {
            print("@@@ DialogBO.showAudioWarn() WarnCloseEvent beep ...");
            Navigator.of(context).pop();
          });
          return WillPopScope(
            onWillPop: () async {
              return isCancel;
            }, // 拦截Android返回键
            child: mainWidget,
          );
        }).whenComplete(() {
      timer.cancel();
      // MediaPlayer.isloop = 0;
      _onWarnCloseEvent.cancel();
      GlobalVar.closeWarnAudio();
      // stateSetter = null;
    });
  }

  static showAudioWarn1(BuildContext context,
      [int sec = 30, String title = '报警 ...']) {
    var _onWarnCloseEvent;
    int progress = 0;
    double dD = 1.0; //sec.toDouble() / 100.0;

    print("@@@ showAudioWarn(sec : $sec)");
    // StateSetter stateSetter;
    Timer timer;
    Timer.periodic(Duration(seconds: 1), (t) {
      //计时器模拟进度增加 if(mounted){mounted &&
      timer = t;

      progress++; // sec.toDouble()/100.0;

      // if (stateSetter != null) {
      //   stateSetter(() {});
      // }
      if (progress >= sec) {
        t.cancel();
        // stateSetter = null;
        Navigator.of(context).pop();
      }
    });

    var mainWidget = GestureDetector(
      child: Center(
        child: SizedBox(
          width: 180.0,
          height: 180.0,
          child: Card(
            elevation: 24.0,
            color: Colors.redAccent, // Colors.blue.withAlpha(240),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  // width: AppStyle.screenSize.width / 2 - dL,
                  width: 120.0,
                  height: 120.0,
                  // margin: EdgeInsets.only(
                  //     left: 5.0, top: dL, bottom: dL, right: 5.0),
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: Colors.grey[100], width: 1.0), //灰色的一层边框
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  ),
                  child: ConstrainedBox(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5.0),
                      child: AppWidget.getCachImage('ring.gif'),
                    ),
                    constraints: BoxConstraints.expand(),
                  ),
                ),
                // HourGlass(),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  // "Loading...",
                  title,
                  style: TextStyle(color: Colors.white, fontSize: 18.0),
                ),
                SizedBox(
                  height: 5,
                ),
              ],
            ),
          ),
        ),
      ),
      onTap: () {
        // stateSetter = null;
        GlobalVar.closeWarnAudio();
        // Navigator.of(context).pop();
      },
    );

    final bool isCancel = true;
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (ctx) {
          _onWarnCloseEvent = eventBus.on<WarnCloseEvent>().listen((event) {
            print("@@@ DialogBO.showAudioWarn() WarnCloseEvent beep ...");
            Navigator.of(context).pop();
          });
          return WillPopScope(
            onWillPop: () async {
              return isCancel;
            }, // 拦截Android返回键
            child: mainWidget,
          );
        }).whenComplete(() {
      timer.cancel();
      MediaPlayer.isloop = 0;
      _onWarnCloseEvent.cancel();
      // stateSetter = null;
    });
  }
//     static _getHMS(int min, int sec) {
//     String hs = '';
//     String ms = '';
//     String ss = '';
//     if (min > 59) {
//       hs = '01:';
//       ms = (min - 60).toString().padLeft(2, '0') + ':';
//     } else {
//       hs = '';
//       ms = min.toString().padLeft(2, '0') + ':';
//     }
// // double m=mm-60;
//     ss = sec.toString().padLeft(2, '0');
//     return hs + ms + ss;
//   }

//接受进度值、等待消息后退出
  static showCircleRunning(BuildContext context, [String title = '正在运行 ...']) {
    var _onRunningEvent;
    String text = title;
    StateSetter stateSetter;

    var statefulBuilder = StatefulBuilder(
      builder: (ctx, state) {
        stateSetter = state;
        return Center(
          child: SizedBox(
            width: 150,
            height: 130,
            child: Card(
              elevation: 24.0,
              color: Colors.blue.withAlpha(240),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircularProgressIndicator(
                    backgroundColor: Colors.grey,
                    valueColor: AlwaysStoppedAnimation(Colors.white),
                    value: null, //progress,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    // "Loading...",
                    text,
                    style: TextStyle(color: Colors.white, fontSize: 17.0),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );

    final bool isCancel = true;
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (ctx) {
          _onRunningEvent = eventBus.on<RunningEvent>().listen((event) {
            if (event.text == '100')
              Navigator.of(context).pop();
            else {
              if (stateSetter != null) {
                stateSetter(() {
                  text = event.text;
                });
              }
            }
          });
          return WillPopScope(
            onWillPop: () async {
              return isCancel;
            }, // 拦截Android返回键
            child: statefulBuilder,
          );
        }).whenComplete(() {
      _onRunningEvent.cancel();
      stateSetter = null;
    });
  }
}
