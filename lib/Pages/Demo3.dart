// import 'package:flutter/cupertino.dart';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ovenapp/BusinessObjects/AppBO.dart';
import 'package:ovenapp/BusinessObjects/TemplateBO.dart';
import 'package:ovenapp/Classes/ApkHelper.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:cached_network_image/cached_network_image.dart';

// import 'package:ovenapp/Classes/AppDialog.dart';
import 'package:ovenapp/Classes/AppToast.dart';
import 'package:ovenapp/Classes/FileLoadHelper.dart';
import 'package:ovenapp/Classes/SharePrefHelper.dart';
import 'package:ovenapp/Controls/AppWidget.dart';
// import 'package:ovenapp/IntroSlidePage.dart';
import 'package:ovenapp/Models/HttpRetModel.dart';
// import 'package:ovenapp/Pages/FlutterDownloaderPage.dart';
// import 'package:ovenapp/Pages/IntroSwiperPage.dart';
import 'package:ovenapp/Pages/TemplateListPage.dart';
import 'package:ovenapp/Publics/AppObjHelper.dart';

// import 'package:ovenapp/Classes/AppDialog.dart';
// import 'package:ovenapp/Models/UpDownFireModel.dart';
import 'package:ovenapp/Publics/AppStyle.dart';
import 'package:ovenapp/Publics/GlobalVar.dart';
// import 'package:ovenapp/Services/HttpCallerSrv.dart';

// class MyPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(

//     );
//   }
// }
class MyPage extends StatefulWidget {
  @override
  _MyPageState createState() => new _MyPageState();
}

class _MyPageState extends State<MyPage> {
  // int _counter = 0;
  // final StreamController<int> _streamController = StreamController<int>();

  @override
  void initState() {
    super.initState();
    print("@@@ => MyPage.initState() ... ");
  }

  @override
  void dispose() {
    super.dispose();
    // _streamController.close();
    print("@@@ MyPage.dispose() ...");
  }

