import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

// import 'package:flutter/rendering.dart';
import 'package:ovenapp/BusinessObjects/DialogBO.dart';
// import 'package:ovenapp/Classes/JPushClass.dart';
import 'package:ovenapp/Classes/MediaPlayer.dart';
import 'package:ovenapp/Classes/MqttClass.dart';
import 'package:ovenapp/Classes/SharePrefHelper.dart';
import 'package:ovenapp/Models/AdvertModel.dart';
import 'package:ovenapp/Models/ControlPanelModel.dart';
import 'package:ovenapp/Models/DeviceModel.dart';
import 'package:ovenapp/Models/MqttDataModel.dart';
import 'package:ovenapp/Models/NewsModel.dart';
import 'package:ovenapp/Models/PowerModel.dart';
import 'package:ovenapp/Models/TModel.dart';
import 'package:ovenapp/Models/TemplateModel.dart';
import 'package:ovenapp/Services/EventBusSrv.dart';

import '../Models/UserModel.dart';
import '../Classes/MqttClass.dart';

class GlobalVar {
  // static String apkversion='1.0.0';
// 系统
  static int platForm = 0; //app系统类型，0 Android，1 IOS，2 Windows，3 unknow

  static _getOS() {
    if (Platform.isIOS)
      platForm = 1;
    else if (Platform.isAndroid)
      platForm = 0;
    else if (Platform.isWindows)
      platForm = 2;
    else
      platForm = 3;
    print("@@@ GlobalVar._getOS() platForm : $platForm");
  }

  static double dScreenHeight = 0.0;
  static double dScreenWidth = 0.0;
  static getScreenSize(BuildContext context) {
    dScreenWidth = MediaQuery.of(context).size.width;
    dScreenHeight = MediaQuery.of(context).size.height;
    print(
        "@@@ GlobalVar.getScreenSize() dScreenWidth : $dScreenWidth , dScreenHeight : $dScreenHeight");
  }
  //  static getScreenSize(BuildContext context, String caller) {
  //   dScreenWidth = MediaQuery.of(context).size.width;
  //   dScreenHeight = MediaQuery.of(context).size.height;
  //   print(
  //       "@@@ GlobalVar.getScreenSize() $caller => dScreenWidth : $dScreenWidth , dScreenHeight : $dScreenHeight");
  // }

//数据分页
  static int pagesize = 10;
  static int refreshtime = 30; //刷新的时间间隔

  //本地临时文件路径
  static String appLocalPath = '';

  //全局变量
  static UserModel userInfo;
  // static String cururl = "https://www.cfdzkj.com";
  static String cururltitle = "动态内容";
  static String webimageurl = "https://www.cfdzkj.com:811/webimages/";
  // static String assetimage = 'images/camera.png';

  //关于
  static int hasreadprivateprotect = 0; //是否已经读过隐私保护指引,0读过，1未读

  //本地缓存文件
  static String spprivateservice = "privateprotect";
  static String spadvert = "advert";
  static String spmaterial = "material";
  static String spnews = "news";
  static String spdevice = "device";
  static String splogin = "login";
  static String sptemplate = 'template';
  static String spsection = 'section';
  static String spintroslide = 'introslide';
  static String spexplore = 'explore';
  static String spvedio = 'vedio';
  static String sppower = 'power';
  static String spuser = 'userinfo';

  //wifi参数
  static String wifissid = '';
  static String wifipwd = '';

  //网页变量
  static int exploreState = 0;

  //MQTT
  static MqttClass mqttClass; //= new MqttClass(userInfo.loginid);

  static initMqttSrv() {
    if (GlobalVar.userInfo == null || mqttClass != null) return;
    // print("@@@ => GlobalVar.initMqttSrv() ...");
    mqttClass = MqttClass();
    mqttClass.connect();
    // mqttClass.subscribe("/oven/app/13237199233");
  }

  static sendOrder(topic, msg) {
    if (mqttClass != null && mqttClass.mqttClientState == 'connected') {
      // print("@@@ GlobalVar.sendOrder() topic : $topic , orderstr : $msg");
      mqttClass.publishMessage(topic, msg);
    } else {
      print(
          "*** GlobalVar.sendOrder()  mqttClass : $mqttClass ,  mqttClass.mqttClientState : ${mqttClass?.mqttClientState}");
    }
  }

