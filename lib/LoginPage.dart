import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ovenapp/BusinessObjects/AppBO.dart';
import 'package:ovenapp/BusinessObjects/DialogBO.dart';
import 'package:ovenapp/Classes/AppDialog.dart';
import 'package:ovenapp/Classes/AppToast.dart';
// import 'package:ovenapp/Classes/SharePrefHelper.dart';
// import 'package:ovenapp/Controls/AppWidget.dart';
import 'package:ovenapp/Publics/AppStyle.dart';
import 'package:ovenapp/Services/EventBusSrv.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:dio/dio.dart';
// import 'dart:io';
import 'dart:convert';

import 'Publics/GlobalVar.dart';
// import 'Publics/SharePrefHelper.dart';
import 'Services/HttpCallerSrv.dart';
import 'Models/HttpRetModel.dart';
import 'Models/UserModel.dart';

// import 'Pages/MainTabPage.dart';
// import 'Pages/MyPage.dart';
// import 'Pages/RegisterPage.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    super.initState();
    print("@@@ => LoginPage.initState() ... ");
    dSpaceHeight = AppStyle.screenSize.height -
        60.0 -
        dLogoHeight -
        2 * dTextFieldLineHeight -
        dButtonHeight -
        50.0 -
        10.0 -
        15.0 -
        30.0 -
        22.0;
    print("@@@ dSpaceHeight : $dSpaceHeight");
    dSpaceHeight = 80.0;
  }

  @override
  void dispose() {
    super.dispose();
    print("@@@ LoginPage.dispose() ...");
  }

