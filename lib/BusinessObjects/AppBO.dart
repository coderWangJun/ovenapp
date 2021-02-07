import 'package:flutter/material.dart';
// import 'package:ovenapp/Classes/AppDialog.dart';
import 'package:ovenapp/Classes/SharePrefHelper.dart';
// import 'package:ovenapp/Publics/DataHelper.dart';
import 'package:ovenapp/Publics/GlobalVar.dart';
// import 'package:ovenapp/Services/EventBusSrv.dart';

class AppBO {
  static clearUserData() async {
    if (GlobalVar.userInfo == null) return; //已经清理过了

    GlobalVar.userInfo = null;
    // await SharePrefHelper.clearData();
    await SharePrefHelper.removeData(GlobalVar.spuser);
    GlobalVar.lstDevice.clear();
    GlobalVar.lstControlPanel.clear();
    if (GlobalVar.mqttClass != null) GlobalVar.mqttClass.clearSubscribe();

    // if (GlobalVar.jpushClass != null) {
    //   GlobalVar.jpushClass.cleanTags();
    //   GlobalVar.jpushClass.hasSetTags = false;
    // }
  }

//登录成功后初始化用户数据
  static initUserData() async {
    await GlobalVar.initMqttSrv();

    String jsonStr = GlobalVar.userInfo.tojson();
    // print("@@@ AppBO.initUserData() userInfo => " + jsonStr);
    // _saveLoginInfoo(userInfo);
    if (jsonStr != null && jsonStr != "") {
      // await SharePrefHelper.clearData();
      await SharePrefHelper.saveData(GlobalVar.spuser, jsonStr);
    }

//关掉启动导航页
    await SharePrefHelper.saveData(GlobalVar.spintroslide, 'OK');

    await GlobalVar.mqttClass.addSubscribe(GlobalVar.mqttClass.subTopic);
    await GlobalVar.mqttClass.addSubscribe(
        GlobalVar.mqttClass.subTopic + '/' + GlobalVar.userInfo.loginid);

    // eventBus.fire(LoginEvent());

    GlobalVar.mqttClass.openSubscribeTimer();

    //初始极光插件
    // if (GlobalVar.jpushClass != null)
    //   GlobalVar.jpushClass.initJP();
    // else {
    //   if (!GlobalVar.jpushClass.hasSetTags) GlobalVar.jpushClass.setTags();
    // }
  }

  static goLogin(context) {
    Navigator.of(context).pushNamed('/login');
  }

  static get43Height(double dWidht) {
    return (dWidht * 3) / 4;
  }

  static get43Width(double dHeight) {
    return (dHeight * 4) / 3;
  }

  static getPower(int sec, int power) {
    if (sec == 0 || power == 0) return 0.0;
    return (sec.toDouble() / 3600) * (power.toDouble() / 1000);
    // ).toStringAsFixed(1);
  }
}
