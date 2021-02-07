import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:ota_update/ota_update.dart';
import 'package:ovenapp/Classes/AppDialog.dart';
import 'package:ovenapp/Classes/SharePrefHelper.dart';
import 'package:ovenapp/Pages/PrivateTextPage.dart';
import 'package:ovenapp/Publics/GlobalVar.dart';
import 'package:package_info/package_info.dart';
// import 'package:ovenapp/Classes/AppDialog.dart';
// import 'package:ovenapp/Classes/AppToast.dart';
import 'package:ovenapp/Services/EventBusSrv.dart';

// import 'package:permission_handler/permission_handler.dart';
// import 'package:flutter_downloader/flutter_downloader.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:open_file/open_file.dart';

import 'package:ovenapp/Publics/DataHelper.dart';
import 'package:ovenapp/Classes/app_dialog_helper.dart';
// import 'package:ovenapp/Publics/GlobalVar.dart';

class ApkHelper {
  static int isRun = 0; //是否第一次运行过，为了不让app一启动就提取此处数据，加此标志；
  // static int checkcount = 0;
  // static String _apkurl; // = "https://www.cfdzkj.com/downloads/app/";
  // static String _apkfile = 'cleveroven.apk';

  // static String _localfile;
  // static String localfile =
  //     '/storage/emulated/0/Android/data/com.example.ovenapp/files/cleveroven.apk';
  static bool _isUpdate = false;
  static String version;
  static String appName;
  static String packageName;
  static String buildNumber;
  static String newversion;
//   Directory tempDir = await getTemporaryDirectory();
// String tempPath = tempDir.path;

// Directory appDocDir = await getApplicationDocumentsDirectory();
// String appDocPath = appDocDir.path;
  // static getLocalPath() async {
  //     appLocalPath = await _apkLocalPath;
  //      print('@@@ ApkHelper.getLocalPath() appLocalPath : $appLocalPath');
  //   // if (checkcount == 0) {
  //   //   // await FlutterDownloader.initialize();
  //   //   // print('@@@ ApkHelper.getLocalPath() _localpath : $_localpath');
  //   //   // await getAppVersion();
  //   //   print(
  //   //       '@@@ ApkHelper.getLocalPath() appName : $appName , packageName : $packageName , version : $version , buildNumber : $buildNumber');
  //   //   checkcount++;
  //   // }
  // }

  static getAppVersion() async {
    final PackageInfo info = await PackageInfo.fromPlatform();
    appName = info.appName;
    packageName = info.packageName;
    version = info.version;
    buildNumber = info.buildNumber;
  }

  static Future<void> tryOtaUpdate(
      String urlFile, String localFile, var callback) async {
    try {
      print(
          '@@@ ApkUpdate.tryOtaUpdate() urlFile : $urlFile, localFile : $localFile');
      //LINK CONTAINS APK OF FLUTTER HELLO WORLD FROM FLUTTER SDK EXAMPLES, var errCallback, var doneCallback
      OtaUpdate()
          .execute(urlFile, destinationFilename: localFile)
          .listen(callback);
      // callback, onError: errCallback, onDone: doneCallback,
      // (OtaEvent event) {
      //   // print('@@@ ApkUpdate.tryOtaUpdate() event: $event');
      //   // print('@@@ ApkUpdate.tryOtaUpdate() ${event.status} : ${event.value}');
      //   if(callback!=null)
      //     callback(event);
      //   // setState(() => currentEvent = event);
      // },

    } catch (e) {
      print('*** ApkUpdate.tryOtaUpdate() e: $e');
    }
  }