//TextField 样式
// border：增加一个边框，
// hintText：未输入文字时，输入框中的提示文字，
// prefixIcon：输入框内侧左面的控件，
// labelText：一个提示文字。输入框获取焦点/输入框有内容 会移动到左上角，否则在输入框内，labelTex的位置.
// suffixIcon: 输入框内侧右面的图标.
// icon : 输入框左侧添加个图标
// 利用SafeArea可以让内容显示在安全的可见区域。
//利用SingleChildScrollView可以避免弹出键盘的时候，出现overFlow的现象。

  final TextEditingController phoneController = TextEditingController(text: "");
  final TextEditingController passController = TextEditingController(text: "");
  final TextEditingController codeController = TextEditingController(text: "");

  final double dTitleWidth = 60.0;
  final double dLogoHeight = 96.0;
  final double dTextFieldLineHeight = 45.0;
  final double dButtonHeight = 45.0;
  double dSpaceHeight = 30.0;
  int checkState = 0; //0密码 1验证码
  int workState = 0; //0登录 1注册
  int isShowPwd = 0;
  int codeState = 0; //0可发送，1已发送
  DateTime dtSend;
  String lastPhone = "";
  int isRun = 0;

  @override
  Widget build(BuildContext context) {
    print("@@@ LoginPage.build() ...");
    return Scaffold(
      //类似于 Android 中的 android:windowSoftInputMode=”adjustResize”，控制界面内容 body 是否重新布局来避免底部被覆盖了，比如当键盘显示的时候，重新布局避免被键盘盖住内容。默认值为 true。
      // resizeToAvoidBottomPadding:false,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(left: 40.0, right: 40.0),
            // child: IntrinsicHeight(
            child: Column(
              children: <Widget>[
                _getLogo(),
                _getTitle(),
                _getLoginLine(),
                //_getPwdLine(),
                checkState == 0 ? _getPwdLine() : _getCCodeLine(),

                _getLoginButton(context),
                _getRegisterLine(context),

                // Expanded(
                // flex: 1,
                Container(
                  height: dSpaceHeight,
                  child: const Text(""),
                ),
                // ),

                // _getLoginType(),
                _getWebSite(),
              ],
            ),
            // ),
          ),
        ),
      ),
    );
  }

  _getLogo() {
    return Container(
      margin: EdgeInsets.only(top: 60.0),
      height: dLogoHeight,
      child: Image.asset(
        'images/oven.png',
        fit: BoxFit.cover,
        height: dLogoHeight,
        width: dLogoHeight,
      ),
    );
  }

  _getTitle() {
    return Container(
      margin: EdgeInsets.only(
        top: 20.0,
      ),
      height: 30.0,
      child: Text(
        "烘焙之光", //●杭州聪锋 · 智能烤炉
        style: TextStyle(fontSize: 18.0, color: Colors.grey[400]),
      ),
    );
  }

  _getLoginLine() {
    return Container(
      height: dTextFieldLineHeight,
      margin: EdgeInsets.only(top: 15.0),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey[300], width: 1.0),
        ),
      ),
      // child: Row(
      //   children: <Widget>[
      //     Container(
      //       width: dTitleWidth,
      //       alignment: Alignment.centerLeft,
      //       child: Text(
      //         "+86",
      //         style:
      //             TextStyle(color: AppStyle.articalTitleColor, fontSize: 20.0),
      //       ),
      //     ),
      //     Expanded(
      child: TextField(
        textAlign: TextAlign.left,
        controller: phoneController,
        // scrollPadding: EdgeInsets.all(0.0),
        // keyboardType: TextInputType.number,
        style: TextStyle(
          color: AppStyle.clTitle1FC,
          fontSize: 20.0,
          height: 1.3,
        ),
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.phone,
            color: AppStyle.cpCloseColor,
          ),
          // prefixText: "帐号",
          prefixStyle: TextStyle(
            fontSize: 18,
          ),
          // helperText: "Yesterday Once More ...",color: Colors.red,
          contentPadding: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
          //helperText: '帐号/手机号',
          // border: OutlineInputBorder(),
          hintText: '手机号',
          hintStyle: TextStyle(
            fontSize: 16.0,
            color: AppStyle.lightColor,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(0),
            borderSide: BorderSide.none,
          ),
          // border: UnderlineInputBorder(
          //   borderSide: BorderSide(
          //     color: Colors.red, //边框颜色为绿色
          //     width: 5, //宽度为5
          //   ),
          // ),
          // filled: true,
        ),
        keyboardType: TextInputType.phone,
      ),
      //   ),
      // ],
      // ),
    );
  }

  _getPwdLine() {
    return Container(
      height: dTextFieldLineHeight,
      margin: EdgeInsets.only(top: 15.0),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey[300], width: 1.0),
        ),
      ),
      // child: Row(
      //   children: <Widget>[
      //     Container(
      //       width: dTitleWidth,
      //       alignment: Alignment.centerLeft,
      //       child: Text(
      //         "密码",
      //         style:
      //             TextStyle(color: AppStyle.articalTitleColor, fontSize: 18.0),
      //       ),
      //     ),
      //     Expanded(
      child: TextField(
        // textAlign: TextAlign.center,
        controller: passController,
        // keyboardType: TextInputType.number,
        style: TextStyle(
          color: AppStyle.clTitle1FC,
          fontSize: 20.0,
        ),
        maxLines: 1,
        // maxLength: 20,
        maxLengthEnforced: true,
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.vpn_key,
            color: AppStyle.cpCloseColor,
          ),
          contentPadding: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
          // hasFloatingPlaceholder:false,
          //helperText: '帐号/手机号',
          hintText: '登录密码',
          hintStyle: TextStyle(
            fontSize: 16.0,
            color: AppStyle.lightColor,
          ),
          suffixIcon: Container(
            // width: 24.0,
            child: IconButton(
                icon: Icon(Icons.remove_red_eye),
                color: isShowPwd == 0 ? Colors.grey[300] : AppStyle.mainColor,
                onPressed: () {
                  setState(() {
                    if (isShowPwd == 0)
                      isShowPwd = 1;
                    else
                      isShowPwd = 0;
                  });
                }),
          ),
          // border: Border(bottom: ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(0),
            borderSide: BorderSide.none,
          ),
          // focusedBorder: UnderlineInputBorder(
          //   borderSide: BorderSide(color: Colors.red),
          // ),
        ),
        obscureText: isShowPwd == 0,
      ),
      //     ),
      //   ],
      // ),
    );
  }

  _getCCodeLine() {
    return Container(
      height: dTextFieldLineHeight,
      margin: EdgeInsets.only(top: 15.0),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey[300], width: 1.0),
        ),
      ),
      // child: Row(
      //   children: <Widget>[
      //     Container(
      //       width: dTitleWidth,
      //       alignment: Alignment.centerLeft,
      //       child: Text(
      //         "验证码",
      //         style:
      //             TextStyle(color: AppStyle.articalTitleColor, fontSize: 18.0),
      //       ),
      //     ),
      //     Expanded(
      child: new TextField(
        // textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        controller: codeController,
        // keyboardType: TextInputType.number,
        style: TextStyle(
          color: AppStyle.clTitle1FC,
          fontSize: 20.0,
        ),
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.touch_app,
            color: AppStyle.cpCloseColor,
            // size: 28,
          ),
          contentPadding: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
          //helperText: '帐号/手机号',
          hintText: '输入验证码',
          hintStyle: TextStyle(
            fontSize: 16.0,
            color: AppStyle.lightColor,
          ),
          suffixIcon: Container(
            // width: 24.0,
            child: FlatButton(
                child: Text(
                  _getCodeContent(),
                  style: TextStyle(
                    color: codeState == 0
                        ? AppStyle.mainColor
                        : AppStyle.lightColor,
                    fontSize: 17,
                  ),
                ),
                // color: Colors.grey,
                onPressed: () {
                  print("@@@ 发送验证码 ... ");
                  _sendCode();
                }),
          ),
          // border: Border(bottom: ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(0),
            borderSide: BorderSide.none,
          ),
        ),
        // obscureText: true,
      ),
      // ),
      // Container(
      //   width: 90.0,
      //   child: FlatButton(
      //     onPressed: () {},
      //     child: _getCodeContent(),
      //   ),
      //     )
      //   ],
      // ),
    );
  }

  _getCodeContent() {
    return "发送验证码";
  }

  _getLoginButton(context) {
    return Container(
      margin: EdgeInsets.only(top: 30.0),
      width: double.infinity,
      height: dButtonHeight,
      child: RaisedButton(
        // borderSide: new BorderSide(
        //   color: Theme.of(context).primaryColor,
        // ),

        color: workState == 0 ? AppStyle.mainColor : Colors.blueAccent,
        child: Text(
          workState == 0 ? '登 录' : '注 册',
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
        onPressed: () async {
          // _login(context);
          // print("@@@ loginid : ${phoneController.text}");
          print("@@@ checkState : $checkState");

          if (workState == 0) {
            // checkState = 1;
            DialogBO.showWaittingCircle(context, '正在登录 ...');
            _login();
          } else
            _registerUser();

          // setState(() {
          //   if (workState == 0) {
          //     workState = 1;
          //     checkState = 1;
          //   } else {
          //     workState = 0;
          //   }
          // });
        },
      ),
    );
  }

  _getRegisterLine(context) {
    return Container(
      // margin: EdgeInsets.only(top:10.0),
      height: 50.0,
      // child:new Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        verticalDirection: VerticalDirection.up,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          // new Text('aaa',style: TextStyle(color: lightColor,),),
          // new Expanded(flex: 1,child: null,),
          // new Expanded(
          FlatButton(
            // color: Colors.orange,
            child: Text(
              workState == 0 ? (checkState == 0 ? '手机短信验证登录' : '密码登录') : '',
              style: TextStyle(
                color: AppStyle.lightColor,
              ),
            ),
            onPressed: () {
              // _isLogined();
              setState(() {
                if (checkState == 0)
                  checkState = 1;
                // _login();
                else
                  checkState = 0;
                // _registerUser();
              });
            },
          ),
          // ),
          // new Expanded(
          FlatButton(
            // color: Colors.orange,
            child: Text(
              workState == 0 ? '注册' : '登录',
              style: TextStyle(
                color: AppStyle.lightColor,
              ),
            ),
            onPressed: () {
              // Navigator.push(
              //     context,
              //     new MaterialPageRoute(
              //         builder: (context) => new RegisterPage()));
              setState(() {
                if (workState == 0) {
                  workState = 1;
                  checkState = 1;
                } else
                  workState = 0;
              });
            },
          ),
          // ),
          // new Expanded(flex: 1,child: null,),
          // new Text('bbb',style: TextStyle(),),
        ],
      ),
    );
  }

  // _getLoginType() {
  //   return Container(
  //     child: Text("ACE"),
  //   );
  // }

  _getWebSite() {
    return Container(
      height: 22.0,
      child: GestureDetector(
        onTap: () {
          print("ap => Click My");
        },
        child: Text(
          "©cfdzkj.com",
          style: TextStyle(
            color: AppStyle.lightColor,
          ),
        ),
      ),
    );
  }

  _login() async {
    // print("@@@ _login()");
    String pn = phoneController.text.trim();
    String pwd = '';
    String code = '';
    if (pn.length != 11) {
      AppToast.showToast("手机号格式错误，请重新输入！");
      return;
    }

    var param; // = {"lid": pn, "pwd": pwd, "cc": code};

    if (checkState == 1) {
      code = codeController.text.trim();
      if (code.length != 4) {
        AppToast.showToast("请输入验证码！");
        return;
      }
      param = {"lid": pn, "cc": code};
    }

    if (checkState == 0) {
      pwd = passController.text.trim();
      if (pwd == "") {
        AppToast.showToast("请输入密码！");
        return;
      }
      param = {"lid": pn, "pwd": pwd};
    }

    // print("@@@ _registerUser phoneno : $pn / pwd : $pwd / code : $code");

    isRun = 1;
    HttpCallerSrv.get("Login", param).then((f) {
      // print("@@@ Login f => " + f);
      Map<String, dynamic> ret = json.decode(f);
      HttpRetModel rm = HttpRetModel.fromJson(ret, UserModel());
      print(rm ?? "rm is null");
      // eventBus.fire(DialogCloseEvent());
      if (rm.ret == 0) {
        UserModel um = rm.data[0] as UserModel;
        //  print("@@@ LoginPage._login() um : ${um.tojson()}");
        _initData(um);
      } else {
        AppToast.showToast("登录失败：${rm.message}");
      }
    }).catchError((e) {
      // eventBus.fire(DialogCloseEvent());
      AppToast.showToast("登录错误！：$e");
    }).whenComplete(() {
      eventBus.fire(DialogCloseEvent());
      isRun = 0;
    });
    // UserModel rm = UserModel.fromJson(ret);

/*
 GlobalVar.userInfo = new UserModel(
      id: 1,
      tk: "a8311085888888128c0bb661a4b0aca5",
      name: "WaterCloud",
      companyid: 1,
      userlevel: 0,
      loginid: "17811869989",
      avatar: "https://www.cfdzkj.com:812/webimages/avatar.png",
      sn: "13617790");
*/
  }

  _initData(data) async {
    await AppBO.clearUserData();
    GlobalVar.userInfo = data;
    // print("@@@ LoginPage._initData() data : ${data.tojson()}");
    // GlobalVar.userInfo.loginid = phoneController.text.trim();
    await AppBO.initUserData();

    eventBus.fire(LoginEvent());

    Navigator.of(context).pop('OK');
  }

  _sendCode() {
    if (phoneController.text.trim().length != 11) {
      AppToast.showToast("手机号格式错误，请重新输入！");
      return;
    }
    if (codeState == 1 && phoneController.text.trim() == lastPhone) {
      AppToast.showToast("验证码已发送，请在5分钟内使用！");
      return;
    }
    var param = {"pn": phoneController.text.trim()};
    HttpCallerSrv.get("VCode", param).then((f) {
      String jsonData = f;
      // print("@@@ code ret => \r" + jsonData);
      Map map = json.decode(jsonData);
      if (map != null && map["ret"].toString() == "0") {
        AppToast.showToast("验证码已发送，请在5分钟内使用！");
        // setState(() {});
        lastPhone = phoneController.text.trim();
        setState(() {
          codeState = 1;
        });
        Timer(Duration(seconds: 300), () {
          setState(() {
            codeState = 0;
          });
        });
      } else {
        AppToast.showToast("获取验证码错误：${map["message"]}，请重新发送！");
      }
    }).catchError((e) {
      AppToast.showToast("获取验证码错误：$e，请重新发送！");
    }).whenComplete(() {
      isRun = 0;
    });
  }

  // _isLogined() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   int islogin = prefs.getInt('islogin') ?? 0;
  //   print("islogin => $islogin");
  // }
  _registerUser() async {
    if (phoneController.text.trim().length != 11) {
      AppToast.showToast("手机号格式错误，请重新输入！");
      return;
    }
    if (codeController.text.trim() == "") {
      AppToast.showToast("请输入有效验证码！");
      return;
    }

    print(
        "@@@ _registerUser phoneno : ${phoneController.text.trim()} / code : ${codeController.text.trim()}");

    Map<String, dynamic> param = {
      "phoneno": phoneController.text.trim(),
      "code": codeController.text.trim()
    };

    HttpCallerSrv.post("Register", param).then((f) {
      String jsonData = f;
      // print("@@@ code ret => \r" + jsonData);
      Map<String, dynamic> ret = json.decode(jsonData);
      HttpRetModel retmodel = HttpRetModel.fromJsonExec(ret);
      //  print("@@@ DevicePage.retmodel => ");
      // print(retmodel);
      if (retmodel.ret == 0) {
        AppDialog.showInfoIOS(
            context, '提示', "注册成功，密码为手机号后面6位数字，请在第一次登录成功后更改，感谢您的使用！");

        // SharePrefHelper.removeData(GlobalVar.spdevice);
        setState(() {
          codeController.text = '';
          workState = 0;
          checkState = 0;
        });
      } else {
        AppToast.showToast("注册失败：${retmodel.message}", 2);
      }
    }).catchError((e) {
      AppToast.showToast("注册失败：$e", 2);
    }).whenComplete(() {
      isRun = 0;
    });
    // print("@@@ DevicePage._addDevice() data => " + sret);
  }
}
