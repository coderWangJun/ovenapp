// import 'package:flutter/cupertino.dart';
import 'dart:io';
import 'dart:ui';

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
// import 'package:ovenapp/Pages/SliverWidget.dart';
// import 'package:ovenapp/Pages/FlutterDownloaderPage.dart';
// import 'package:ovenapp/Pages/IntroSwiperPage.dart';
// import 'package:ovenapp/Pages/TemplateListPage.dart';
// import 'package:ovenapp/Publics/AppObjHelper.dart';

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
  String _avatarFile;
  // String _avatarFile =
  //     '/storage/emulated/0/Android/data/com.example.ovenapp/files/img_1586067460424.jpg';
  // int _counter = 0;
  // final StreamController<int> _streamController = StreamController<int>();
  Map<String, IconData> _lstItem = {
    "我的模板": Icons.dashboard,
    "我的维修": Icons.build,
    "我的收藏": Icons.favorite,
    "我的分享": Icons.local_dining,
    "我的心得": Icons.chat,
    // "设置": Icons.settings,
    "检查更新": Icons.cloud_download,
    // "关于": Icons.mood,
  };

  Map<String, int> _lstNB = {"关注": 1, "浏览": 2, "点赞": 3, "消息": 4};

  List<String> _lstName;
  List<IconData> _lstIcon;
  // List<String> _lstNBName;
  // List<int> _lstNBCount;
  double dTabBarHeight = 56.0;
  String _loginid = '未登录用户';

  @override
  void initState() {
    super.initState();
    _lstName = _lstItem.keys.toList();
    _lstIcon = _lstItem.values.toList();
    // if (GlobalVar.userInfo != null) avatarfile = GlobalVar.userInfo.avatar;
    // _lstNBName = _lstNB.keys.toList();
    // _lstNBCount = _lstNB.values.toList();
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
    if (GlobalVar.userInfo != null && GlobalVar.userInfo.loginid != null)
      _loginid = GlobalVar.userInfo.loginid;
    else
      _loginid = '未登录用户';

    print("@@@ => MyPage.build() ... ");
    //  +
    //     (GlobalVar.userInfo == null
    //         ? 'GlobalVar is null'
    //         : GlobalVar.userInfo.toString()));
    // print(GlobalVar.webimageurl + 'wm.jpg');
    return Scaffold(
      //  appBar: AppBar(title: Text('Stream version of the Counter App')),
      body: SafeArea(
        child: CustomScrollView(
          primary: false,
          slivers: <Widget>[
            SliverAppBar(
              backgroundColor: Colors.transparent,
              // leading: IconButton(icon: Icon(Icons.backspace), color: Colors.transparent, onPressed: () {},),
              primary: false, // appbar是否显示在屏幕的最上面，为false是显示在最上面，为true就显示在状态栏的下面
              title:
                  // Text(
                  //     GlobalVar.userInfo.loginid,
                  //     textAlign: TextAlign.center,
                  //     style: TextStyle(color: AppStyle.mainColor, fontSize: 20.0),
                  //   ),
                  Container(
                alignment: Alignment.center,
                child: Text(
                  _loginid == null
                      ? '未登录用户'
                      : _loginid, //GlobalVar.userInfo.loginid,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: AppStyle.mainColor, fontSize: 20.0),
                ),
              ),
              // actions: <Widget>[
              //   IconButton(icon: Icon(Icons.settings), onPressed: () {}),
              // ],
              // backgroundColor: Colors.transparent,
              expandedHeight: 230.0,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                titlePadding: EdgeInsets.zero,
                // title: Text('Yesterday Once More ...'),
                background: _getHeaderWidget(),
                // background: Image.network(GlobalVar.webimageurl+ '1EC9485BB602.jpg', fit: BoxFit.cover),
              ),
              floating:
                  false, //滑动到最上面，再滑动是否隐藏导航栏的文字和标题等的具体内容，为true是隐藏，为false是不隐藏
              snap: false, //是否固定导航栏，为true是固定，为false是不固定，往上滑，导航栏可以隐藏
              pinned:
                  true, //只跟floating相对应，如果为true，floating必须为true，也就是向下滑动一点儿，整个大背景就会动画显示全部，网上滑动整个导航栏的内容就会消失
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(dTabBarHeight),
                child: Theme(
                  data: Theme.of(context).copyWith(accentColor: Colors.white),
                  child: _getTabBarUI(),
                  // Container(
                  //   height: 56.0,
                  //   alignment: Alignment.center,
                  //   child: _getTabBarUI(),//Text('Yesterday Once More ...'),
                  // ),
                ),
              ),
              elevation: 0.0,
            ),
            // SliverPersistentHeader(
            //   floating: false,
            //   pinned: true,
            //   delegate: SliverWidgetDelegate(
            //     _getTabBarUI(),dTabBarHeight,
            //   ),
            //   // Tab(icon: Icon(Icons.golf_course), text: '右侧'),
            // ),
            SliverFixedExtentList(
              itemExtent: 56.0,
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return _getListItem(index);
                },
                childCount: _lstItem.length,
              ),
            ),
          ],
        ),
        // SafeArea(
        //   child: SingleChildScrollView(
        //     child: Column(
        //       children: _getContentList(),
        //     ),
        //   ),
      ),
    );
  }

  _getHeaderWidget() {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("images/maintain_g.png"),
          fit: BoxFit.fill,
        ),
      ),
      // // color: Colors.red, //Card 背景颜色 为了便于识别，设置了红色 child 设置不全部沾满时可呈现
      // // color: Colors.transparent,
      // elevation: 2.0, //传入double值，控制投影效果
      // margin: EdgeInsets.only(bottom: 8.0),
      // shape: RoundedRectangleBorder(
      //   // borderRadius: BorderRadius.all(Radius.circular(20.0)),   //设定 Card 的倒角大小
      //   borderRadius: BorderRadius.only(
      //     //设定 Card 的每个角的倒角大小
      //     topLeft: Radius.zero, //Radius.circular(20.0),
      //     topRight: Radius.zero,
      //     bottomLeft: Radius.zero, //Radius.circular(10.0),
      //     bottomRight: Radius.zero, //Radius.circular(10.0),
      //   ),
      // ),

      // clipBehavior: Clip.antiAlias, //对Widget截取的行为，比如这里 Clip.antiAlias 指抗锯齿

      // child: Column(
      //   children: <Widget>[
      //设置
      // SizedBox(
      //   height: 20.0,
      //   child: Container(
      //     alignment: Alignment.topRight,
      //     // margin: EdgeInsets.only(bottom: 35.0),
      //     // color: Colors.brown,
      //     // height: 100.0,
      //     child: IconButton(
      //       color: Colors.grey[400],
      //       icon: Icon(Icons.settings),
      //       onPressed: () {
      //         _setParam();
      //       },
      //     ),
      //   ),
      // ),

      //头像、帐号
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 0.0,
          sigmaY: 0.0,
        ),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Container(),
            ),
            GestureDetector(
              child: Column(
                children: <Widget>[
                  // Expanded(child: Container()),
                  Container(
                    height: 90.0,
                    width: 90.0,
                    // color: Colors.purpleAccent,
                    margin: EdgeInsets.only(top: 50.0),
                    // width: 80.0,
                    alignment: Alignment.center,
                    child: _getAvatar('header.png'),
                  ),
                  Container(
                    // width: 120.0,
                    alignment: Alignment.bottomLeft,
                    // color: Colors.brown,
                    height: 25.0,
                    margin: EdgeInsets.only(top: 0.0, bottom: dTabBarHeight),
                    child: Text(
                      GlobalVar.userInfo == null
                          ? "点击登录"
                          : GlobalVar.userInfo.name,
                      style: TextStyle(color: Colors.white70, fontSize: 17.0),
                    ),
                  ),
                  // Expanded(child: Container()),
                ],
              ),
              onTap: () {
                _setAvatar();
              },
            ),
            //名称、
            Expanded(
              child: Container(
                  // child: Container(
                  // child: Column(
                  //   mainAxisAlignment: MainAxisAlignment.start,
                  //   children: <Widget>[
                  //     Container(
                  //       // width: 120.0,
                  //       alignment: Alignment.bottomLeft,
                  //       // color: Colors.brown,
                  //       height: 40.0,
                  //       // child: Text(
                  //       //   GlobalVar.userInfo == null
                  //       //       ? "点击登录"
                  //       //       : GlobalVar.userInfo.name,
                  //       //   style: TextStyle(
                  //       //       color: AppStyle.clTitle1FC, fontSize: 22.0),
                  //       // ),
                  //     ),

                  //     // 帐号
                  //     Container(
                  //       // width: 120.0,
                  //       alignment: Alignment.centerLeft,
                  //       // color: Colors.purpleAccent,
                  //       height: 30.0,
                  //       // child: Text(
                  //       //   'version : ${ApkHelper.version}',
                  //       //   // GlobalVar.userInfo == null
                  //       //   //     ? "登录后可以远程控制烤炉 ..."
                  //       //   //     : GlobalVar.userInfo.loginid,
                  //       //   style:
                  //       //       TextStyle(color: AppStyle.clTitle2FC, fontSize: 16.0),
                  //       // ),
                  //     ),
                  //     // Container(
                  //     //   // width: 120.0,
                  //     //   alignment: Alignment.centerLeft,
                  //     //   // color: Colors.purpleAccent,
                  //     //   height: 30.0,
                  //     //   child: Text(
                  //     //     'buildNumber : ${ApkHelper.buildNumber}',
                  //     //     // GlobalVar.userInfo == null
                  //     //     //     ? "登录后可以远程控制烤炉 ..."
                  //     //     //     : GlobalVar.userInfo.loginid,
                  //     //     style:
                  //     //         TextStyle(color: AppStyle.clTitle2FC, fontSize: 16.0),
                  //     //   ),
                  //     // ),
                  //   ],
                  // ),
                  ),
            ),

            //子控件结束
          ],
        ),
        // ),

        //card子控件 结束
        //   ],
      ),
    );
  }

  _getAvatar(String assetImage) {
    if (GlobalVar.userInfo == null) return AppWidget.getLocalImage(assetImage);

//  return AppWidget.getCircleAvatar(GlobalVar.userInfo.avatar, 90.0);img_1586067460424
    // _avatarFile = GlobalVar.appLocalPath + '/img_1586067460424.jpg';
    if (_avatarFile != null && _avatarFile != '') {
      // print('@@@ MyPage._getAvatar($assetImage) _avatarFile : $_avatarFile');
      // return Container(
      //       // color: Colors.deepOrangeAccent,
      //       height: 90.0,
      //       width: 90.0,
      //       child: ClipRRect(
      //         // clipper: CustomClipper<RRect>(3.0),
      //         borderRadius: BorderRadius.all(Radius.circular(45.0)),
      //         clipBehavior: Clip.antiAlias,
      //         child: Image.file(
      //           File(_avatarFile),
      //           fit: BoxFit.fitWidth,
      //         ),
      //       ),
      //   );
      return AppWidget.getImageFile(_avatarFile, 90.0, 90.0, 45.0);
      // return Container(
      //       height: double.infinity,
      //       width: double.infinity,
      //       child: Image.file(
      //         File(_avatarFile),
      //         fit: BoxFit.fitWidth,
      //       ),
      //     );

      // File file =
      //     File(_avatarFile); //ApkHelper.appLocalPath + '/' + avatarfile);
      // file.exists().then((ie) {
      //   if (ie) {
      //     print('@@@ MyPage._getAvatar() ie : $ie');
      //     return Container(
      //       height: 80.0,
      //       width: 80.0,
      //       child: Image.file(
      //         File(_avatarFile),
      //         fit: BoxFit.fitWidth,
      //       ),
      //     );
      //   } else {
      //     return AppWidget.getCircleAvatar(GlobalVar.userInfo.avatar, 90.0);
      //   }
      // }).catchError((e) {
      //   return AppWidget.getCircleAvatar(GlobalVar.userInfo==null?'header.png':GlobalVar.userInfo.avatar, 90.0);
      // });
    } else {
      return AppWidget.getCircleAvatar(
          GlobalVar.userInfo.avatar, 90.0, BoxFit.fitHeight);
    }
  }

