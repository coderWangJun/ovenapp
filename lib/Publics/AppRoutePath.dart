import 'package:flutter/material.dart';
import 'package:ovenapp/LoginPage.dart';
import 'package:ovenapp/Pages/AboutPage.dart';
import 'package:ovenapp/Pages/ChangePwdPage.dart';
import 'package:ovenapp/Pages/ControlPanelPage.dart';
import 'package:ovenapp/Pages/DeviceDetailPage.dart';
import 'package:ovenapp/Pages/DevicePage.dart';
import 'package:ovenapp/Pages/HomePage.dart';
import 'package:ovenapp/Pages/MainTabPage.dart';
import 'package:ovenapp/Pages/MaintainPage.dart';
import 'package:ovenapp/Pages/MyPage.dart';
import 'package:ovenapp/Pages/MySettingsPage.dart';
import 'package:ovenapp/Pages/MySharePage.dart';
import 'package:ovenapp/Pages/NewsListPage.dart';
import 'package:ovenapp/Pages/ScanPage.dart';
import 'package:ovenapp/Pages/SliverAppBarDemo1.dart';
import 'package:ovenapp/Pages/TabDemoPage.dart';
import 'package:ovenapp/Pages/TemplateListPage.dart';
import 'package:ovenapp/Pages/TimeSectionEditPage.dart';
import 'package:ovenapp/Pages/WebViewerPage.dart';

// import 'package:ovenapp/Publics/GlobalVar.dart';
//可以传参数  '/sign': (context, {arguments}) => SignPage(arguments: arguments),
var appRoutePath = {
  '/login': (BuildContext context) => LoginPage(),
  '/maintab': (BuildContext context) => MainTabPage(),
  '/home': (BuildContext context) => HomePage(),
  '/device': (BuildContext context) => DevicePage(),
  '/my': (BuildContext context) => MyPage(),
  '/scan': (BuildContext context) => ScanPage(),
  "/templatelist": (BuildContext context) => TemplateListPage(),
  "/devicedetail": (BuildContext context) => DeviceDetailPage(),
  '/newslist': (BuildContext context) => NewsListPage(),
  '/mysettings': (BuildContext context) => MySettingsPage(),
  '/controlpanel': (BuildContext context) => ControlPanelPage(),
  '/tabdemo': (BuildContext context) => TabDemoPage(),
  '/webviewer': (BuildContext context) => WebViewerPage(),
  '/timesectionedit': (BuildContext context) => TimeSectionEditPage(),
  '/sliverappbardemo1': (BuildContext context) => SliverAppBarDemo1(),
  '/maintain': (BuildContext context) => MaintainPage(),
  '/about': (BuildContext context) => AboutPage(),
  '/changepwd': (BuildContext context) => ChangePwdPage(),
  '/myshare': (BuildContext context) => MySharePage(),
  
  // "/webview": (_) => WebviewScaffold(
  //       url: GlobalVar.cururl,
  //       appBar: AppBar(
  //         title: Text(GlobalVar.cururltitle),
  //       ),
  //       // resizeToAvoidBottomInset: true,
  //       withJavascript: true,
  //       withLocalStorage: true,
  //       withZoom: true,
  //       appCacheEnabled: true,
  //     ),
};
