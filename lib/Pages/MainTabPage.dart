// import 'dart:async';
import 'dart:async';

// import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:ovenapp/BusinessObjects/DialogBO.dart';
// import 'package:ovenapp/BusinessObjects/ScanBO.dart';
import 'package:ovenapp/Classes/ApkHelper.dart';
import 'package:ovenapp/Classes/AppToast.dart';
// import 'package:ovenapp/Classes/ApkUpdate.dart';
// import 'package:ovenapp/Classes/AppDialog.dart';
// import 'package:ovenapp/Classes/AppToast.dart';
// import 'package:ovenapp/Classes/SharePrefHelper.dart';
import 'package:ovenapp/Pages/DevicePage.dart';
import 'package:ovenapp/Pages/ExplorePage.dart';
import 'package:ovenapp/Pages/HomePage.dart';
import 'package:ovenapp/Pages/MyPage.dart';
// import 'package:ovenapp/Pages/VideoPage.dart';
import 'package:ovenapp/Publics/AppStyle.dart';
// import 'package:ovenapp/Controls/CustomFB.dart';
// import 'package:ovenapp/Models/ControlPanelModel.dart';
// import 'package:ovenapp/Pages/DeviceDetailPage.dart';
// import 'package:ovenapp/Pages/TemplatePage.dart';
import 'package:ovenapp/Publics/GlobalVar.dart';
import 'package:ovenapp/Services/EventBusSrv.dart';

// import '../Publics/GlobalVar.dart';
// import '../BusinessObjects/MainBO.dart';

class MainTabPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new MainTabPageState();
  }
}

class MainTabPageState extends State<MainTabPage> {
  // with SingleTickerProviderStateMixin{
  // TabController controller;
  int lastTime = 0;
  // PageController pageController;
  int _tabIndex = 0;
  // final StreamController<int> _streamController = StreamController<int>();

  var _onCallPageEvent;
  var _onDownloadedEvent;
  var _onDownloadEvent;

// static Map<String, String> _lstIcon;
  // static Map<String, String> _lstTitle;
  // static Map<String, Widget> _lstPage;
  // List<String> _lstIcon;
  List<String> _lstName;
  List<String> _lstTitle;
  List<Widget> _lstNaviItem;
  List<Widget> _lstPage;

  @override
  void initState() {
    print("@@@ => MainTabPageState.initState() ... ");
    super.initState();

    _initMenu();
    // pageController = PageController(initialPage: _tabIndex);

// _initMenu() ;
    // GlobalVar.initUserInfo();
    // SharePrefHelper.initSP();
    // GlobalVar.initUserInfo();

    _onCallPageEvent = eventBus.on<CallPageEvent>().listen((event) {
      String pagename = event.pn;
      String data = event.data;
      String data1 = event.data1;

      print(
          "@@@ MainTabPageState.CallPageEvent => pn : $pagename / data : $data / data1 : $data1");
    });

    // _onDownloadedEvent = eventBus.on<DownloadedEvent>().listen((event) {
    //   AppToast.showToast('下载完成！');
    //   print(
    //       "@@@ MainTabPageState.DownloadedEvent => dtype : ${event.dtype} ,  file : ${event.file}");
    //   String dtype = event.dtype;
    //   String file = event.file;

    //   if (dtype == 'update') {
    //     // _showInstallIOS(file);
    //   }
    // });

    _onDownloadEvent = eventBus.on<DownloadEvent>().listen((event) {
      // AppToast.showToast('请求下载 ...');
      print(
          "@@@ MainTabPageState.DownloadEvent => dtype : ${event.dtype} , urlpath : ${event.urlpath} ,  urlfile : ${event.urlfile}");
      String dtype = event.dtype;
      // String localpath = event.localpath;localpath : ${event.localpath} ,
      String urlpath = event.urlpath;
      String urlfile = event.urlfile;

      if (dtype == 'update') {
        // ApkUpdate apkUpdate = ApkUpdate();
        _downloadUpdateFile(urlpath, urlfile);
      }
    });

    // GlobalVar.initJPushSrv();
  }

  @override
  void dispose() {
    super.dispose();

    if (GlobalVar.mqttClass != null) GlobalVar.mqttClass.close();
    _onCallPageEvent.cancel();
    _onDownloadedEvent.cancel();
    _onDownloadEvent.cancel();
    // _streamController.close();
    print("@@@ MainTabPageState.dispose() ...");
  }

  _initMenu() {
    _lstName = [
      "home",
      "device",
      // "vedio",
      // "explore",
      "my",
    ];

    _lstTitle = [
      "首页",
      "设备",
      // "直播", //扫描
      // "发现",
      "我的",
    ];

    _lstPage = [
      HomePage(),
      DevicePage(),
      //Text('Scan'),
      // VideoPage(),
      // ExplorePage(),
      MyPage()
    ];

    _initNaviItem();
  }

  _initNaviItem() {
    _lstNaviItem = [];
    for (int i = 0; i < _lstName.length; i++) {
      _lstNaviItem.add(_getNaviItem(i));
    }
  }

