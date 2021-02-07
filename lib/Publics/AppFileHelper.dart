import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ovenapp/Publics/GlobalVar.dart';
import 'package:image_picker/image_picker.dart';

class AppFileHelper {
  static isExistLocalFile(String file, [String dir = '']) {
    String fn = (dir == '' ? GlobalVar.appLocalPath : dir) + file;
    // print('@@@ AppFileHelper.isExistLocalFile() fn : $fn');
    File _picFile = File(fn);
    bool blFileExist = _picFile.existsSync();
    return blFileExist;
  }

  static getLocalFile(String filename) {
    return filename
        .replaceAll('_0.', '.')
        .replaceAll('_1.', '.')
        .replaceAll('_2.', '.');
  }

  static getImageSize() {
    // int imageRatio=-1;
    // var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    // if (image == null) return;

    ImagePicker.pickImage(source: ImageSource.gallery).then((image) {
      Image img = Image.file(image);
      img.image.resolve(ImageConfiguration()).addListener(
        ImageStreamListener(
          (ImageInfo image, bool synchronousCall) {
            var myImage = image.image;
            Size size =
                Size(myImage.width.toDouble(), myImage.height.toDouble());
            print(
                '@@@ AppFileHelper.getImageSize() img.height : ${size.height} , img.width : ${size.width} , time : ${DateTime.now()}');
            return size;
          },
        ),
      );
    });
    // print('@@@ RepairListPage._getImageSize() begin : ${DateTime.now()}');
    // Image img = Image.file(image);
    // print('@@@ RepairListPage._getImageSize() image.path : ${image.path}');

    // img.image.resolve(ImageConfiguration()).addListener(
    //   ImageStreamListener(
    //     (ImageInfo image, bool synchronousCall) {
    //       var myImage = image.image;
    //       Size size = Size(myImage.width.toDouble(), myImage.height.toDouble());
    //       print(
    //           '@@@ RepairListPage._getImageSize() img.height : ${size.height} , img.width : ${size.width} , time : ${DateTime.now()}');
    //     },
    //   ),
    // );
    // print('@@@ RepairListPage._getImageSize() end : ${DateTime.now()}');
    // if (img.height > img.width)
    //   imageRatio = 1;
    // else if (img.height < img.width) imageRatio = 2;
// print(
//         '@@@ RepairListPage._getImageSize() image.path : ${image.path} , img.height : ${img.height} , img.width : ${img.width}');
    // String imagePath = image.path;
  }

  static getImageRation(String filename) {
    int _iret = 0;
    if (filename.indexOf('_1.') > -1)
      _iret = 1;
    else if (filename.indexOf('_2.') > -1) _iret = 2;
    return _iret;
  }

  static getBoxFit(String file, double dWidth, double dHeight) {
    return BoxFit.cover;
    // if(showlog==1)
    print(
        "@@@ AppFileHelper.getBoxFit() file : $file , dWidth : $dWidth ,dHeight : $dHeight ");
    double dR = double.parse((dWidth / dHeight).toStringAsFixed(3));
    print("@@@ AppFileHelper.getBoxFit() dR : $dR");
    if (file.indexOf('_') == -1 || file.indexOf('#') == -1) return BoxFit.fill;
    try {
      double dF =
          double.parse((file.split('_')[1]).split('_')[0].replaceAll('#', '.'));
      print("@@@ AppFileHelper.getBoxFit() dF : $dF");
      if (dR > dF)
        return BoxFit.fitWidth;
      else
        return BoxFit.fitHeight;
    } catch (e) {
      print("*** AppFileHelper.getBoxFit() e : $e");
      return BoxFit.fill;
    }

    // return BoxFit.fill;
  }

  static getBoxFitByRatio(double dWidth, double dHeight, double dRatio) {
    return BoxFit.cover;
    double dR = double.parse((dWidth / dHeight).toStringAsFixed(3));
    if (dR > dRatio)
      return BoxFit.fitWidth;
    else
      return BoxFit.fitHeight;
  }
}
