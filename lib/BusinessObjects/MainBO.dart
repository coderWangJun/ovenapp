import 'package:flutter/material.dart';
import 'package:ovenapp/BusinessObjects/ScanBO.dart';
import 'package:ovenapp/Pages/ExplorePage.dart';
import 'package:ovenapp/Publics/AppStyle.dart';
// import '../Publics/GlobalVar.dart';

import '../Pages/HomePage.dart';
import '../Pages/DevicePage.dart';
import '../Pages/ScanPage.dart';
// import '../Pages/MaintainPage.dart';
import '../Pages/MyPage.dart';

class MainBO {
  MainBO({this.context});
  final BuildContext context;

  // static String curTag = "home";
  static int curIndex = 0;

  // static Map<String, String> mapTag = {
  //   "home": "首页",
  //   "device": "设备",
  //   "scan": "扫描", //扫描
  //   "maintain": "维修",
  //   "my": "我的",
  // };

  static List<String> lstModule = [
    "home",
    "device",
    "scan",
    "explore",
    "my",
  ];

  static List<String> lstCModule = [
    "首页",
    "设备",
    "扫描",
    "发现",
    "我的",
  ];

  static Map<int, Widget> mapPage = Map();

  static void initNaviBarData() {
    mapPage.clear();

    for (int i = 0; i < lstModule.length; i++) {
      // lstNaviBarItems.add(_getNaviBarItem(lstModule[i]));
      mapPage[i] = _getPage(lstModule[i]);
    }
  }

  static HomePage _homePage;
  static DevicePage _devicePage;
  static ScanPage _scanPage;
  static ExplorePage _explorePage;
  static MyPage _myPage;

  static Widget getPage(int index) {
    return _getPage(lstModule[index]);
  }

  static Widget _getPage(String tag) {
    Widget w;
    switch (tag) {
      case "home":
        if (_homePage == null) {
          _homePage = new HomePage();
          print("@@@ MainBO._getPage() => new HomePage()");
        }
        w = _homePage;
        break;
      case "device":
        if (_devicePage == null) {
          _devicePage = new DevicePage();
          print("@@@ MainBO._getPage() => new DevicePage()");
        }
        w = _devicePage;
        break;
      case "scan":
        // w = new ScanPage();
        // ScanBO.scanQB();
        // if (_scanPage == null) {
        //   _scanPage = new ScanPage();
        //   print("@@@ MainBO._scanPage() => new DevicePage()");
        // }
        // w = _devicePage;
        w=Text("ScanPage");
        break;
      case "explore":
        if (_explorePage == null) {
          _explorePage = new ExplorePage();
          print("@@@ MainBO._getPage() => new ExplorePage()");
        }
        w = _explorePage;
        break;
      // case "maintain":
      //   if (_maintainPage == null) {
      //     _maintainPage = new MaintainPage();
      //     print("@@@ MainBO._getPage() => new MaintainPage()");
      //   }
      //   w = _maintainPage;
      //   break;
      case "my":
        if (_myPage == null) {
          _myPage = new MyPage();
          print("@@@ MainBO._getPage() => new MyPage()");
        }
        w = _myPage;
        break;
    }
    // print("@@@ MainClass._getPage() tag => " + tag);
    return w;
  }

  static List<Widget> getPageList(int index) {
    // print("@@@ MainBO.getPageList() _tabIndex => " + index.toString());
    // if (lstWP[index] == null)
    // lstWP[index] = getPage(index);
    // return lstWP;
    List<Widget> lst = new List<Widget>();
    for (int i = 0; i < lstModule.length; i++) {
      // lst.add(_getPage(lstModule[i]));
      lst.add(getPage(i));
    }
    return lst;
  }
  // static List<BottomNavigationBarItem> lstNaviBarItems = [];

  static List<BottomNavigationBarItem> getNaviBarItems(int index) {
    // print("@@@ MainBO.getNaviBarItems() _tabIndex => " + index.toString());
    curIndex = index;
    List<BottomNavigationBarItem> lst = [];
    for (int i = 0; i < lstModule.length; i++) {
      // lst.add(_getNaviBarItem(lstModule[i]));
      lst.add(BottomNavigationBarItem(
          // icon: getTabIcon(0),
          // backgroundColor: Colors.redAccent,
          icon: _getNaviBarIcon(i),
          title: _getNaviBarTitle(i)));
    }
    return lst;
  }

  // static BottomNavigationBarItem _getNaviBarItem(String tag) {
  //   return new BottomNavigationBarItem(
  //       // icon: getTabIcon(0),
  //       icon: _getNaviBarIcon(tag),
  //       title: _getNaviBarTitle(tag));
  // }
// static int curIndex=0;
  static Image _getNaviBarIcon(int index) {
    String path = "images/unknow.png";
    // if (mapTag.containsKey(tag)) {
    if (index == curIndex)
      path = "images/" + lstModule[index] + ".png";
    else
      path = "images/" + lstModule[index] + "_g.png";
    // }

    return Image.asset(path, width: 24.0, height: 24.0,alignment: Alignment.bottomCenter,);
  }

  static Widget _getNaviBarTitle(int index) {
    // if (mapTag.containsKey(tag)) {
    if (index == curIndex) {
      return Text(lstCModule[index],
          style: TextStyle(color: AppStyle.mainColor, fontSize: 14.0,fontFamily: 'LanTing'));
    } else {
      return Text(lstCModule[index],
          style: TextStyle(color: Color(0xFF2B2B2B), fontSize: 14.0,fontFamily: 'LanTing'));
    }
    // } else {Container(color: Colors.deepOrangeAccent,child: 
    //   return new Text("未知",,fontWeight: FontWeight.bold,fontWeight: FontWeight.bold
    //       style: new TextStyle(color: Color(0xff4c4c4c), fontSize: 13.5));
    // }
  }

  // static Image _getNaviBarIcon(String tag) {
  //   String path = "images/unknow.png";
  //   if (mapTag.containsKey(tag)) {
  //     if (tag == curTag)
  //       path = "images/" + tag + ".png";
  //     else
  //       path = "images/" + tag + "_g.png";
  //   }

  //   return new Image.asset(path, width: 24.0, height: 24.0);
  // }

  // static Widget _getNaviBarTitle(String tag) {
  //   if (mapTag.containsKey(tag)) {
  //     if (tag == curTag) {
  //       return new Text(mapTag[tag],
  //           style: new TextStyle(color: GlobalVar.mainColor, fontSize: 13.5));
  //     } else {
  //       return new Text(mapTag[tag],
  //           style: new TextStyle(color: Color(0xff4c4c4c), fontSize: 13.5));
  //     }
  //   } else {
  //     return new Text("未知",
  //         style: new TextStyle(color: Color(0xff4c4c4c), fontSize: 13.5));
  //   }
  // }
}