  _getNaviItem(_index) {
    return GestureDetector(
        onTap: () {
          // _onNaviItemTap(_index);
          _onItemTap(_index);
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            //Icon(Icons.home, color: getColor(0)),
            _getNaviBarIcon(_index),
            Container(
              // alignment: _index==2?Alignment.bottomCenter:Alignment.center,
              margin: EdgeInsets.only(top: 3.0),
              child: Text(
                _lstTitle[_index],
                style: TextStyle(color: getColor(_index)),
              ),
            ),
          ],
        ));
  }

  _getNaviBarIcon(int index) {
    // if (index == 2) return SizedBox(height: 23.0,width: 1.0,);
    String path = "images/" +
        _lstName[index] +
        (index == _tabIndex ? ".png" : "_g.png"); //"images/unknow.png";

    Image image;
    //  = Image.asset(
    //   path,
    //   width: 24.0,
    //   height: 24.0,
    //   alignment: Alignment.bottomCenter,
    // );

    // if (index == 2) {
    //   image = Image.asset(
    //     path,
    //     color: Colors.transparent,
    //     width: 24.0,
    //     height: 24.0,
    //     alignment: Alignment.bottomCenter,
    //   );
    // } else {
    image = Image.asset(
      path,
      width: 24.0,
      height: 24.0,
      alignment: Alignment.bottomCenter,
    );
    // }
//  if (index == 2) image.color=Colors.;
    return image;
  }

  _downloadUpdateFile(urlpath, urlfile) {
    DialogBO.showCircleRunning(context, '下载 ... 0%');

    ApkHelper.tryOtaUpdate(urlpath, urlfile, (event) {
      print('@@@ MainTabPage.DownloadEvent() ${event.status} - ${event.value}');
      eventBus.fire(RunningEvent('下载 ... ${event.value}%'));
    });
  }
  // int page = 0;

  void onPageChanged(int value) {
    print("@@@ => MainTabPage.onPageChanged($value)");
    setState(() {
      // this.page = value;
      _tabIndex = value;
    });
  }

  Color getColor(int value) {
    return _tabIndex == value
        ? AppStyle.cpOpenColor
        : AppStyle.iosPopupTitleColor;
  }

  // void _onNaviItemTap(int value) {
  //   if(value==2) return;
  //   pageController.animateToPage(value,
  //       duration: const Duration(milliseconds: 100), curve: Curves.ease);
  // }
  // bool isSrceen = false;

  @override
  Widget build(BuildContext context) {
    // GlobalVar.initJPushSrv();
    // print("@@@ => MainTabPage.build() ... ");
    // if (!isSrceen) {
    //   isSrceen = true;
    //   GlobalVar.getScreenSize(context, 'MainTabPage');
    // }

    if (ApkHelper.isRun == 0) {
      ApkHelper.isRun = 1;
      Timer(Duration(seconds: 3), () {
        ApkHelper.getVersion(context);
      });
    }

    return WillPopScope(
        child: Scaffold(
          // key: ObjectKey("123"),
          // appBar: new AppBar(
          //   title: new Text("主页"),
          // ), Icon(Icons.memory,color: Colors.blue,size: Size(30.0, 30.0),),//
          //路由弹出/推送，屏幕尺寸调整，通常是由于键盘外观或方向改变,会导致整个widget重新rebuild，设置Scaffold 的 resizeToAvoidBottomInset 属性设置为 false
          // resizeToAvoidBottomInset:false,
          //MainBO.getPage(_tabIndex),  //会引起界面重刷
          body: IndexedStack(
            index: _tabIndex,
            children: _lstPage,
          ),
          // PageView(
          //   pageSnapping: false,
          //   children:
          //       _lstPage, // <Widget>[HomePage(), ForumPage(), NewsPage(), MinePage()],
          //   onPageChanged: onPageChanged,
          //   controller: pageController,
          // ),
          bottomNavigationBar: BottomAppBar(
            color: Color(0xFFF7F7F7), // Theme.of(context).accentColor,
            shape: CircularNotchedRectangle(),
            child: Padding(
              padding: EdgeInsets.fromLTRB(0, 6, 0, 6),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: _lstNaviItem,
              ),
            ),
          ),
          // floatingActionButton: FloatingActionButton(
          //   // focusColor: AppStyle.mainColor,
          //   elevation: 1.5,
          //   backgroundColor: AppStyle.mainColor, //Colors.deepOrangeAccent,
          //   onPressed: () {
          //     // ScanBO.scanQB(context);
          //     setState(() {
          //       _tabIndex = 2;
          //       _initNaviItem();
          //     });
          //   },
          //   child:
          //       //Image.asset('images/vedio.png',color: Colors.white,height: 28.0,width: 28.0,),
          //       Icon(
          //     Icons.videocam,
          //     color: Colors.white,
          //     size: 36.0,
          //   ),
          // ),
          // floatingActionButtonLocation:
          //     FloatingActionButtonLocation.centerDocked,
        ),
        onWillPop: () {
          int newTime = DateTime.now().millisecondsSinceEpoch;
          int result = newTime - lastTime;
          lastTime = newTime;
          if (result > 2000) {
            // Toast.show(context, '再按一次退出');
            AppToast.showToast('再按一次退出');
          } else {
            SystemNavigator.pop();
          }
          return null;
        });
  }

  _onItemTap(index) {
    // print("@@@ MainTabPage.onTap(index:$index)");
    //中间的大肥按钮
    // if (index == 2) return;
    setState(() {
      _tabIndex = index;
      _initNaviItem();
    });
    // if (index == 2) {
    //   ScanBO.scanQB(context);
    // } else {
    //   setState(() {
    //     if (index == 3 && GlobalVar.exploreState == 0) {
    //       eventBus.fire(PageDataEvent('explorepage'));
    //       GlobalVar.exploreState = 1;
    //     }
    //     _tabIndex = index;

    //     _initNaviItem();
    //   });

    // }
  }
}