  static getVersion(context, [int ot = 0]) async {
    if (_isUpdate && ot == 0) return;
    _isUpdate = true;

    // isfinished = 0;

    // if (checkcount == 0) {
    //   FlutterDownloader.initialize(); //必须先初始化一下
    //   checkcount++;
    // }

    // getOS();

    if (GlobalVar.platForm == 0) {
      //   if (_localpath == null) _localpath = await _apkLocalPath;

      // bool _permissionReady = await _checkPermission(context);
      // print("@@@ ApkHelper.getVersion() _permissionReady : $_permissionReady");

      // await deleteApkFile();

      await DataHelpr.dataQuerier('SYSDT/ApkVersion', null, null, (rm) {
        if (rm.ret == 0) {
          newversion = rm.id.toString().trim();
          String lv = version.toString().trim();
          // print("@@@ ApkHelper.getVersion() oldversion : $lv , newversion : $newversion");
          if (newversion != lv) {
            Timer(Duration(milliseconds: 100), () {
              // _showUpdate(context, rm.message);
              _showUpdateDialog(context, rm.message);
            });
          } else {
            if (ot == 1) _showNoUpdate(context);
          }
        }
      });

      // DataHelpr.queryResult('SYSDT/ApkVersion', null, (rm) {
      //   if (rm.ret == 0) {
      //     newversion = rm.id.toString().trim();
      //     String lv = version.toString().trim();
      //     if (newversion != lv) {
      //       Timer(Duration(milliseconds: 100), () {
      //         _showUpdate(context, rm.message);
      //       });
      //     } else {
      //       if (ot == 1) _showNoUpdate(context);
      //     }
      //   }
      // });
    }
    _isUpdate = false;
  }

