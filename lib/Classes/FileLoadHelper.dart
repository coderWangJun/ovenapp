// import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import 'package:image_picker/image_picker.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
// import 'package:flutter_luban/flutter_luban.dart';

// import 'package:ovenapp/Classes/ApkHelper.dart';
import 'package:ovenapp/Classes/AppDialog.dart';
import 'package:ovenapp/Classes/AppToast.dart';
import 'package:ovenapp/Classes/app_dialog_helper.dart';
import 'package:ovenapp/Models/HttpRetModel.dart';
import 'package:ovenapp/Publics/AppDataHelper.dart';
import 'package:ovenapp/Publics/AppObjHelper.dart';
import 'package:ovenapp/Publics/DateTimeHelper.dart';
import 'package:ovenapp/Publics/GlobalVar.dart';
// import 'package:ovenapp/Models/RootModel.dart';
// import 'package:ovenapp/Publics/GlobalVar.dart';
import 'package:ovenapp/Services/HttpCallerSrv.dart';

class FileLoadHelper {
  static int imageRatio = 0; //图片文件长宽比，0等宽，1高大，2宽大
  static String imagePath = '';
  //获取图片
  static selectPicture(context, fparam, var precallback, var callback) async {
    var ret = await AppDiaglogHelper.showSelectTextList(
        context, ["从相册选择", "用相机拍照", "取消"]);
    print("@@@ ret : $ret");
    if (ret != null) {
      if (ret == 0)
        getImageFromGallery(fparam, precallback, callback);
      else if (ret == 1) getImageFromCamera(fparam, precallback, callback);
    }
    // AppDialog.showSelectTextItemIOS(context, , (item) {
    //   if (item == null) {
    //     Future.value(HttpRetModel.getEmptyObj('item is null')).catchError((f) {
    //       if (callback != null) callback(f);
    //     });
    //   } else {
    //     print("@@@ item : $item");
    //     if (item == "0") {
    //       getImageFromGallery(fparam, precallback, callback);
    //     } else if (item == "1") {
    //       getImageFromCamera(fparam, precallback, callback);
    //     }
    //   }
    // });
  }

//拍照
  static getImageFromCamera(var fparam, var precallback, var callback) async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    if (image == null) {
      Future.value(HttpRetModel.getEmptyObj('item is null')).catchError((f) {
        if (callback != null) callback(f);
      });
    } else {
      await upLoadImage(image, fparam, precallback, callback);
    }
    // _uploadImage(image,fparam);
  }

  //相册选择
  static getImageFromGallery(var fparam, var precallback, var callback) async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (image == null) {
      await Future.value(HttpRetModel.getEmptyObj('item is null'))
          .catchError((f) {
        if (callback != null) callback(f);
      });
    } else {
      await upLoadImage(image, fparam, precallback, callback);
    }
    // if (image != null) _uploadImage(image,fparam);
  }

  static upLoadImage(
      File image, var fparam, var precallback, var callback) async {
    if (GlobalVar.userInfo == null) {
      AppToast.showToast('请登录！');
      return;
    }
    // FormData formData = FormData.from({
    //   //"": "", //这里写其他需要传递的参数
    //   "file": UploadFileInfo(_image, "imageName.png"),
    // });

    // imageRatio = 0;
    // imagePath = '';

    // Image img = Image.file(image);
    // if (img.height > img.width)
    //   imageRatio = 1;
    // else if (img.height < img.width) imageRatio = 2;

    // imagePath = image.path;

    if (precallback != null) precallback(image.path);

    // String newpath = GlobalVar.appLocalPath + '/';
    String fe = AppObjHelper.getFileExt(image.path).toLowerCase();
    if (fe.endsWith('webp')) fe = '.jpg';

    String file = GlobalVar.appLocalPath + DateTimeHelper.getNowStr() + fe;
    // AppObjHelper.getFileExt(image.path);
    // await image.copy(file);
    int fs = await image.length();
    print(
        "@@@ FileLoadHelper.upLoadImage() fparam : $fparam , image.path : ${image.path} , image.size : $fs , file : $file");

    if (fs > 204800) {
      try {
        var result = await FlutterImageCompress.compressAndGetFile(
          image.path,
          file,
          quality: 80,
          minHeight: 1280,
          minWidth: 960,
        );
        print(
            "@@@ FileLoadHelper.upLoadImage() compressAndGetFile result : $result");
      } catch (e) {
        print("*** FileLoadHelper.upLoadImage() compressAndGetFile e : $e");
        await image.copy(file);
      }

      // CompressObject compressObject = CompressObject(
      //   imageFile: image, //image
      //   path: GlobalVar.appLocalPath, //image.path, //compress to path
      //   quality: 20, //first compress quality, default 80
      //   step:9, //compress quality step, The bigger the fast, Smaller is more accurate, default 6
      //   // mode: CompressMode.LARGE2SMALL, //default AUTO
      // );
      // await Luban.compressImage(compressObject).then((_path) {
      //   file = _path;
      //   print("@@@ FileLoadHelper.upLoadImage() compressImage _path : $_path");
      // });
    } else {
      print("@@@ FileLoadHelper.upLoadImage()  image.copy() file : $file");
      await image.copy(file);
    }

    // return;

    if (image == null || image.path == null || image.path == "")
      return callback(HttpRetModel.getNullParam());

    if (fparam == null) fparam = {};

    fparam["file"] = await MultipartFile.fromFile(file); //image.path
    fparam["filename"] = AppObjHelper.getFileName(file);

    // if (fparam == null || fparam["file"] == null)
    if (fparam["file"] == null) return callback(HttpRetModel.getNullParam());

    FormData formdata = FormData.fromMap(fparam);
    Dio dio = Dio();
    dio.interceptors
        .add(InterceptorsWrapper(onRequest: (RequestOptions options) {
      options.contentType = ContentType.binary.toString();
      options.responseType = ResponseType.json;
      if (GlobalVar.userInfo.tk != null && GlobalVar.userInfo.tk != "") {
        options.headers.addAll({
          HttpHeaders.authorizationHeader: "BasicAuth " + GlobalVar.userInfo.tk
        });
        // print("@@@ HttpCallerSrv._call tk => " + tk);
      }
    }));

    //https://www.cfdzkj.com:811/FileUpload/uploadfile.html
    String url = HttpCallerSrv.apiSrv + "/FileUpload/FileUploader.ashx";
    await dio.post(url, data: formdata).then((f) {
      // print("@@@ FileLoadHelper.upLoadImage() f : $f");
      HttpRetModel rm = HttpRetModel.getExecRet(f);
      // if(rm.ret==0)
      //  image.copySync(rm.message);
      if (callback != null) callback(rm);
    }).catchError((e) {
      if (callback != null) callback(HttpRetModel.getErrObj(e));
    });
  }
}
