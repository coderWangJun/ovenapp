import 'dart:io';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:ovenapp/Publics/AppFileHelper.dart';
import 'package:ovenapp/Publics/AppStyle.dart';
import 'package:ovenapp/Publics/GlobalVar.dart';

class AppImage {
  //加载网络图片
  static circleImage(String file, double size,
      [Color clBorder = Colors.transparent, double dBorderWidth = 0.0]) {
    return ExtendedImage.network(
      GlobalVar.webimageurl + file,
      width: size,
      height: size,
      fit: BoxFit
          .cover, //AppFileHelper.getBoxFit(file, size, size),// getCircleBoxFit(file), //BoxFit.fitWidth,
      cache: true,
      border: Border.all(color: clBorder, width: dBorderWidth),
      shape: BoxShape.circle,
      borderRadius: BorderRadius.all(Radius.circular(size / 2.0)),
    );
  }

  static squareImage(String file, double size,
      [double dRadius = 5.0,
      Color clBorder = Colors.transparent,
      double dBorderWidth = 0.0]) {
    return ExtendedImage.network(
      GlobalVar.webimageurl + file,
      width: size,
      height: size,
      fit: BoxFit
          .cover, //AppFileHelper.getBoxFit(file, size, size),//getCircleBoxFit(file), //BoxFit.fitWidth,
      cache: true,
      border: Border.all(color: clBorder, width: dBorderWidth),
      shape: BoxShape.rectangle,
      borderRadius: BorderRadius.all(Radius.circular(dRadius)),
    );
  }

  static rectImage(String file, double dWidth, double dHeight,
      [double dRadius = 5.0,
      Color clBorder = Colors.transparent,
      double dBorderWidth = 0.0]) {
    return ExtendedImage.network(
      GlobalVar.webimageurl + file,
      width: dWidth,
      height: dHeight,
      fit: BoxFit
          .cover, // AppFileHelper.getBoxFit(file, dWidth, dHeight),//_getRectBoxFit(file, dWidth, dHeight), //BoxFit.fitWidth,
      cache: true,
      border: Border.all(color: clBorder, width: dBorderWidth),
      shape: BoxShape.rectangle,
      borderRadius: BorderRadius.all(Radius.circular(dRadius)),
    );
  }

  //加载未知尺寸网络图片
  static circleImageUnSize(String file,
      [Color clBorder = Colors.transparent, double dBorderWidth = 0.0]) {
    return ExtendedImage.network(
      GlobalVar.webimageurl + file,
      width: double.infinity,
      height: double.infinity,
      fit: BoxFit
          .cover, //AppFileHelper.getBoxFit(file, size, size),// getCircleBoxFit(file), //BoxFit.fitWidth,
      cache: true,
      border: Border.all(color: clBorder, width: dBorderWidth),
      shape: BoxShape.circle,
      borderRadius: BorderRadius.all(Radius.circular(double.infinity / 2.0)),
    );
  }

  static squareImageUnSize(String file,
      [double dRadius = 5.0,
      Color clBorder = Colors.transparent,
      double dBorderWidth = 0.0]) {
    return ExtendedImage.network(
      GlobalVar.webimageurl + file,
      width: double.infinity,
      height: double.infinity,
      fit: BoxFit
          .cover, //AppFileHelper.getBoxFit(file, size, size),//getCircleBoxFit(file), //BoxFit.fitWidth,
      cache: true,
      border: Border.all(color: clBorder, width: dBorderWidth),
      shape: BoxShape.rectangle,
      borderRadius: BorderRadius.all(Radius.circular(dRadius)),
    );
  }