  showPrivate(context) async {
    String privateStr1 =
        '请你务必审慎阅读、充分理解“服务协议”和“隐私政策”各条款，包括但不限于：为了向你提供即时通讯、内容分享等服务，我们需要收集你的设备信息、操作日志等个人信息。你可以在“设置”中查看、变更、删除个人信息并管理你的授权。你可阅读';
    String privateStr2 = '了解详细信息。如你同意，请点击“同意”开始接受我们的服务。';

    List<ActionButtonModel> _lstAB = [];
    _lstAB.add(
        ActionButtonModel(id: 0, title: '暂不使用', foreColor: Colors.black87));
    _lstAB.add(ActionButtonModel(
        id: 1, title: '同意')); //,foreColor: CupertinoColors.systemBlue

    RichText rt = RichText(
      text: TextSpan(
          // style: DefaultTextStyle.of(context).style,
          style: TextStyle(
              color: Colors.black87, fontSize: 16.0, fontFamily: '.SF UI Text'),
          children: <InlineSpan>[
            TextSpan(text: privateStr1),
            TextSpan(
              text: '《服务协议》',
              style: TextStyle(color: Colors.blue[300]),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  print(
                      "@@@ AboutPage => _showPrivate.TapGestureRecognizer 《服务协议》");
                  Navigator.of(context).pop(2);
                },
            ),
            TextSpan(text: '和'),
            TextSpan(
              text: '《隐私政策》',
              style: TextStyle(color: Colors.blue[300]),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  print(
                      "@@@ AboutPage => _showPrivate.TapGestureRecognizer 《隐私政策》");
                  Navigator.of(context).pop(3);
                },
            ),
            TextSpan(text: privateStr2),
          ]),
    );

    var ret = await AppDiaglogHelper.showRichTextButtonsDialog(
        context, TitleTextModel(text: '服务协议和隐私政策'), rt, _lstAB);
    if (ret != null) {
      if (ret == 1)
        SharePrefHelper.saveData("privateprotect", 'agreed');
      else if (ret == 2)
        _showService(context, 0);
      else if (ret == 3) _showService(context, 1);
    }
    print("@@@ => AboutPage._showPrivate ret : $ret");
  }

  _showService(context, ft) {
    print("@@@ => AboutPage._showService($ft) ... ");
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => PrivateTextPage(
                  tt: ft,
                )));
  }

  static _showUpdate(context, String texts) {
    List<String> _lst = texts.split('@#');
    String _apkurl = _lst[_lst.length - 1];
    List<String> _lstf = _apkurl.split('/');
    String _apkfile = _lstf[_lstf.length - 1];

    // deleteApkFile();

    print(
        "@@@ ApkHelper._showUpdate() _apkurl : $_apkurl , _apkfile : $_apkfile");
    showUpdateIOS(context, '发现新版本', _lst, () {
      // downloadFile(_localpath, _apkurl, _apkfile);
      //  eventBus.fire(DownloadEvent('update', _localpath,_apkurl,_apkfile));_localpath + '/' +
      eventBus.fire(DownloadEvent('update', _apkurl, _apkfile));
    });
  }

  static _showUpdateDialog(context, String texts) async {
    List<String> _lst = texts.split('@#');
    String _apkurl = _lst[_lst.length - 1];
    List<String> _lstf = _apkurl.split('/');
    String _apkfile = _lstf[_lstf.length - 1];

    List<ActionButtonModel> _lstAB = [];
    _lstAB.add(ActionButtonModel(id: 0, title: '暂不升级', foreColor: Colors.grey));
    _lstAB.add(ActionButtonModel(
        id: 1,
        title: '立即升级',
        backgroundColor:
            Colors.yellowAccent)); //,foreColor: CupertinoColors.systemBlue

    List<ContentTextModel> _lstText = [];
    // _lst.forEach((s) {
    for (int i = 1; i < _lst.length - 1; i++) {
      _lstText.add(ContentTextModel(text: _lst[i]));
    }

    var ret = await AppDiaglogHelper.showTitleTextButtonsDialog(
        context, TitleTextModel(text: '发现新版本'), _lstText, _lstAB);
    print("@@@ ApkHelper => _showUpdateDialog ret : $ret");

    if (ret != null && ret == 1) {
      eventBus.fire(DownloadEvent('update', _apkurl, _apkfile));
    }
  }

  static _showNoUpdate(context) async {
    // AppDialog.showInfoIOS(context, '提示', '您当前使用的是最新版本 ！', Colors.green);
    List<ActionButtonModel> _lstAB = [];
    _lstAB.add(ActionButtonModel(
        id: 1, title: '确定')); //,foreColor: CupertinoColors.systemBlue

    List<ContentTextModel> _lstText = [ContentTextModel(text: '您当前使用的是最新版本！')];

    var ret = await AppDiaglogHelper.showTitleTextButtonsDialog(
        context, TitleTextModel(text: '提示'), _lstText, _lstAB);
    print("@@@ ApkHelper => _showNoUpdate ret : $ret");
  }

  // static deleteApkFile() async {
  //   _localfile = _localpath + '/' + _apkfile;
  //   print("@@@ ApkHelper._deleteApkFile() _localfile : $_localfile");
  //   File file = File(_localfile);
  //   if (await file.exists()) {
  //     await file.delete();
  //     print("@@@ ApkHelper._deleteApkFile() finished !");
  //   }
  // }

  // static List<String> _getUrlFile(String urlFile){
  //   List<String> _lst=[];
  //       _apkurl = _lst[_lst.length - 1];
  //   List<String> _lstf = urlFile.split('/');
  //   String urlfile = _lstf[_lstf.length - 1];
  // }

  static String taskid;
  static Future<dynamic> downloadFile(
      String localPath, String urlPath, String urlFile) async {
    // _localpath = await _apkLocalPath;
    // _localfile = _localpath + '/' + _apkfile;
    print(
        "@@@ ApkHelper.downloadFile() localFile : $localPath , urlPath : $urlPath, urlFile : $urlFile");

    File file = File(localPath);
    if (await file.exists()) await file.delete();

// print("@@@ ApkHelper._downloadFile() urlFile : $urlFile");

/*
 taskId = await FlutterDownloader.enqueue(
        url: _apkurl, //下载最新apk的网络地址
        savedDir: _localpath,
        fileName: _apkfile,
        showNotification: true,
        openFileFromNotification: true);
*/
    //下载
    // var taskId = await FlutterDownloader.enqueue(
    //     url: urlPath, //下载最新apk的网络地址
    //     savedDir: localPath,
    //     fileName: urlFile,
    //     showNotification: true,
    //     openFileFromNotification: true);

    // taskid = taskId.toString();

    // print("@@@ ApkHelper._downloadFile() taskId : $taskid");

    // return await FlutterDownloader.registerCallback(_downloadCallback);
    // await FlutterDownloader.loadTasks();
    // await FlutterDownloader.open(taskId: taskId);
    // FlutterDownloader.registerCallback((id, status, progress) {
    //   // 当下载完成时，调用安装
    //   if (taskId == id && status == DownloadTaskStatus.complete) {
    //     print("@@@ ApkHelper._downloadFile() taskId : $taskId");
    //     _installApk();
    //   }
    // });
  }

  // static _downloadCallback(id, status, progress) {
  //   // 当下载完成时，调用安装
  //   //status => undefined,enqueued,running,complete,failed,canceled,paused
  //   print(
  //       "@@@ ApkHelper._downloadCallback() id : $id , status : ${status.toString()} , progress : $progress");
  //   // if (taskId == id && status == DownloadTaskStatus.complete) {
  //   // if (taskId == id && status == DownloadTaskStatus.complete) {  // progress == 100
  //   if (progress == 100) {
  //     print("@@@ ApkHelper._downloadCallback() taskId : $id was finished !");

  //     installApk(localfile);
  //     // AppToast.showToast('下载完成！');
  //     // eventBus.fire(DownloadedEvent('update', localfile));
  //     // Timer(Duration(seconds: 5), () {
  //     // _showInstallIOS(_localfile);
  //     // });
  //   }
  // }

  // static Future<String> get _apkLocalPath async {
  //   final directory = await getExternalStorageDirectory();
  //   return directory.path;
  // }

  // static installApk(apkfile, [int sec = 2]) {
  //   isfinished = 1;
  //   // String path = await _apkLocalPath;path + '/' + _apkfile
  //   print("@@@ ApkHelper._installApk() apkfile : $apkfile , isfinished : $isfinished");
  //   Timer(Duration(seconds: sec), () {
  //     eventBus.fire(DownloadedEvent('update', apkfile));
  //     // OpenFile.open(apkfile);
  //   });
  // }

  // static setupApk(apkfile) {
  //   // String path = await _apkLocalPath;path + '/' + _apkfile
  //   print("@@@ ApkHelper._installApk() apkfile : $apkfile");
  //   // FlutterDownloader.open(taskId: taskId);
  //   // Timer(Duration(seconds: 1), () {
  //   //   OpenFile.open(apkfile);
  //   // });
  // }

  static showUpdateIOS(
      BuildContext context, String title, List<String> lstText, var callback) {
    var _lst = _getUpdateText(context, lstText);
    _lst.add(Container(
      height: 50.0,
      margin: EdgeInsets.only(top: 15.0),
      decoration: BoxDecoration(
        border: Border(
            top: BorderSide(color: Colors.grey[400], width: 1.0)), //灰色的一层边框
        // border:
        //     Border.all(color: AppStyle.clTitleBC, width: 1.0),
        // color: Colors.white,
        // borderRadius: BorderRadius.all(Radius.circular(5.0)),
      ),
      // color: Colors.tealAccent,
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              color: Colors.yellow,
              height: double.infinity,
              child: FlatButton(
                child: Text(
                  '立即升级',
                  style: TextStyle(color: Colors.black87, fontSize: 16.0),
                ),
                onPressed: () {
                  callback();
                  Navigator.of(context).pop();
                },
              ),
            ),
          ),
          Container(
              height: double.infinity, width: 1.0, color: Colors.grey[400]),
          Expanded(
            child: FlatButton(
              child: Text(
                '暂不升级',
                style: TextStyle(color: Colors.black87, fontSize: 16.0),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
        ],
      ),
    ));
    showDialog<Null>(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(
                  top: 10.0, left: 0.0, right: 0.0, bottom: 10.0),
              padding: EdgeInsets.only(top: 5.0, bottom: 5.0, left: 0.0),
              height: 50.0,
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.black87,
                  fontWeight: FontWeight.normal,
                ),
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
            content: Column(
              children:
                  // <Widget>[
                  _lst,
              // ],
            ),
            // actions: <Widget>[
            //   CupertinoDialogAction(
            //     child: Text('立即升级'),
            //     onPressed: () {
            //       // print('yes...');
            //       callback();
            //       Navigator.of(context).pop();
            //     },
            //   ),
            //   CupertinoDialogAction(
            //     child: Text('暂不升级'),
            //     onPressed: () {
            //       // print('no...');
            //       Navigator.of(context).pop();
            //     },
            //   ),
            // ],
          );
        });
  }

  static _getUpdateText(context, lstText) {
    var _lst = <Widget>[];
    for (int i = 1; i < lstText.length - 1; i++) {
      var g = Container(
        // color: Colors.cyanAccent,
        height: 30.0,
        width: double.infinity,
        margin: EdgeInsets.only(left: 25.0),
        alignment: Alignment.centerLeft,
        // color: Colors.orangeAccent,
        child: Text(
          lstText[i],
          style: TextStyle(color: Colors.black45, fontSize: 16.0),
          textAlign: TextAlign.left,
        ),
      );

      _lst.add(g);
      // if (i != (lstText.length - 1)) {
      //   _lst.add(Container(
      //     height: 1,
      //     color: Colors.grey[400],
      //   ));
      // }
    }

    return _lst;
  }

  // 申请权限
  // static Future<bool> _checkPermission(context) async {
  //   // 先对所在平台进行判断
  //   if (Theme.of(context).platform == TargetPlatform.android) {
  //     PermissionStatus permission = await PermissionHandler()
  //         .checkPermissionStatus(PermissionGroup.storage);
  //     if (permission != PermissionStatus.granted) {
  //       Map<PermissionGroup, PermissionStatus> permissions =
  //           await PermissionHandler()
  //               .requestPermissions([PermissionGroup.storage]);
  //       if (permissions[PermissionGroup.storage] == PermissionStatus.granted) {
  //         return true;
  //       }
  //     } else {
  //       return true;
  //     }
  //   } else {
  //     return true;
  //   }
  //   return false;
  // }

  // // 获取存储路径
  // Future<String> _findLocalPath(context) async {
  //   // 因为Apple没有外置存储，所以第一步我们需要先对所在平台进行判断
  //   // 如果是android，使用getExternalStorageDirectory
  //   // 如果是iOS，使用getApplicationSupportDirectory
  //   final directory = Theme.of(context).platform == TargetPlatform.android
  //       ? await getExternalStorageDirectory()
  //       : await getApplicationSupportDirectory();
  //   return directory.path;
  // }

  static getOS() {
    if (Platform.isIOS)
      print(
          "@@@ ApkHelper.getOS() IOS => Platform.version : ${Platform.version}");
    else if (Platform.isAndroid)
      print(
          "@@@ ApkHelper.getOS() Android => Platform.version : ${Platform.version}");
    else if (Platform.isWindows)
      print(
          "@@@ ApkHelper.getOS() Windows => Platform.version : ${Platform.version}");
    else
      print(
          "@@@ ApkHelper.getOS() Unknow => Platform.version : ${Platform.version}");
    //  if (Platform.isIOS) {
    //                   return permission != PermissionGroup.unknown &&
    //                       permission != PermissionGroup.sms &&
    //                       permission != PermissionGroup.storage &&
    //                       permission !=
    //                           PermissionGroup.ignoreBatteryOptimizations &&
    //                       permission != PermissionGroup.accessMediaLocation;
    //                 } else {
    //                   return permission != PermissionGroup.unknown &&
    //                       permission != PermissionGroup.mediaLibrary &&
    //                       permission != PermissionGroup.photos &&
    //                       permission != PermissionGroup.reminders;
    //                 }
  }
}

/*
subprojects {
    project.configurations.all {
        resolutionStrategy.eachDependency { details ->
            if (details.requested.group == 'com.android.support'
                    && !details.requested.name.contains('multidex') ) {
                details.useVersion "27.1.1"
            }
        }
    }
}


        <!-- <provider
            android:name="vn.hunghd.flutterdownloader.DownloadedFileProvider"
            android:authorities="${applicationId}.flutter_downloader.provider"
            android:exported="false"
            android:grantUriPermissions="true">
            <meta-data
                android:name="android.support.FILE_PROVIDER_PATHS"
                android:resource="@xml/provider_paths"/>
        </provider> -->

*/