  // 主板最后一次得到的上传数据
  static Map<String, MqttDataModel> mpMqttData = {};

  static bool isControlPanelOpen = false;
  static bool isAPConnected = false;

  //极光推送
  // static JPushClass jpushClass;
  // static initJPushSrv() {
  //   if (jpushClass == null) jpushClass = JPushClass();
  // }

  static _apkLocalPath() async {
    if (Platform.isAndroid) {
      var directory = await getExternalStorageDirectory();
      if (directory != null) appLocalPath = directory.path + '/';
      // print("@@@ GlobalVar._apkLocalPath() appLocalPath : $appLocalPath");
    } else
      appLocalPath = '';
  }

  //用户管理
  static initUserInfo() async {
    _getOS();
    await _apkLocalPath();
    String privateprotext = await SharePrefHelper.getData("privateprotect");
    if (privateprotext != null && privateprotext.isNotEmpty)
      hasreadprivateprotect = 1;

    if (userInfo != null) return;
    String spfile = spuser;
    String jsonData = await SharePrefHelper.getData(spfile);

    //  print("@@@ => GlobalVar.initUserInfo() SharePrefHelper.getData($spfile) jsonData : $jsonData");
    // if (SharePrefHelper.getData("userinfo")) {
    bool isDelete = true;

    if (jsonData != null && jsonData.trim() != "") {
      // print("@@@ => GlobalVar.initUserInfo() jsonData : $jsonData");
      try {
        Map<String, dynamic> ps = json.decode(jsonData);
        if (ps != null) {
          UserModel ui = UserModel.fromjson(ps);
          if (ui != null && ui.tk != "") {
            userInfo = ui;
            isDelete = false;
            // print(
            //     "@@@ GlobalVar.initUserInfo() userInfo : ${userInfo.tojson()}");
            GlobalVar.initMqttSrv();
          }
        }
      } catch (e) {
        print("*** GlobalVar.initUserInfo() e : $e");
        await SharePrefHelper.removeData(spfile);
      }
      // } else
      //   SharePrefHelper.removeData('userinfo');
      // }

      if (isDelete) SharePrefHelper.removeData('userinfo');
    }
  }

  static Map<String, dynamic> tempData = {};
  static String warnfile;
  //音频播放器
  static MediaPlayer mediaPlayer;
  static String uuid;

  static playWarnAudio(context, cid) {
    if (mediaPlayer == null) {
      warnfile = GlobalVar.webimageurl + 'm2.mp3';
      mediaPlayer = MediaPlayer((event) {
        //
      });
    }

    if (mediaPlayer.isrunning == 1 || MediaPlayer.isloop == 1) return;
    uuid = cid;
    mediaPlayer.loop(warnfile);
    DialogBO.showAudioWarn(context, 24 * 60 * 60);
  }

  static closeWarnAudio() {
    if (mediaPlayer == null) {
      return;
    }
    mediaPlayer.stop();
    eventBus.fire(WarnCloseEvent());
    String orderstr = '{"state":1}';
    print("@@@ _sendOrder()  orderstr : $orderstr");
    GlobalVar.mqttClass.publishMessage("/oven/device" + uuid, orderstr);
  }

  //设备与主板
  static Map<String, DeviceModel> lstDevice = {};
  static Map<String, ControlPanelModel> lstControlPanel = {};
  static Map<String, PowerModel> lstPower;

  //模板数据
  static Map<int, TemplateModel> lstTemplate; //为null表示还没有从服务端提取过数据

  //首页数据
  static Map<int, NewsModel> lstAdvert;
  static Map<int, TModel> lstT;
  static Map<int, NewsModel> lstNews;

  //临时调试参数
  static int isPrintMqttData = 0;
}

// SharedPreferences prefs = await SharedPreferences.getInstance();
// class GlobalVar{
//   static var bodys= [new HomePage(), new SchoolAffairsPage(),new MailBoxPage(),  new MyPage()];
// }
// var bodys= [new HomePage(), new SchoolAffairsPage(),new MailBoxPage(),  new MyPage()];