  static rectImageUnSize(String file,
      [double dRadius = 5.0,
      Color clBorder = Colors.transparent,
      double dBorderWidth = 0.0]) {
    return ExtendedImage.network(
      GlobalVar.webimageurl + file,
      width: double.infinity,
      height: double.infinity,
      fit: BoxFit
          .cover, // AppFileHelper.getBoxFit(file, dWidth, dHeight),//_getRectBoxFit(file, dWidth, dHeight), //BoxFit.fitWidth,
      cache: true,
      border: Border.all(color: clBorder, width: dBorderWidth),
      shape: BoxShape.rectangle,
      borderRadius: BorderRadius.all(Radius.circular(dRadius)),
    );
  }

//加载 assert 图片
  static circleAssertImage(String file, double dSize, double dIconSize,
      [Color clForeColor = AppStyle.clAssertIcon,
      Color clBorder = Colors.transparent,
      // double dPadding = 5.0,
      double dBorderWidth = 1.0,
      Color clBF = Colors.transparent]) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: clBorder, width: dBorderWidth), //灰色的一层边框
        color: clBF,
        borderRadius: BorderRadius.all(Radius.circular(dSize / 2.0)),
      ),
      alignment: Alignment.center,
      // margin: const EdgeInsets.fromLTRB(0, 8, 0, 8),
      height: dSize,
      width: dSize,
      // padding: EdgeInsets.all(dPadding),
      child: ExtendedImage.asset(
        'images/' + file,
        width: dIconSize,
        height: dIconSize,
        color: clForeColor,
        fit: BoxFit.cover, // _getCircleBoxFit(file), //BoxFit.fitWidth,
        // border: Border.all(color: clBorder, width: dBorderWidth),
        // shape: BoxShape.circle,
        // borderRadius: BorderRadius.all(Radius.circular(size / 2.0)),
      ),
    );
  }

  static squareAssertImage(String file, double dSize, double dIconSize,
      [double dRadius = 5.0,
      Color clForeColor = AppStyle.clAssertIcon,
      Color clBorder = Colors.transparent,
      // double dPadding = 5.0,
      double dBorderWidth = 1.0,
      Color clBF = Colors.transparent]) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: clBorder, width: dBorderWidth), //灰色的一层边框
        color: clBF,
        borderRadius: BorderRadius.all(Radius.circular(dRadius)),
      ),
      alignment: Alignment.center,
      // margin: const EdgeInsets.fromLTRB(0, 8, 0, 8),
      height: dSize,
      width: dSize,
      // padding: EdgeInsets.all(dPadding),
      child: ExtendedImage.asset(
        file,
        width: dIconSize,
        height: dIconSize,
        color: clForeColor,
        fit: BoxFit.cover, // _getCircleBoxFit(file), //BoxFit.fitWidth,
        // border: Border.all(color: clBorder, width: dBorderWidth),
        // shape: BoxShape.circle,
        // borderRadius: BorderRadius.all(Radius.circular(size / 2.0)),
      ),
    );
    // return ExtendedImage.asset(
    //   GlobalVar.webimageurl + file,
    //   width: size,
    //   height: size,
    //   fit: _getCircleBoxFit(file), //BoxFit.fitWidth,
    //   border: Border.all(color: clBorder, width: dBorderWidth),
    //   shape: BoxShape.rectangle,
    //   borderRadius: BorderRadius.all(Radius.circular(dRadius)),
    // );
  }

  // static getCircleBoxFit(file) {
  //   // print("@@@ AppImage._getCircleBoxFit() file : $file");
  //   if (file.toString().indexOf('_1.') > -1) {
  //     // print("@@@ AppImage._getCircleBoxFit() ret : BoxFit.fitWidth ");
  //     return BoxFit.fitWidth;
  //   } else if (file.toString().indexOf('_2.') > -1) {
  //     // print("@@@ AppImage._getCircleBoxFit() ret : BoxFit.fitHeight ");
  //     return BoxFit.fitHeight;
  //   } else {
  //     // print("@@@ AppImage._getCircleBoxFit() ret : BoxFit.fill");
  //     return BoxFit.fill;
  //   }
  // }

  // static getBoxFit(int imageRatio) {
  //   // print("@@@ AppImage.getBoxFit() imageRatio : $imageRatio");
  //   if (imageRatio == 1) {
  //     // print("@@@ AppImage.getBoxFit() ret : BoxFit.fitWidth ");
  //     return BoxFit.fitWidth;
  //   } else if (imageRatio == 2) {
  //     // print("@@@ AppImage.getBoxFit() ret : BoxFit.fitHeight ");
  //     return BoxFit.fitHeight;
  //   } else {
  //     // print("@@@ AppImage.getBoxFit() ret : BoxFit.fill");
  //     return BoxFit.fill;
  //   }
  // }

