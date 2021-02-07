import 'dart:io';
import 'package:flutter/material.dart';
import 'package:ovenapp/BusinessObjects/AppBO.dart';
import 'package:ovenapp/Classes/ApkHelper.dart';
import 'package:ovenapp/Classes/AppDialog.dart';
import 'package:ovenapp/Classes/app_dialog_helper.dart';
// import 'package:ovenapp/Classes/SharePrefHelper.dart';
import 'package:ovenapp/Publics/AppStyle.dart';
import 'package:ovenapp/Publics/DataHelper.dart';
import 'package:ovenapp/Publics/GlobalVar.dart';

class MySettingsPage extends StatefulWidget {
  MySettingsPage({Key key}) : super(key: key);

  @override
  _MySettingsPageState createState() => _MySettingsPageState();
}

class _MySettingsPageState extends State<MySettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppStyle.clTitleBC,
        // leading: _getLeading(),
        title: Text('设置'),
        // actions: _getActions(),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: _getContentList(context),
          ),
        ),
      ),
    );
  }

  _getContentList(context) {
    List<Widget> _lst = List<Widget>();
    _lst.add(SizedBox(
      height: 15.0,
    ));
    List<String> _lstParam = [
      '昵称',
      '绑定手机号码',
      // '切换帐号',
      '退出登录',
      '修改密码',
      // '检查更新',
      // '关于',
      '注销帐号',
    ];

    for (int i = 0; i < _lstParam.length; i++) {
      _lst.add(_getListItem(context, _lstParam[i]));
      _lst.add(Divider(
        indent: 20.0,
        endIndent: 20.0,
      ));
    }

    return _lst;
  }

  _getListItem(context, String name) {
    IconData id;
    switch (name) {
      case "昵称":
        id = Icons.account_box;
        break;
      case "绑定手机号码":
        id = Icons.phone;
        break;
      case "修改密码":
        id = Icons.vpn_key;
        break;
      case "退出登录":
        id = Icons.directions_run;
        break;
      // case "切换帐号":
      //   id = Icons.transfer_within_a_station;
      //   break;
      case "检查更新":
        id = Icons.cloud_download;
        break;
      case "关于":
        id = Icons.mood;
        break;
      case "注销帐号":
        id = Icons.cancel;
        break;
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
        color: AppStyle.mainColor, //  Colors.blue[500],
      ),
      title: Text(
        name,
        style: TextStyle(color: Colors.grey, fontSize: 18.0),
      ),
      selected: true,
      trailing: Icon(
        Icons.keyboard_arrow_right,
        color: Colors.grey[300],
        size: 30.0,
      ),
      onTap: () {
        _goToList(context, name);
      },
    );
  }

  _goToList(context, String name) async {
    // print("@@@ _goToList() 转到列表 $name");

    String route = '';
    switch (name) {
      case "昵称":
        // route = '/templatelist';
        _setName();
        return;
        break;
      case "绑定手机号码":
        route = '/repairlist';
        break;
      case "修改密码":
        _changedPwd();
        return;
        break;
      case "退出登录":
        var ret = await AppDiaglogHelper.showYesNoDialog(context, '您确定退出登录吗？');
        if (ret != null && ret == 1) {
          AppBO.clearUserData();
          Navigator.of(context).pop('logout');
        }
        break;
      case "切换帐号":
        _goToLogin();
        break;
      case "检查更新":
        if (Platform.isAndroid) ApkHelper.getVersion(context, 1);
        break;
      case "关于":
        // route = '/about';
        AppDialog.showYesNoIOS(context, '确认', '您确定退出登录吗？', null);
        break;
      case "注销帐号":
        var ret = await AppDiaglogHelper.showYesNoDialog(
            context, '帐号注销后所有资料将永久丢失，您确定注销帐号吗？');
        if (ret != null) {
          print('@@@ MySettingsPage._goToList  ret : $ret');
          if (ret == 1) {
            Map<String, dynamic> param = {
              "ccode": '0000',
            };
            await DataHelpr.dataHandler('Login/Logoff', param, (rm) {
              DataHelpr.resultHandler(rm, () {
                AppBO.clearUserData();
                Navigator.of(context).pop('logoff');
              });
            });
          }
        }
        return;
        break;
      default:
        return;
    }

    if (route != '') {
      Navigator.of(context).pushNamed(route);
    }
  }

  _setName() {
    AppDialog.showTextFieldIOS(context, '请输入昵称', '', (ret) {
      if (ret == null ||
          ret.toString().trim() == '' ||
          ret == GlobalVar.userInfo.name) return;

      Map<String, dynamic> param = {"Name": ret};

      DataHelpr.dataHandler('Client/Modify', param, (rm) {
        print('@@@ ControlPanelPage._setName  rm.ret : ${rm.ret}');

        DataHelpr.resultHandler(rm, () {
          GlobalVar.userInfo.name = ret;
        });
      });
    });
  }

  _changedPwd() {
    Navigator.of(context).pushNamed('/changepwd');
  }

  // _showInstallIOS(apkfile) {
  //   AppDialog.showYesNoIOS(context, '提示', '文件下载完成，是否打开？', () {
  //     ApkHelper.installApk(apkfile);
  //   });
  // }

  _goToLogin() {
    Navigator.of(context).pushNamed('/login').then((ret) {
      if (ret != null && ret.toString() == 'OK') {
        Navigator.of(context).pop();
      }
    });
  }

  // _clearUserData() {
  //   GlobalVar.userInfo = null;
  //   GlobalVar.lstDevice.clear();
  //   GlobalVar.lstControlPanel.clear();
  //   GlobalVar.mqttClass.clearSubscribe();
  // }
}