  @override
  Widget build(BuildContext context) {
    print("@@@ => MyPage.build() ... " +
        (GlobalVar.userInfo == null
            ? 'GlobalVar is null'
            : GlobalVar.userInfo.toString()));
    // print(GlobalVar.webimageurl + 'wm.jpg');
    return Scaffold(
      //  appBar: AppBar(title: Text('Stream version of the Counter App')),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: _getContentList(),
          ),
        ),
      ),
    );
  }

  _getHeaderWidget() {
    return Card(
      // color: Colors.red, //Card 背景颜色 为了便于识别，设置了红色 child 设置不全部沾满时可呈现
      // color: Colors.transparent,
      elevation: 2.0, //传入double值，控制投影效果
      margin: EdgeInsets.only(bottom: 8.0),
      shape: RoundedRectangleBorder(
        // borderRadius: BorderRadius.all(Radius.circular(20.0)),   //设定 Card 的倒角大小
        borderRadius: BorderRadius.only(
          //设定 Card 的每个角的倒角大小
          topLeft: Radius.zero, //Radius.circular(20.0),
          topRight: Radius.zero,
          bottomLeft: Radius.zero, //Radius.circular(10.0),
          bottomRight: Radius.zero, //Radius.circular(10.0),
        ),
      ),

      clipBehavior: Clip.antiAlias, //对Widget截取的行为，比如这里 Clip.antiAlias 指抗锯齿

      child: Column(
        children: <Widget>[
          //设置
          SizedBox(
            height: 20.0,
            child: Container(
              alignment: Alignment.topRight,
              // margin: EdgeInsets.only(bottom: 35.0),
              // color: Colors.brown,
              // height: 100.0,
              child: IconButton(
                color: Colors.grey[400],
                icon: Icon(Icons.settings),
                onPressed: () {
                  _setParam();
                },
              ),
            ),
          ),

          //头像、帐号
          Row(
            children: <Widget>[
              GestureDetector(
                child: Container(
                  height: 80.0,
                  width: 80.0,
                  // color: Colors.purpleAccent,
                  margin: EdgeInsets.only(
                      left: 20.0, top: 5.0, right: 20.0, bottom: 5.0),
                  // width: 80.0,
                  alignment: Alignment.center,
                  child: AppWidget.getCircleAvatar(
                      GlobalVar.userInfo == null
                          ? 'header.png'
                          : GlobalVar.userInfo.avatar,
                      80.0),
                ),
                onTap: () {
                  _setAvatar();
                },
              ),
              //名称、
              Expanded(
                child: GestureDetector(
                  // child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        // width: 120.0,
                        alignment: Alignment.bottomLeft,
                        // color: Colors.brown,
                        height: 40.0,
                        child: Text(
                          GlobalVar.userInfo == null
                              ? "点击登录"
                              : GlobalVar.userInfo.name,
                          style: TextStyle(
                              color: AppStyle.clTitle1FC, fontSize: 22.0),
                        ),
                      ),

                      // 帐号
                      Container(
                        // width: 120.0,
                        alignment: Alignment.centerLeft,
                        // color: Colors.purpleAccent,
                        height: 30.0,
                        child: Text(
                          'version : ${ApkHelper.version}',
                          // GlobalVar.userInfo == null
                          //     ? "登录后可以远程控制烤炉 ..."
                          //     : GlobalVar.userInfo.loginid,
                          style: TextStyle(
                              color: AppStyle.clTitle2FC, fontSize: 16.0),
                        ),
                      ),
                      Container(
                        // width: 120.0,
                        alignment: Alignment.centerLeft,
                        // color: Colors.purpleAccent,
                        height: 30.0,
                        child: Text(
                          'buildNumber : ${ApkHelper.buildNumber}',
                          // GlobalVar.userInfo == null
                          //     ? "登录后可以远程控制烤炉 ..."
                          //     : GlobalVar.userInfo.loginid,
                          style: TextStyle(
                              color: AppStyle.clTitle2FC, fontSize: 16.0),
                        ),
                      ),
                    ],
                  ),
                  // ),
                  onTap: () {
                    _goToLogin();
                  },
                ),
              ),

              //子控件结束
            ],
          ),
          // ),

//关注、浏览数量等
          Container(
            alignment: Alignment.bottomCenter,
            margin: EdgeInsets.only(
                top: 15.0, left: 80.0, right: 20.0, bottom: 10.0),
            // color: Colors.purpleAccent,
            height: 45.0,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Column(
                    children: <Widget>[
                      Text(
                        "0",
                        style: TextStyle(
                            color: AppStyle.clTitle2FC, fontSize: 18.0),
                      ),
                      Text(
                        "关注",
                        style: TextStyle(
                            color: AppStyle.clTitle2FC, fontSize: 15.0),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: <Widget>[
                      Text(
                        "0",
                        style: TextStyle(
                            color: AppStyle.clTitle2FC, fontSize: 16.0),
                      ),
                      Text(
                        "浏览",
                        style: TextStyle(
                            color: AppStyle.clTitle2FC, fontSize: 15.0),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: <Widget>[
                      Text(
                        "0",
                        style: TextStyle(
                            color: AppStyle.clTitle2FC, fontSize: 16.0),
                      ),
                      Text(
                        "点赞",
                        style: TextStyle(
                            color: AppStyle.clTitle2FC, fontSize: 15.0),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: <Widget>[
                      Text(
                        "0",
                        style: TextStyle(
                            color: AppStyle.clTitle2FC, fontSize: 16.0),
                      ),
                      Text(
                        "消息",
                        style: TextStyle(
                            color: AppStyle.clTitle2FC, fontSize: 15.0),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          //card子控件 结束
        ],
      ),
    );
  }

  _setAvatar() {
    if (GlobalVar.userInfo == null) {
      _goToLogin();
      return;
    }

    var fparam = {
      "ot": 0,
      "tb": "Client",
      "rid": GlobalVar.userInfo.id, //.replaceAll("/", ""),
      "fn": "Avatar",
    };

    FileLoadHelper.selectPicture(context, fparam, (path){
      
    },(f) {
      HttpRetModel rm = f as HttpRetModel; // HttpRetModel.getExecRet(f);
      print('@@@ ControlPanelPage._loadImage() rm : ${rm.message}');
      if (rm.ret == 0) {
        setState(() {
          String ui = GlobalVar.userInfo.tojson();
          SharePrefHelper.saveData("userinfo", ui);
          print("after :  ${GlobalVar.userInfo.avatar}");
          // setState(() {});
        });
      } else {
        AppToast.showToast(rm.message);
      }
    });

    // AppDialog.showSelectTextItemIOS(context, ["从相册选择", "用相机拍照"], (item) {
    //   if (item == null) return;

    //   print("@@@ item : $item");

    //   if (item == "0")
    //     _getImageFromGallery();
    //   else
    //     _getImageFromCamera();
    // });
  }

  // File _image;
  //拍照
  // Future _getImageFromCamera() async {
  //   var image =
  //       await ImagePicker.pickImage(source: ImageSource.camera, maxWidth: 400);

  //   setState(() {
  //     _image = image;
  //   });

  //   _uploadImage(image);
  // }

  // //相册选择
  // Future _getImageFromGallery() async {
  //   var image = await ImagePicker.pickImage(source: ImageSource.gallery);
  //   if (image == null) return;
  //   setState(() {
  //     _image = image;
  //   });

  //   if (image != null) _uploadImage(image);
  // }

  // _uploadImage(image) {
  //   if (image == null) return;

  //   var fparam = {
  //     "ot": 0,
  //     "tb": "Client",
  //     "rid": GlobalVar.userInfo.id, //.replaceAll("/", ""),
  //     "fn": "Avatar",
  //   };

  //   HttpCallerSrv.uploadImage(image, fparam).then((f) {
  //     try {
  //       print("before : ${GlobalVar.userInfo.avatar}");
  //       // print("@@@ _getImageFromGallery() f : $f");
  //       Map map = json.decode(f.toString());
  //       if (map != null && map["ret"].toString() == "0") {
  //         GlobalVar.userInfo.avatar = map["file"];

  //         // SharePrefHelper.removeData("userinfo");
  //         String ui = GlobalVar.userInfo.tojson();
  //         SharePrefHelper.saveData("userinfo", ui);
  //         print("after :  ${GlobalVar.userInfo.avatar}");
  //         setState(() {});
  //       }
  //     } catch (e) {
  //       print("*** MyPage.uploadImage() error : ${e.toString()}");
  //     }
  //     // print(map);
  //   });
  // }

  _goToLogin() {
    Navigator.of(context).pushNamed('/login');
  }

  _goToList(String name) {
    if (name == '检查更新') {
      if (Platform.isAndroid) {
        print("@@@ => MyPage._goToList($name) ... ");
        ApkHelper.getVersion(context, 1);
      }
      return;
    }

    if (name == '关于') {
      Navigator.of(context).pushNamed('/about');
      return;
    }

    if (GlobalVar.userInfo == null && name != '') {
      AppBO.goLogin(context);
      return;
    }

    print("@@@ _goToList() 转到列表 $name");

    String route = '';
    switch (name) {
      case "我的模板":
        // route = '/templatelist';
        // Navigator.of(context).pushNamed(route,  arguments: {"iid":0,"cpname":"ACE"});  //{"iid":0,"cpname":""}
        TemplateBO.showTemplateListPage(context);
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => TemplateListPage(
        //       iid: 0,
        //       cpname: "ACE",
        //       dest: 0,
        //     ),
        //   ),
        // );
        return;
        break;
      case "我的维修":
        route = '/maintain';
        // Navigator.push(
        //     context, MaterialPageRoute(builder: (context) => IntroSlidePage()));
        // Navigator.push(
        //     context, MaterialPageRoute(builder: (context) => IntroSwiperPage()));
        break;
      case "我的收藏":
        // Navigator.push(
        //     context, MaterialPageRoute(builder: (context) => FlutterDownloaderPage(title: 'Flutter Downloader',platform: TargetPlatform.android,)));
        route = '/faveritelist';
        break;
      case "我的分享":
        route = '/sliverappbardemo1';
        break;
      case "我的心得":
        route = '/tabdemo';
        break;
      case "设置":
        route = '/mysettings';
        break;

      // case "修改密码":
      //   break;
      // case "退出登录":
      //   _goToLogin();
      //   // route = '/login';
      //   break;
      // case "切换帐号":
      //   // route = '/login';
      //   _goToLogin();
      //   break;
      default:
        return;
    }

    if (route != '') {
      Navigator.of(context).pushNamed(route);
    }
  }

  _getContentList() {
    List<Widget> _lst = List<Widget>();
    _lst.add(_getHeaderWidget());
    // _lst.add(Divider());
    List<String> _lstParam = [
      '我的模板',
      '我的维修',
      '我的收藏',
      '我的分享',
      '我的心得',
      '设置',
      '检查更新',
      '关于',
      // '切换帐号',
      // '退出登录',
      // '修改密码',
    ];
    for (int i = 0; i < _lstParam.length; i++) {
      _lst.add(_getListItem(_lstParam[i]));
      _lst.add(Divider(
        indent: 20.0,
        endIndent: 20.0,
      ));
    }

    return _lst;
  }

  _getListItem(String name) {
    IconData id;
    switch (name) {
      case "我的模板":
        id = Icons.dashboard;
        break;
      case "我的维修":
        id = Icons.build;
        break;
      case "我的收藏":
        id = Icons.favorite;
        break;
      case "我的分享":
        id = Icons.local_dining;
        break;
      case "我的心得":
        id = Icons.chat;
        break;
      case "设置":
        id = Icons.settings;
        break;
      case "检查更新":
        id = Icons.cloud_download;
        break;
      case "关于":
        id = Icons.mood;
        break;
      // case "修改密码":
      //   id = Icons.vpn_key;
      //   break;
      // case "退出登录":
      //   id = Icons.directions_run;
      //   break;
      // case "切换帐号":
      //   id = Icons.transfer_within_a_station;
      //   break;
      default:
        id = Icons.recent_actors;
    }

    return ListTile(
      contentPadding:
          EdgeInsets.only(left: 30.0, right: 30.0, top: 0.0, bottom: 0.0),
      dense: true,
      leading: Icon(
        id, //Icons.recent_actors,
        size: 26.0,
        color: AppStyle.mainColor,// Colors.blue[500],
      ),
      title: Text(
        name,
        style: TextStyle(color: Colors.grey, fontSize: 18.0),
      ),
      selected: true,
      trailing: Icon(
        Icons.keyboard_arrow_right,
        color: Colors.grey[400],
        size: 36.0,
      ),
      onTap: () {
        _goToList(name);
      },
    );
  }

  _setParam() {
    print("@@@ 设置参数");
    if (GlobalVar.userInfo == null)
      _goToLogin();
    else
      Navigator.of(context).pushNamed('/mysettings');
  }
}