//关注、浏览数量等
  _getTabBarUI() {
    return Container(
      height: dTabBarHeight,
      // margin: EdgeInsets.only(bottom: TemplateParam.dTitleHeight,),
      decoration: BoxDecoration(
        // color: AppStyle.clTitleBC, // Colors.transparent,
        border: Border(
          // top: BorderSide(color: AppStyle.clSplitterLineColor, width: 1.0),
          bottom: BorderSide(color: AppStyle.clSplitterLineColor, width: 0.5),
        ),
        // backgroundBlendMode: BlendMode.color,
        color: Colors.black38, //Color.fromRGBO(255, 255, 255, 0.55),
      ),
      // child: Container(
      //   alignment: Alignment.bottomCenter,
      //   // margin:
      //   //     EdgeInsets.only(top: 15.0, left: 80.0, right: 20.0, bottom: 10.0),
      //   // color: Colors.purpleAccent,
      //   height: 60.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: _getTabBarListUI(),
      ),
    );
  }

  _getTabBarListUI() {
    List<Widget> _lst = [];
    _lstNB.forEach((k, v) {
      _lst.add(_getTabBarItemUI(k, v));
    });
    _lst.add(
      Expanded(
        child: IconButton(
          icon: Icon(Icons.settings),
          color: Colors.white70,
          iconSize: 26.0,
          onPressed: () {
            _showSettings();
          },
        ),
      ),
    );
    return _lst;
  }

  _getTabBarItemUI(String n, int c) {
    return Expanded(
      child: FlatButton(
        onPressed: () {
          _tbClick(n);
        },
        child: Container(
          child: Column(
            children: <Widget>[
              Expanded(
                child: Container(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    // _lstNBCount[index].toString(),
                    c.toString(),
                    style: TextStyle(color: Colors.white70, fontSize: 18.0),
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  // _lstNBName[index],
                  n,
                  style: TextStyle(color: Colors.white70, fontSize: 15.5),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _tbClick(k) {
    print('@@@ k : $k');
  }
  // _getTabUI(index) {
  //   // print('begin : _getTabUI($index ** $_index)');
  //   return Container(
  //     child: Text('关注$index'),
  //   );
  // }

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

    FileLoadHelper.selectPicture(context, fparam, (path) {
      print('@@@ MyPage._setAvatar() path : $path');
      _avatarFile = path;
      setState(() {});
    }, (f) {
      HttpRetModel rm = f as HttpRetModel; // HttpRetModel.getExecRet(f);
      // print('@@@ MyPage._loadImage() rm : ${rm.message}');
      if (rm.ret == 0) {
        // setState(() {
        GlobalVar.userInfo.avatar = rm.message;
        String ui = GlobalVar.userInfo.tojson();
        SharePrefHelper.saveData("userinfo", ui);
        // print("after :  ${GlobalVar.userInfo.avatar}");
        // setState(() {});
        // });
      } else {
        AppToast.showToast(rm.message);
      }
    });
  }

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
        return;
        break;
      case "我的维修":
        _avatarFile =
            '/storage/emulated/0/Android/data/com.cfdzkj.ovenapp/files/img_1586067460424.jpg';
        // route = '/maintain';
        setState(() {});
        return;
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
        // route = '/mysettings';
        _showSettings();
        return;
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

  _showSettings() {
    Navigator.of(context).pushNamed('/mysettings');
  }

  // _getContentList() {
  //   List<Widget> _lst = List<Widget>();
  //   _lst.add(_getHeaderWidget());
  //   // _lst.add(Divider());
  //   List<String> _lstParam = [
  //     '我的模板',
  //     '我的维修',
  //     '我的收藏',
  //     '我的分享',
  //     '我的心得',
  //     '设置',
  //     '检查更新',
  //     '关于',
  //     // '切换帐号',
  //     // '退出登录',
  //     // '修改密码',
  //   ];
  //   for (int i = 0; i < _lstParam.length; i++) {
  //     _lst.add(_getListItem(_lstParam[i]));
  //     _lst.add(Divider(
  //       indent: 20.0,
  //       endIndent: 20.0,
  //     ));
  //   }

  //   return _lst;
  // }

  _getListItem(index) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 0.0, bottom: 0.0),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
              color: AppStyle.clSplitterLineColor,
              width: 0.6,
              style: BorderStyle.solid),
        ),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        // EdgeInsets.only(left: 20.0, right: 10.0, top: 0.0, bottom: 0.0),
        dense: true,
        leading: Icon(
          _lstIcon[index], //Icons.recent_actors,
          size: 26.0,
          color: AppStyle.mainColor, // Colors.blue[500],
        ),
        title: Text(
          _lstName[index],
          // 'List $index',
          style: TextStyle(color: Colors.grey, fontSize: 18.0),
        ),
        selected: true,
        trailing: Icon(
          Icons.keyboard_arrow_right,
          color: Colors.grey[400],
          size: 36.0,
        ),
        onTap: () {
          _goToList(_lstName[index]);
        },
      ),
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

//最新备份
/*
// import 'package:flutter/cupertino.dart';
import 'dart:io';
import 'dart:ui';

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
import 'package:ovenapp/Controls/AppImage.dart';
// import 'package:ovenapp/Controls/AppWidget.dart';
// import 'package:ovenapp/IntroSlidePage.dart';
import 'package:ovenapp/Models/HttpRetModel.dart';
import 'package:ovenapp/Pages/FavoriteListPage.dart';
import 'package:ovenapp/Pages/MyChatPage.dart';
import 'package:ovenapp/Pages/MySharePage.dart';
// import 'package:ovenapp/Pages/PrivateServicePage.dart';
import 'package:ovenapp/Pages/RepairListPage.dart';
// import 'package:ovenapp/Publics/AppFileHelper.dart';
// import 'package:ovenapp/Pages/SliverWidget.dart';
// import 'package:ovenapp/Pages/FlutterDownloaderPage.dart';
// import 'package:ovenapp/Pages/IntroSwiperPage.dart';
// import 'package:ovenapp/Pages/TemplateListPage.dart';
// import 'package:ovenapp/Publics/AppObjHelper.dart';

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
  final double dAvatarSize = 90.0;
  final double dHeaderHeight = 230.0;
  double dHeaderWidth = 230.0;

  String _avatarImageFile; //本地文件，中途更换图片时专用，
  String _backImageFile;
  // String _avatarFile =
  //     '/storage/emulated/0/Android/data/com.example.ovenapp/files/img_1586067460424.jpg';
  // int _counter = 0;
  // final StreamController<int> _streamController = StreamController<int>();
  Map<String, IconData> _lstItem = {
    "我的模板": Icons.dashboard,
    "我的维修": Icons.build,
    "我的收藏": Icons.favorite,
    "我的分享": Icons.local_dining,
    "我的心得": Icons.chat,
    // "设置": Icons.settings,
    // "检查更新": Icons.cloud_download,
    "关于烘焙之光与帮助": Icons.mood,
  };

  Map<String, int> _lstNB = {"关注": 21, "浏览": 322, "点赞": 83, "消息": 16};

  List<String> _lstName;
  List<IconData> _lstIcon;
  // List<String> _lstNBName;
  // List<int> _lstNBCount;
  double dTabBarHeight = 56.0;
  String _loginid = '未登录用户';

  @override
  void initState() {
    super.initState();
    dHeaderWidth = GlobalVar.dScreenWidth;
    _lstName = _lstItem.keys.toList();
    _lstIcon = _lstItem.values.toList();
    // if (GlobalVar.userInfo != null) avatarfile = GlobalVar.userInfo.avatar;
    // _lstNBName = _lstNB.keys.toList();
    // _lstNBCount = _lstNB.values.toList();
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
    if (GlobalVar.userInfo != null && GlobalVar.userInfo.loginid != null) {
      _loginid = '';// GlobalVar.userInfo.loginid;
      // _avatarFile = GlobalVar.userInfo.avatar;
    } else
      _loginid = '未登录用户';

    print("@@@ => MyPage.build() ... ");
    //  +
    //     (GlobalVar.userInfo == null
    //         ? 'GlobalVar is null'
    //         : GlobalVar.userInfo.toString()));
    // print(GlobalVar.webimageurl + 'wm.jpg');
    return Scaffold(
      //  appBar: AppBar(title: Text('Stream version of the Counter App')),
      body: SafeArea(
        child: CustomScrollView(
          primary: false,
          slivers: <Widget>[
            SliverAppBar(
              backgroundColor: Colors.transparent,
              leading: SizedBox(
                width: 24.0,
              ),
              // leading: IconButton(icon: Icon(Icons.backspace), color: Colors.transparent, onPressed: () {},),
              primary:
                  false, // appbar是否显示在屏幕的最上面，为 false 是显示在最上面，为 true 就显示在状态栏的下面
              title: Container(
                alignment: Alignment.center,
                child: Text(
                  _loginid == null
                      ? '未登录用户'
                      : _loginid, //GlobalVar.userInfo.loginid,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: AppStyle.mainColor, fontSize: 20.0),
                ),
              ),
              actions: <Widget>[
                IconButton(
                    icon: Icon(
                      Icons.camera_alt,
                      size: 24.0,
                      color: AppStyle.clAssertIcon,
                    ),
                    onPressed: () {
                      _setBackImage();
                    }),
              ],
              // backgroundColor: Colors.transparent,
              expandedHeight: 230.0,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                titlePadding: EdgeInsets.zero,
                // title: Text('Yesterday Once More ...'),
                background: _getHeaderWidget(),
                // background: Image.network(GlobalVar.webimageurl+ '1EC9485BB602.jpg', fit: BoxFit.cover),
              ),
              //就是下面这三个马粪东西的设置必须都是一样的才行，不然报错
              //滑动到最上面，再滑动是否隐藏导航栏的文字和标题等的具体内容，为true是隐藏，为false是不隐藏
              floating: false,
              //是否固定导航栏，为true是固定，为false是不固定，往上滑，导航栏可以隐藏
              snap: false, 
              //只跟floating相对应，如果为true，floating必须为true，也就是向下滑动一点儿，整个大背景就会动画显示全部，网上滑动整个导航栏的内容就会消失
              pinned: false,
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(dTabBarHeight),
                child: Theme(
                  data: Theme.of(context).copyWith(accentColor: Colors.white),
                  child: _getTabBarUI(),
                  // Container(
                  //   height: 56.0,
                  //   alignment: Alignment.center,
                  //   child: _getTabBarUI(),//Text('Yesterday Once More ...'),
                  // ),
                ),
              ),
              elevation: 0.0,
            ),
            // SliverPersistentHeader(
            //   floating: false,
            //   pinned: true,
            //   delegate: SliverWidgetDelegate(
            //     _getTabBarUI(),dTabBarHeight,
            //   ),
            //   // Tab(icon: Icon(Icons.golf_course), text: '右侧'),
            // ),
            SliverFixedExtentList(
              itemExtent: 56.0,
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return _getListItem(index);
                },
                childCount: _lstItem.length,
              ),
            ),
          ],
        ),
        // SafeArea(
        //   child: SingleChildScrollView(
        //     child: Column(
        //       children: _getContentList(),
        //     ),
        //   ),
      ),
    );
  }

  _getBackImage() {
    String _myPic = 'MyPic_2.jpg';
    if (GlobalVar.userInfo != null &&
        GlobalVar.userInfo.mp != null &&
        GlobalVar.userInfo.mp != '') _myPic = GlobalVar.userInfo.mp;

    //IOS系统
    // if (GlobalVar.platForm == 1) {
    //   // print('@@@ MyPage._getBackImage() ios : ${_myPic?.toString()}');
    //   return BoxDecoration(
    //     image: DecorationImage(
    //       image: NetworkImage(GlobalVar.webimageurl +
    //           _myPic), // AppImage.rectImage(GlobalVar.appLocalPath + _myPic,GlobalVar.dScreenWidth, 230.0), // AssetImage("images/myimg.jpg"),
    //       fit: AppFileHelper.getBoxFit(_myPic, GlobalVar.dScreenWidth, dHeaderHeight) ,//AppImage.getCircleBoxFit(_myPic), //BoxFit.fitHeight,//
    //     ),
    //   );
    // }

    // print(
    //     '@@@ MyPage._getBackImage() _backImageFile : ${_backImageFile?.toString()}');
    if (GlobalVar.platForm == 0 &&
        _backImageFile != null &&
        _backImageFile != '') {
      File _picFile = File(_backImageFile);
      return BoxDecoration(
        image: DecorationImage(
          image: FileImage(
              _picFile), // AppImage.rectLocalImage(GlobalVar.appLocalPath + _myPic,GlobalVar.dScreenWidth, 230.0), // AssetImage("images/myimg.jpg"),
          fit: BoxFit.cover,
          //  AppFileHelper.getBoxFit(_backImageFile, dHeaderWidth,
          //     dHeaderHeight), //AppImage.getCircleBoxFit(_backImageFile),
        ),
      );
      // return AppImage.circleLocalImage(
      //     _avatarFile, dAvatarSize); //,FileLoadHelper.imageRatio
    }

    return BoxDecoration(
      image: DecorationImage(
        image: NetworkImage(GlobalVar.webimageurl +
            _myPic), // AppImage.rectImage(GlobalVar.appLocalPath + _myPic,GlobalVar.dScreenWidth, 230.0), // AssetImage("images/myimg.jpg"),
        fit: BoxFit.cover,
        //AppFileHelper.getBoxFit(_myPic, dHeaderWidth,dHeaderHeight), // AppImage.getCircleBoxFit(_myPic), //BoxFit.fitHeight,//
      ),
    );

    // // _myPic = _myPic;
    // //  int _imageRatio=AppFileHelper.getImageRation(_myPic);
    // // String _localFile = AppFileHelper.getLocalFile(_myPic);
    // // print(
    // //     '@@@ MyPage._getBackImage() _myPic : ${_myPic?.toString()} , _localFile : $_localFile');
    // File _picFile =
    //     File(GlobalVar.appLocalPath + AppFileHelper.getLocalFile(_myPic));
    // bool blFileExist = _picFile.existsSync();
    // // print('@@@ MyPage._getBackImage() blFileExist : $blFileExist');
    // if (blFileExist) {
    //   // print(
    //   //     '@@@ MyPage._getBackImage() local file : ${AppFileHelper.getLocalFile(_myPic)}');
    //   return BoxDecoration(
    //     image: DecorationImage(
    //       image: FileImage(
    //           _picFile), // AppImage.rectLocalImage(GlobalVar.appLocalPath + _myPic,GlobalVar.dScreenWidth, 230.0), // AssetImage("images/myimg.jpg"),
    //       fit:  AppFileHelper.getBoxFit(_backImageFile, dHeaderWidth, dHeaderHeight) ,//AppImage.getCircleBoxFit(_myPic),
    //     ),
    //   );
    // } else {
    //   // print('@@@ MyPage._getBackImage() net file : $_myPic');
    //   return BoxDecoration(
    //     image: DecorationImage(
    //       image: NetworkImage(GlobalVar.webimageurl +
    //           _myPic), // AppImage.rectImage(GlobalVar.appLocalPath + _myPic,GlobalVar.dScreenWidth, 230.0), // AssetImage("images/myimg.jpg"),
    //       fit: AppFileHelper.getBoxFit(_backImageFile, dHeaderWidth, dHeaderHeight) ,// AppImage.getCircleBoxFit(_myPic), //BoxFit.fitHeight,//
    //     ),
    //   );
    // }
  }

  _getHeaderWidget() {
    return Container(
      // decoration: BoxDecoration(
      //   image: DecorationImage(
      //     image: AssetImage("images/myimg.jpg"),
      //     fit: BoxFit.fill,
      //   ),
      // ),
      decoration: _getBackImage(),

      //头像、帐号
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 0.0,
          sigmaY: 0.0,
        ),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Container(),
            ),
            GestureDetector(
              child: Column(
                children: <Widget>[
                  // Expanded(child: Container()),
                  Container(
                    height: 90.0,
                    width: 90.0,
                    // color: Colors.purpleAccent,
                    margin: EdgeInsets.only(top: 50.0),
                    // width: 80.0,
                    alignment: Alignment.center,
                    child: _getAvatar(),
                  ),
                  Container(
                    // width: 120.0,
                    alignment: Alignment.bottomLeft,
                    // color: Colors.brown,
                    height: 25.0,
                    margin: EdgeInsets.only(top: 0.0, bottom: dTabBarHeight),
                    child: Text(
                      GlobalVar.userInfo == null
                          ? "点击登录"
                          : GlobalVar.userInfo.name,
                      style: TextStyle(color: Colors.white70, fontSize: 17.0),
                    ),
                  ),
                  // Expanded(child: Container()),
                ],
              ),
              onTap: () {
                _setAvatar();
              },
            ),
            //名称、
            Expanded(
              child: Container(
                  // height: double.infinity,
                  // height: 120.0,
                  // color: Colors.limeAccent,
                  // alignment: Alignment.topRight,
                  // child: IconButton(
                  //     icon: Icon(Icons.settings),
                  //     color: AppStyle.clAssertIcon,
                  //     iconSize: 26.0,
                  //     onPressed: () {}),
                  // child: Container(
                  // child: Column(
                  //   mainAxisAlignment: MainAxisAlignment.start,
                  //   children: <Widget>[
                  //     Container(
                  //       // width: 120.0,
                  //       alignment: Alignment.bottomLeft,
                  //       // color: Colors.brown,
                  //       height: 40.0,
                  //       // child: Text(
                  //       //   GlobalVar.userInfo == null
                  //       //       ? "点击登录"
                  //       //       : GlobalVar.userInfo.name,
                  //       //   style: TextStyle(
                  //       //       color: AppStyle.clTitle1FC, fontSize: 22.0),
                  //       // ),
                  //     ),

                  //     // 帐号
                  //     Container(
                  //       // width: 120.0,
                  //       alignment: Alignment.centerLeft,
                  //       // color: Colors.purpleAccent,
                  //       height: 30.0,
                  //       // child: Text(
                  //       //   'version : ${ApkHelper.version}',
                  //       //   // GlobalVar.userInfo == null
                  //       //   //     ? "登录后可以远程控制烤炉 ..."
                  //       //   //     : GlobalVar.userInfo.loginid,
                  //       //   style:
                  //       //       TextStyle(color: AppStyle.clTitle2FC, fontSize: 16.0),
                  //       // ),
                  //     ),
                  //     // Container(
                  //     //   // width: 120.0,
                  //     //   alignment: Alignment.centerLeft,
                  //     //   // color: Colors.purpleAccent,
                  //     //   height: 30.0,
                  //     //   child: Text(
                  //     //     'buildNumber : ${ApkHelper.buildNumber}',
                  //     //     // GlobalVar.userInfo == null
                  //     //     //     ? "登录后可以远程控制烤炉 ..."
                  //     //     //     : GlobalVar.userInfo.loginid,
                  //     //     style:
                  //     //         TextStyle(color: AppStyle.clTitle2FC, fontSize: 16.0),
                  //     //   ),
                  //     // ),
                  //   ],
                  // ),
                  ),
            ),

            //子控件结束
          ],
        ),
        // ),

        //card子控件 结束
        //   ],
      ),
    );
  }

  _getAvatar() {
    String _avatarFile = 'header.png';
    if (GlobalVar.userInfo != null &&
        GlobalVar.userInfo.avatar != null &&
        GlobalVar.userInfo.avatar.trim() != '') {
      _avatarFile = GlobalVar.userInfo.avatar;
    }

    // print(
    //     '@@@ MyPage._getAvatar() _avatarFile : $_avatarFile');

    if (_avatarFile == 'header.png' || _avatarFile == 'empty.png') {
      Icon icon = Icon(
        Icons.person,
        color: Colors.grey[400],
        size: 45.0,
      );

      return AppImage.circleMaterialIcon(
          icon, dAvatarSize, AppStyle.clBorderImage);
    }
    // return AppImage.circleAssertImage(
    //   'header.png',
    //   dAvatarSize,
    //   45.0,
    //   AppStyle.clAssertIcon,
    //   AppStyle.clAssertIcon,
    // );

    // //IOS系统
    // if (GlobalVar.platForm == 1) {
    //   return AppImage.circleImage(_avatarFile, dAvatarSize);
    // }

    // print(
    //     '@@@ MyPage._getAvatar() _avatarImageFile : ${_avatarImageFile?.toString()}');
    if (GlobalVar.platForm == 0 &&
        _avatarImageFile != null &&
        _avatarImageFile != '') {
      return AppImage.circleLocalImage(_avatarImageFile, dAvatarSize);
    }

    return AppImage.circleImage(_avatarFile, dAvatarSize);
// //  return AppWidget.getCircleAvatar(GlobalVar.userInfo.avatar, 90.0);img_1586067460424
//     // _avatarFile = GlobalVar.appLocalPath + '/img_1586067460424.jpg';
//     //更换图片时直接从本地加载
//     // File _picFile = File(GlobalVar.appLocalPath + GlobalVar.userInfo.avatar);
//     // bool blFileExist = _picFile.existsSync();
//     int _imageRatio = AppFileHelper.getImageRation(_avatarFile);
//     String _localFile = AppFileHelper.getLocalFile(_avatarFile);
//     // print('@@@ MyPage._getAvatar() _localFile : $_localFile , _imageRatio : $_imageRatio');

//     //  File _picFile =
//     //     File(GlobalVar.appLocalPath + _localFile);
//     // bool blFileExist = _picFile.existsSync();

//     if (AppFileHelper.isExistLocalFile(_localFile)) {
//       // if(blFileExist){
//       // print('@@@ MyPage._getAvatar() local file => _localFile : $_localFile');
//       return AppImage.circleLocalImage(
//           GlobalVar.appLocalPath + _localFile, dAvatarSize, _imageRatio);
//     } else {
//       // print('@@@ MyPage._getAvatar() net file => _avatarFile : $_avatarFile');
//       return AppImage.circleImage(_avatarFile, dAvatarSize);
//       // return AppWidget.getCircleAvatar(
//       //     GlobalVar.userInfo.avatar, 90.0, BoxFit.fitHeight);
//     }
  }

  _setBackImage() {
// print('@@@ MyPage._setBackImage()');
    if (GlobalVar.userInfo == null) {
      // _goToLogin();
      return;
    }

    var fparam = {
      "ot": 0,
      "tb": "Client",
      "rid": GlobalVar.userInfo.id, //.replaceAll("/", ""),
      "fn": "MyPic",
    };

    FileLoadHelper.selectPicture(context, fparam, (path) {
      print('@@@ MyPage._setBackImage() path : $path');
      // print('@@@ MyPage.selectPicture() path : ${FileLoadHelper.imagePath} , imageRatio : ${FileLoadHelper.imageRatio}');
      _backImageFile = path;
      setState(() {});
    }, (f) {
      HttpRetModel rm = f as HttpRetModel; // HttpRetModel.getExecRet(f);
      // print('@@@ MyPage._loadImage() rm : ${rm.message}');
      if (rm.ret == 0) {
        // setState(() {
        GlobalVar.userInfo.mp = rm.message;
        String ui = GlobalVar.userInfo.tojson();
        SharePrefHelper.saveData("userinfo", ui);

        _backImageFile = null;
        // print("after :  ${GlobalVar.userInfo.avatar}");
        // setState(() {});
        // print("after :  ${GlobalVar.userInfo.avatar}");
        // setState(() {});
        // });
      } else {
        AppToast.showToast(rm.message);
      }
    });
  }

//关注、浏览数量等
  _getTabBarUI() {
    return Container(
      height: dTabBarHeight,
      // margin: EdgeInsets.only(bottom: TemplateParam.dTitleHeight,),
      decoration: BoxDecoration(
        // color: AppStyle.clTitleBC, // Colors.transparent,
        border: Border(
          // top: BorderSide(color: AppStyle.clSplitterLineColor, width: 1.0),
          bottom: BorderSide(color: AppStyle.clSplitterLineColor, width: 0.5),
        ),
        // backgroundBlendMode: BlendMode.color,
        color: Colors.black38, //Color.fromRGBO(255, 255, 255, 0.55),
      ),
      // child: Container(
      //   alignment: Alignment.bottomCenter,
      //   // margin:
      //   //     EdgeInsets.only(top: 15.0, left: 80.0, right: 20.0, bottom: 10.0),
      //   // color: Colors.purpleAccent,
      //   height: 60.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: _getTabBarListUI(),
      ),
    );
  }

  _getTabBarListUI() {
    List<Widget> _lst = [];
    _lstNB.forEach((k, v) {
      _lst.add(_getTabBarItemUI(k, v));
    });
    _lst.add(
      Expanded(
        child: IconButton(
          icon: Icon(Icons.settings),
          color: Colors.white70,
          iconSize: 26.0,
          onPressed: () {
            _showSettings();
          },
        ),
      ),
    );
    return _lst;
  }

  _getTabBarItemUI(String n, int c) {
    return Expanded(
      child: FlatButton(
        onPressed: () {
          _tbClick(n);
        },
        child: Container(
          child: Column(
            children: <Widget>[
              Expanded(
                child: Container(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    // _lstNBCount[index].toString(),
                    c.toString(),
                    style: TextStyle(color: Colors.white70, fontSize: 18.0),
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  // _lstNBName[index],
                  n,
                  style: TextStyle(color: Colors.white70, fontSize: 15.5),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _tbClick(k) {
    print('@@@ k : $k');
  }
  // _getTabUI(index) {
  //   // print('begin : _getTabUI($index ** $_index)');
  //   return Container(
  //     child: Text('关注$index'),
  //   );
  // }

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

    FileLoadHelper.selectPicture(context, fparam, (path) {
      print('@@@ MyPage._setAvatar() path : $path');
      print(
          '@@@ MyPage.selectPicture() path : ${FileLoadHelper.imagePath} , imageRatio : ${FileLoadHelper.imageRatio}');
      _avatarImageFile = path;

      setState(() {});
    }, (f) {
      HttpRetModel rm = f as HttpRetModel; // HttpRetModel.getExecRet(f);
      // print('@@@ MyPage._loadImage() rm : ${rm.message}');
      if (rm.ret == 0) {
        // setState(() {
        GlobalVar.userInfo.avatar = rm.message;
        String ui = GlobalVar.userInfo.tojson();
        SharePrefHelper.saveData("userinfo", ui);

        _avatarImageFile = null;
        // print("after :  ${GlobalVar.userInfo.avatar}");
        // setState(() {});
        // });
      } else {
        AppToast.showToast(rm.message);
      }
    });
  }

  _goToLogin() {
    Navigator.of(context).pushNamed('/login').then((value) {
      if (value != null && value.toString() == 'OK') {
        setState(() {
          print("@@@ => MyPage._goToLogin OK");
        });
      }
    });
  }

  _goToList(String name) {
    if (name == '检查更新') {
      if (Platform.isAndroid) {
        print("@@@ => MyPage._goToList($name) ... ");
        ApkHelper.getVersion(context, 1);
      }
      return;
    }

    if (name == '关于烘焙之光与帮助') {
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
        return;
        break;
      case "我的维修":
      // SharePrefHelper.removeData(GlobalVar.spprivateservice);
        // _avatarFile =
        //     '/storage/emulated/0/Android/data/com.example.ovenapp/files/img_1586067460424.jpg';
        // // route = '/maintain';
        // setState(() {});
        //  Navigator.of(context).pushNamed(route,  arguments: {"iid":0,"cpname":"ACE"});  //{"iid":0,"cpname":""}
        // return;
            //     Navigator.push(
            // context, MaterialPageRoute(builder: (context) => PrivateServicePage()));return;

        Navigator.push(
            context, MaterialPageRoute(builder: (context) => RepairListPage()));
        // Navigator.push(
        //     context, MaterialPageRoute(builder: (context) => IntroSwiperPage()));
        break;
      case "我的收藏":
      // _getAvatar();return;
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => FavoriteListPage()));
        // Navigator.push(
        //     context, MaterialPageRoute(builder: (context) => FlutterDownloaderPage(title: 'Flutter Downloader',platform: TargetPlatform.android,)));
        // route = '/faveritelist';
        break;
      case "我的分享":
        // route = '/sliverappbardemo1';
        // route = '/myshare';        
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => MySharePage()));
        break;
      case "我的心得":
        // route = '/tabdemo';
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => MyChatPage()));
        break;
      case "设置":
        // route = '/mysettings';
        _showSettings();
        return;
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

  _showSettings() {
    Navigator.of(context).pushNamed('/mysettings').then((value) {
      // print('value => $value');
      if (value != null && value == 'logoff') {
        // print('value => $value');
        setState(() {});
      }
    });
  }

  // _getContentList() {
  //   List<Widget> _lst = List<Widget>();
  //   _lst.add(_getHeaderWidget());
  //   // _lst.add(Divider());
  //   List<String> _lstParam = [
  //     '我的模板',
  //     '我的维修',
  //     '我的收藏',
  //     '我的分享',
  //     '我的心得',
  //     '设置',
  //     '检查更新',
  //     '关于',
  //     // '切换帐号',
  //     // '退出登录',
  //     // '修改密码',
  //   ];
  //   for (int i = 0; i < _lstParam.length; i++) {
  //     _lst.add(_getListItem(_lstParam[i]));
  //     _lst.add(Divider(
  //       indent: 20.0,
  //       endIndent: 20.0,
  //     ));
  //   }

  //   return _lst;
  // }

  _getListItem(index) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 0.0, bottom: 0.0),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
              color: AppStyle.clSplitterLineColor,
              width: 0.6,
              style: BorderStyle.solid),
        ),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        // EdgeInsets.only(left: 20.0, right: 10.0, top: 0.0, bottom: 0.0),
        dense: true,
        leading: Icon(
          _lstIcon[index], //Icons.recent_actors,
          size: 26.0,
          color: AppStyle.mainColor, // Colors.blue[500],
        ),
        title: Text(
          _lstName[index],
          // 'List $index',
          style: TextStyle(color: Colors.grey, fontSize: 18.0),
        ),
        selected: true,
        trailing: Icon(
          Icons.keyboard_arrow_right,
          color: Colors.grey[400],
          size: 36.0,
        ),
        onTap: () {
          _goToList(_lstName[index]);
        },
      ),
    );
  }

  // _setParam() {
  //   print("@@@ 设置参数");
  //   if (GlobalVar.userInfo == null)
  //     _goToLogin();
  //   else
  //     Navigator.of(context).pushNamed('/mysettings');
  // }
}

*/