//得到长方形图片

  // static rectAssertImage(String file, double dWidth, double dHeight,
  //     [double dRadius = 5.0,
  //     Color clBorder = Colors.transparent,
  //     double dBorderWidth = 0.0]) {
  //   return ExtendedImage.asset(
  //     GlobalVar.webimageurl + file,
  //     width: dWidth,
  //     height: dHeight,
  //     fit: _getRectBoxFit(file, dWidth, dHeight), //BoxFit.fitWidth,
  //     border: Border.all(color: clBorder, width: dBorderWidth),
  //     shape: BoxShape.rectangle,
  //     borderRadius: BorderRadius.all(Radius.circular(dRadius)),
  //   );
  // }
  static rectAssertImage(
      String file, double dWidth, double dHeight, double dIconSize,
      [double dRadius = 5.0,
      Color clForeColor = AppStyle.clAssertIcon,
      Color clBorder = Colors.transparent,
      // double dPadding = 5.0,
      double dBorderWidth = 1.0,
      Color clBF = Colors.transparent]) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: clBorder, width: dBorderWidth), //灰色的一层边框
        color: clBF,
        borderRadius: BorderRadius.all(Radius.circular(dRadius)),
      ),
      alignment: Alignment.center,
      // margin: const EdgeInsets.fromLTRB(0, 8, 0, 8),
      height: dHeight,
      width: dWidth,
      // padding: EdgeInsets.all(dPadding),
      child: ExtendedImage.asset(
        file,
        width: dIconSize,
        height: dIconSize,
        color: clForeColor,
        fit: BoxFit.cover, // _getCircleBoxFit(file), //BoxFit.fitWidth,
        // border: Border.all(color: clBorder, width: dBorderWidth),
        // shape: BoxShape.circle,
        // borderRadius: BorderRadius.all(Radius.circular(size / 2.0)),
      ),
    );
    // return ExtendedImage.asset(
    //   GlobalVar.webimageurl + file,
    //   width: size,
    //   height: size,
    //   fit: _getCircleBoxFit(file), //BoxFit.fitWidth,
    //   border: Border.all(color: clBorder, width: dBorderWidth),
    //   shape: BoxShape.rectangle,
    //   borderRadius: BorderRadius.all(Radius.circular(dRadius)),
    // );
  }

// static int showlog=0;
  // static _getRectBoxFit(file, double dWidth, double dHeight) {
  //   // if(showlog==1)
  //    print("@@@ AppImage._getRectBoxFit() dWidth : $dWidth ,dHeight : $dHeight ");
  //   if (file.toString().indexOf('_1.') > -1) {
  //     //  return BoxFit.fitWidth;
  //     if (dWidth > dHeight) {
  //       // print("@@@ AppImage._getRectBoxFit() ret : BoxFit.fitHeight ");
  //       return BoxFit.fitWidth;
  //     } else {
  //       // print("@@@ AppImage._getRectBoxFit() ret : BoxFit.fitWidth ");
  //       return BoxFit.fitHeight;
  //     }
  //   } else if (file.toString().indexOf('_2.') > -1) {
  //     //  return BoxFit.fitHeight;
  //     if (dWidth > dHeight) {
  //       // print("@@@ AppImage._getRectBoxFit() ret : BoxFit.fitWidth ");
  //       return BoxFit.fitWidth;
  //     }
  //     // return BoxFit.fitWidth;
  //     else {
  //       // print("@@@ AppImage._getRectBoxFit() ret : BoxFit.fitHeight ");
  //       return BoxFit.fitHeight;
  //     }
  //     // return BoxFit.fitHeight;
  //   }
  //   else if (file.toString().indexOf('_0.') > -1) {
  //     // return BoxFit.fill;
  //     if (dWidth > dHeight) {
  //       // print("@@@ AppImage._getRectBoxFit() ret : BoxFit.fitHeight ");
  //       return BoxFit.fitHeight;
  //     }
  //     // return BoxFit.fitWidth;
  //     else if (dWidth < dHeight){
  //       // print("@@@ AppImage._getRectBoxFit() ret : BoxFit.fitWidth ");
  //       return BoxFit.fitWidth;
  //     }
  //     return BoxFit.fill;
  //   }
  //   else {
  //     // print("@@@ AppImage._getRectBoxFit() ret : BoxFit.fill ");
  //     return BoxFit.fill;
  //   }
  //   // return BoxFit.fill;
  // }

