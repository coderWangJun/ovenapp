// import 'dart:mirrors';

import 'package:ovenapp/Classes/AppToast.dart';

class AppObjHelper {
  static getJsonStrFormObj(obj) {
    // var rt = obj.runtimeType;
    print(
        '@@@ AppObjHelper.getJsonStrFormObj($obj) runtimeType : ${obj.runtimeType}');
    print('@@@ AppObjHelper.getJsonStrFormObj($obj) : ${obj.toString()}');
// InstanceMirror instance_mirror = reflect(t);
//     var class_mirror = instance_mirror.type;

//     for (var v in class_mirror.declarations.values) {

//         var name = MirrorSystem.getName(v.simpleName);

//         if (v is VariableMirror) {
//             print("Variable: $name => S: ${v.isStatic}, P: ${v.isPrivate}, F: ${v.isFinal}, C: ${v.isConst}");
//         } else if (v is MethodMirror) {
//             print("Method: $name => S: ${v.isStatic}, P: ${v.isPrivate}, A: ${v.isAbstract}");
//         }

//     }
  }

  static checkQRCode(String rowStr) {
    // print("@@@ AppObjHelper.getQRCode($rowStr)");
    if (rowStr == null) {
      AppToast.showToast("无效的二维码！");
      return null;
    }

    String qr = rowStr.trim();
    // print(
    //     "@@@ AppObjHelper.checkQRCode() qr : $qr , qr.length : ${qr.length} , " +
    //         qr.contains("uuid=").toString());
    if (qr == '' || qr.length < 24) {
      AppToast.showToast("无效的二维码！");
      return null;
    }

    if (qr.length == 24) return qr;

    if (!qr.contains("uuid=")) {
      AppToast.showToast("无效的二维码！");
      return null;
    }

    List<String> sl = rowStr.trim().split("uuid=");

    // print("@@@ AppObjHelper.checkQRCode() sl.length : ${sl.length}");
    String uuid = sl[1].trim();

    // print("@@@ AppObjHelper.checkQRCode() uuid : $uuid");

    if (uuid.length != 24) {
      AppToast.showToast("无效的二维码耶！");
      return null;
    }

    return uuid;
  }

  static getFileExt(String file) {
    if (file == null || file == '') return '.jpg';
    List<String> _lst = file.split('.');
    return '.' + _lst[_lst.length - 1];
  }

  static getFileName(String file) {
    if (file == null || file == '') return 'empty.jpg';
    List<String> _lst = file.split('/');
    return _lst[_lst.length - 1];
  }
}