//加载本地文件
  static circleLocalImage(String imgfile, double dSize, [int imageRatio = -1]) {
    // print(
    //     '@@@ AppWidget.getImageFile() dHeight : $dHeight , dWidth : $dWidth , dRadius : $dRadius');
    return Container(
      // color: Colors.deepOrangeAccent,
      height: dSize,
      width: dSize,
      // alignment: Alignment.center,  加上这个参数后图形会变成椭圆形，不知道为什么
      child: ClipRRect(
        // clipper: CustomClipper<RRect>(3.0),
        borderRadius: BorderRadius.all(Radius.circular(dSize / 2.0)),
        clipBehavior: Clip.antiAlias,
        child: Image.file(
          File(imgfile),
          fit: BoxFit
              .cover, // AppFileHelper.getBoxFitByRatio( dSize, dSize,imageRatio),//
          // imageRatio == -1
          //     ? getCircleBoxFit(imgfile)
          //     : getBoxFit(imageRatio), // BoxFit.fitWidth,
        ),
      ),
      //加晕圈
      // decoration: BoxDecoration(
      //           // border: Border.all(color: Color(0xFFFF0000), width: 0.5), // 边色与边宽度
      //           color: Colors.red, // Color(0xFF9E9E9E), // 底色
      //           borderRadius: BorderRadius.circular(dSize / 2.0), // 圆角度
      //           boxShadow: [
      //             BoxShadow(
      //                 color: Colors.grey[400], // Color(0x99FFFF00),
      //                 offset: Offset(0.8, 0.8),
      //                 blurRadius: 5.3,
      //                 spreadRadius: 2.8,),
      //           ],
      //           // gradient: RadialGradient(colors: [Color(0xFFFFFF00), Color(0xFF00FF00), Color(0xFF00FFFF)],radius: 1, tileMode: TileMode.mirror),
      //         ),
    );
  }

  static rectLocalImage(
    String imgfile,
    double dHeight,
    double dWidth, [
    double dRadius = 3.5,
  ]) {
    // print(
    //     '@@@ AppWidget.getImageFile() dHeight : $dHeight , dWidth : $dWidth , dRadius : $dRadius');
    return Container(
      // color: Colors.deepOrangeAccent,
      height: dHeight,
      width: dWidth,
      // alignment: Alignment.center,  加上这个参数后图形会变成椭圆形，不知道为什么
      child: ClipRRect(
        // clipper: CustomClipper<RRect>(3.0),
        borderRadius: BorderRadius.all(Radius.circular(dRadius)),
        clipBehavior: Clip.antiAlias,
        child: Image.file(
          File(imgfile),
          fit: BoxFit
              .cover, // AppFileHelper.getBoxFit(imgfile, dWidth, dHeight),// BoxFit.fitWidth,
        ),
      ),
    );
  }

  static squareLocalImage(
    String imgfile,
    double dSize, [
    double dRadius = 3.5,
  ]) {
    // print(
    //     '@@@ AppWidget.getImageFile() dHeight : $dHeight , dWidth : $dWidth , dRadius : $dRadius');
    return Container(
      // color: Colors.deepOrangeAccent,
      height: dSize,
      width: dSize,
      // alignment: Alignment.center,  加上这个参数后图形会变成椭圆形，不知道为什么
      child: ClipRRect(
        // clipper: CustomClipper<RRect>(3.0),
        borderRadius: BorderRadius.all(Radius.circular(dRadius)),
        clipBehavior: Clip.antiAlias,
        child: Image.file(
          File(imgfile),
          fit: BoxFit
              .cover, // AppFileHelper.getBoxFit(imgfile, dSize, dSize),//getCircleBoxFit(imgfile), // BoxFit.fitWidth,
        ),
      ),
    );
  }

  //系统Icon加载
  static rectMaterialIcon(Icon icon, double dWidth, double dHeight,
      [double dRadius = 3.5,
      // Color clForeColor = AppStyle.clAssertIcon,
      Color clBorder = Colors.transparent,
      // double dPadding = 5.0,
      double dBorderWidth = 1.0,
      Color clBF = Colors.transparent]) {
    // print(
    //     '@@@ AppWidget.getImageFile() dHeight : $dHeight , dWidth : $dWidth , dRadius : $dRadius');
    return Container(
      // color: Colors.deepOrangeAccent,
      height: dHeight,
      width: dWidth,
      decoration: BoxDecoration(
        border: Border.all(color: clBorder, width: dBorderWidth), //灰色的一层边框
        color: clBF,
        borderRadius: BorderRadius.all(Radius.circular(dRadius)),
      ),
      alignment: Alignment.center,
      // margin: const EdgeInsets.fromLTRB(0, 8, 0, 8),
      // alignment: Alignment.center,  加上这个参数后图形会变成椭圆形，不知道为什么
      child: icon,
      // child: ClipRRect(
      //   // clipper: CustomClipper<RRect>(3.0),
      //   borderRadius: BorderRadius.all(Radius.circular(dRadius)),
      //   clipBehavior: Clip.antiAlias,
      //   child: icon,
      // ),
    );
  }

  static squareMaterialIcon(Icon icon, double dSize,
      [double dRadius = 3.5,
      Color clBorder = Colors.transparent,
      // double dPadding = 5.0,
      double dBorderWidth = 1.0,
      Color clBF = Colors.transparent]) {
    // print(
    //     '@@@ AppWidget.getImageFile() dHeight : $dHeight , dWidth : $dWidth , dRadius : $dRadius');
    return Container(
      // color: Colors.deepOrangeAccent,
      height: dSize,
      width: dSize,
      decoration: BoxDecoration(
        border: Border.all(color: clBorder, width: dBorderWidth), //灰色的一层边框
        color: clBF,
        borderRadius: BorderRadius.all(Radius.circular(dRadius)),
      ),
      alignment: Alignment.center,
      // alignment: Alignment.center,  加上这个参数后图形会变成椭圆形，不知道为什么
      child: icon,
    );
  }

  static circleMaterialIcon(Icon icon, double dSize,
      [Color clBorder = Colors.transparent,
      double dBorderWidth = 1.0,
      Color clBF = Colors.transparent]) {
    // print(
    //     '@@@ AppWidget.getImageFile() dHeight : $dHeight , dWidth : $dWidth , dRadius : $dRadius');
    return Container(
      // color: Colors.deepOrangeAccent,
      height: dSize,
      width: dSize,
      decoration: BoxDecoration(
        border: Border.all(color: clBorder, width: dBorderWidth), //灰色的一层边框
        color: clBF,
        borderRadius: BorderRadius.all(Radius.circular(dSize / 2.0)),
      ),
      alignment: Alignment.center,
      // alignment: Alignment.center,  加上这个参数后图形会变成椭圆形，不知道为什么
      child: icon,
    );
  }

  //未知尺寸本地文件
  static localImageUnSize(
    String imgfile, [
    double dRadius = 3.5,
  ]) {
    // print(
    //     '@@@ AppWidget.getImageFile() dHeight : $dHeight , dWidth : $dWidth , dRadius : $dRadius');
    return Container(
      // color: Colors.deepOrangeAccent,
      height: double.infinity,
      width: double.infinity,
      // alignment: Alignment.center,  加上这个参数后图形会变成椭圆形，不知道为什么
      child: ClipRRect(
        // clipper: CustomClipper<RRect>(3.0),
        borderRadius: BorderRadius.all(Radius.circular(dRadius)),
        clipBehavior: Clip.antiAlias,
        child: Image.file(
          File(imgfile),
          fit: BoxFit
              .cover, // AppFileHelper.getBoxFit(imgfile, dWidth, dHeight),// BoxFit.fitWidth,
        ),
      ),
    );
  }
}
