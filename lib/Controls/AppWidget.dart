import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ovenapp/Controls/AppImage.dart';
import 'package:ovenapp/Publics/AppStyle.dart';
import 'package:ovenapp/Publics/GlobalVar.dart';

class AppWidget {
  //appbar下面的分隔线
  static getAppBarBottomBorder() {
    return Border(
      bottom: BorderSide(
        width: 0.8,
        color: Colors.grey[400], // AppStyle.clAppBarBottomLineColor,
      ),
    );
  }

  static getEmptyData(refreshCallback) {
    return Container(
      alignment: Alignment.center,
      height: double.infinity,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          IconButton(
              icon: Icon(
                Icons.panorama_fish_eye,
                color: Colors.grey[300],
              ), // Image.asset('images/emptydata.png'),
              iconSize: 40.0,
              onPressed: () {
                if (refreshCallback != null) refreshCallback();
              }),
          Text(
            '数据为空 ~~~',
            style: TextStyle(
              fontSize: 17.0,
              color: Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }

  static getCircularProgress() {
    return Center(
      child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(top: 50.0),
        // height: double.infinity,
        // width: double.infinity,
        height: 40.0,
        width: 40.0,
        child: CircularProgressIndicator(),
      ),
    );
  }

  static getLocalImage(String imgfile) {
    return Container(
      // height: 32.0,
      // width: 32.0,
      height: 80.0,
      width: 80.0,
      alignment: Alignment.center,
      child: Image.asset(
        'images/' + imgfile,
        height: 40.0,
        width: 40.0,
        color: Colors.grey[300],
      ),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300], width: 1.0), //灰色的一层边框
        // color: Colors.tealAccent,
        borderRadius: BorderRadius.all(Radius.circular(40.0)),
      ),
    );
  }

  static getAssetImage(
    String asset, [
    //   double dHeight = 80.0,
    // double dWidth = 80.0,
    // double dRadius = 3.0,
    double dIconSize = 80.0,
    Color clIconColor = Colors.grey,
    // Color clBorder = Colors.transparent
  ]) {
    return Center(
      // child: Container(
      // height: 32.0,
      // width: 32.0,
      // height: dIconSize+2.0,
      // width:  dIconSize+2.0,
      // alignment: Alignment.center,
      child: Image.asset(
        'images/' + asset,
        height: dIconSize,
        width: dIconSize,
        color: clIconColor,
      ),
      // decoration: BoxDecoration(
      //   border: Border.all(color: clBorder, width: 1.0), //灰色的一层边框
      //   // color: Colors.tealAccent,
      //   borderRadius: BorderRadius.all(Radius.circular(dRadius)),
      // ),
      // ),
    );
  }

  static getBroadImage(
    String imgfile,
    double dHeight,
    double dWidth, [
    EdgeInsets margin = const EdgeInsets.all(0.0),
    EdgeInsets padding = const EdgeInsets.all(0.0),
    double dIconSize = 32.0,
    double dRadius = 3.5,
  ]) {
    if (imgfile == null ||
        imgfile == '' ||
        imgfile == 'camera.png' ||
        imgfile == 'header.png') {
      if (imgfile == null || imgfile == '') imgfile = 'camera.png';
      return AppImage.rectAssertImage(
          'images/camera.png', dWidth, dHeight, dIconSize, dRadius);
      // // double dR = (dHeight > dWidth ? dHeight / 2 : dWidth / 2);
      // return Container(
      //   // height: 32.0,
      //   // width: 32.0,
      //   margin: margin,
      //   // padding: padding,
      //   height: dHeight,
      //   width: dWidth,
      //   alignment: Alignment.center,
      //   child: Image.asset(
      //     'images/' + imgfile,
      //     height: dIconSize,
      //     width: dIconSize,
      //     color: Colors.grey[300],
      //   ),
      //   decoration: BoxDecoration(
      //     border: Border.all(color: Colors.grey[300], width: 1.0), //灰色的一层边框
      //     // color: Colors.tealAccent,
      //     borderRadius: BorderRadius.all(Radius.circular(dRadius)),
      //   ),
      // );
    }

    return AppImage.rectImage(imgfile, dWidth, dHeight, dRadius);
    // return Container(
    //   width: dWidth,
    //   height: dHeight,
    //   margin: margin,
    //   padding: padding,
    //   child: ClipRRect(
    //     // clipper: CustomClipper<RRect>(3.0),
    //     borderRadius: BorderRadius.all(Radius.circular(dRadius)),
    //     clipBehavior: Clip.antiAlias,
    //     child: AppWidget.getCachImage(imgfile),
    //   ),
    //   // color: Colors.deepOrangeAccent,
    // );
  }

  static getImageFile(
    String imgfile,
    double dHeight,
    double dWidth, [
    double dRadius = 3.5,
    EdgeInsets margin = const EdgeInsets.all(0.0),
    EdgeInsets padding = const EdgeInsets.all(0.0),
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
          fit: BoxFit.fitWidth,
        ),
      ),
    );
    //      Center(
    //   child: Container(
    //     // height: 32.0,
    //     // width: 32.0,
    //     color: Colors.redAccent,
    //     margin: margin,
    //     // padding: padding,
    //     height: dHeight,
    //     width: dWidth,
    //     alignment: Alignment.center,
    //     child: ClipRRect(
    //       // clipper: CustomClipper<RRect>(3.0),
    //       borderRadius: BorderRadius.all(Radius.circular(6.0)),
    //       clipBehavior: Clip.antiAlias,
    //       child: Image.file(
    //         File(imgfile),
    //         fit: BoxFit.fitWidth,
    //       ),
    //     ),
    //   ),
    //   // decoration: BoxDecoration(
    //   //   border: Border.all(color: Colors.grey[300], width: 1.0), //灰色的一层边框
    //   //   // color: Colors.tealAccent,
    //   //   borderRadius: BorderRadius.all(Radius.circular(dRadius)),
    //   // ),
    // );
  }

  static getBroadContainer(
    Widget child, [
    double dHeight = 80.0,
    double dWidth = 80.0,
    double dRadius = 3.5,
    Color clBorder = Colors.grey,
    EdgeInsets margin = const EdgeInsets.all(0.0),
    EdgeInsets padding = const EdgeInsets.all(0.0),
    double dBorderWidth = 1.0,
    Color clBC = Colors.transparent,
  ]) {
    return Container(
      margin: margin,
      padding: padding,
      height: dHeight,
      width: dWidth,
      // alignment: Alignment.center,  //此参数不能随便添加，不然图片会变形
      child: ConstrainedBox(
        child: ClipRRect(
          child: child,
          borderRadius: BorderRadius.circular(dRadius),
          clipBehavior: Clip.antiAlias,
        ),
        constraints: BoxConstraints.expand(),
      ),
      decoration: BoxDecoration(
        border: Border.all(color: clBorder, width: dBorderWidth),
        borderRadius: BorderRadius.all(Radius.circular(dRadius)),
        color: clBC,
      ),
    );
  }

//从本地文件中得到有形状的图片
  // static getImageFromFile(
  //   String imgfile, [
  //   double dRadius = 3.5,
  //   BoxFit bf = BoxFit.fitWidth,
  // ]) {
  //   // print(
  //   //     '@@@ AppWidget.getImageFile() dHeight : $dHeight , dWidth : $dWidth , dRadius : $dRadius');
  //   return ClipRRect(
  //     // clipper: CustomClipper<RRect>(3.0),
  //     borderRadius: BorderRadius.all(Radius.circular(dRadius)),
  //     clipBehavior: Clip.antiAlias,
  //     child: Image.file(
  //       File(imgfile),
  //       fit: bf,
  //     ),
  //   );
  // }

  // static getCameraImage() {
  //   return Container(
  //     // height: 32.0,
  //     // width: 32.0,
  //      height: 80.0,
  //     width: 80.0,
  //     alignment: Alignment.center,
  //     child: Image.asset('images/camera.png',height: 40.0,width: 40.0,color: Colors.grey[300],),
  //      decoration: BoxDecoration(
  //       border: Border.all(color: Colors.grey[300], width: 1.0), //灰色的一层边框
  //       // color: Colors.tealAccent,
  //       borderRadius: BorderRadius.all(Radius.circular(40.0)),
  //     ),
  //   );
  // }

  // static getHeaderImage() {
  //   return Container(
  //     height: 80.0,
  //     width: 80.0,
  //     alignment: Alignment.center,
  //     // padding: EdgeInsets.all(40.0),
  //     // color: Colors.tealAccent,
  //     child: //Text('头像'),
  //     Image.asset('images/header.png',height: 40.0,width: 40.0,color: Colors.grey[300],),
  //     decoration: BoxDecoration(
  //       border: Border.all(color: Colors.grey[300], width: 1.0), //灰色的一层边框
  //       // color: Colors.tealAccent,
  //       borderRadius: BorderRadius.all(Radius.circular(40.0)),
  //     ),
  //   );
  // }

  // static getOvenImage() {
  //   return Container(
  //     // height: 32.0,
  //     // width: 32.0,
  //     alignment: Alignment.center,
  //     child: Image.asset(
  //       'images/oven.png',
  //       height: 80.0,
  //       width: 80.0,
  //     ),
  //   );
  // }

  static getCachImage(String picFile) {
    if (picFile == null ||
        picFile == '' ||
        picFile == 'camera.png' ||
        picFile == 'header.png' ||
        picFile == 'empty.png') return getLocalImage(picFile);
    // if (picFile == null || picFile == '' || picFile == 'camera.png' || picFile == 'empty.png')
    //   return getCameraImage();
    return CachedNetworkImage(
      placeholder: (context, url) => getLocalImage('camera.png'),
      imageUrl: GlobalVar.webimageurl + picFile,
      fadeInCurve: Curves.easeIn,
      fadeOutCurve: Curves.easeOut,
      // alignment: Alignment.topCenter,
      fit: BoxFit.fitWidth,
      // color: Colors.red,
    );
  }

  static getCachedNetImage(String picFile) {
    // if (picFile == null || picFile == '') return getLocalImage(picFile);
    // if (picFile == null || picFile == '' || picFile == 'camera.png' || picFile == 'empty.png')
    //   return getCameraImage();
    return CachedNetworkImage(
      placeholder: (context, url) => getLocalImage('camera.png'),
      imageUrl: GlobalVar.webimageurl + picFile,
      fadeInCurve: Curves.easeIn,
      fadeOutCurve: Curves.easeOut,
      // alignment: Alignment.topCenter,
      fit: BoxFit.fitWidth,
      // color: Colors.red,
    );
  }

//得到圆形图片
  static getCircleAvatar(String imageUrl, double dSize,
      [BoxFit bf = BoxFit.fitWidth]) {
    // if (imageUrl == null ||
    //     imageUrl == '' ||
    //     imageUrl == 'camera.png' ||
    //     imageUrl == 'header.png' ||
    //     imageUrl == 'recipe.png' ||
    //     imageUrl == 'empty.png') return getLocalImage(imageUrl);
    // print("@@@ AppWidget.getCircleAvatar() imageUrl : $imageUrl");
    return ClipOval(
      child: SizedBox(
        width: dSize,
        height: dSize,
        child: _getCacheImage(imageUrl, bf),
      ),
    );
    // return CircleAvatar(
    //   child: CachedNetworkImage(
    //     placeholder: (context, url) => getLocalImage('camera.png'),
    //     imageUrl: GlobalVar.webimageurl + imageUrl,
    //     fadeInCurve: Curves.easeIn,
    //     fadeOutCurve: Curves.easeOut,
    //     fit: BoxFit.fill,
    //     // color: Colors.red,
    //   ),
    //   radius: dRadius,
    // );
  }

  static _getCacheImage(imageUrl, [BoxFit bf = BoxFit.fitWidth]) {
    return CachedNetworkImage(
      placeholder: (context, url) => Image.asset('images/camera.png'),
      imageUrl: GlobalVar.webimageurl + imageUrl,
      fadeInCurve: Curves.easeIn,
      fadeOutCurve: Curves.easeOut,
      fit: bf,
      // color: Colors.red,
    );
  }

  static getSearcherTF(ht, callback, [String iv = '']) {
    final TextEditingController searchController =
        TextEditingController(text: iv);
    return Container(
      //修饰黑色背景与圆角
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white, width: 1.0), //灰色的一层边框
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
      ),
      alignment: Alignment.center,
      // margin: const EdgeInsets.fromLTRB(0, 8, 0, 8),
      height: 36.0,
      // width: 200,
      padding: const EdgeInsets.fromLTRB(12.0, 0.0, 0.0, 0.0),
      child: TextField(
        autofocus: false,
        controller: searchController,
        // cursorColor: Colors.red, //设置光标
        decoration: InputDecoration(
          //输入框decoration属性
          //  contentPadding: const EdgeInsets.symmetric(vertical: 1.0,horizontal: 1.0),
          //此处设置很重要，设置高度后，内容永远无法居中，必须设置contentPadding值才能垂直居中
          contentPadding: new EdgeInsets.only(
              left: 0.0, right: 0.0, top: 0.0, bottom: 14.0),
          //            fillColor: Colors.white,
          // border: InputBorder.none,
          // icon: Icon(Icons.search),
          hintText: ht,
          hintStyle: TextStyle(fontSize: 18, color: Colors.grey),
          //  border: UnderlineInputBorder(
          // borderSide: BorderSide(
          //   color: Colors.red, //边框颜色为绿色
          //   width: 5, //宽度为5
          // ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(0),
            borderSide: BorderSide.none,
          ),
          suffixIcon: Container(
            width: 75.0,
            margin: EdgeInsets.only(right: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // width: 24.0,
                Container(
                  width: 36.0,
                  // color: Colors.deepPurpleAccent,
                  child: IconButton(
                      padding: EdgeInsets.all(0.0),
                      icon: Icon(
                        Icons.search,
                      ),
                      color: Colors.grey[400],
                      iconSize: 26.0,
                      onPressed: () {
                        // setState(() {
                        // print('@@@ query');
                        if (callback != null)
                          callback('query', searchController.text?.trim());
                        // });
                      }),
                ),
                Container(
                  width: 36.0,
                  // color: Colors.deepOrangeAccent,
                  child: IconButton(
                      padding: EdgeInsets.all(0.0),
                      icon: Icon(
                        Icons.clear,
                      ),
                      color: Colors.grey[400],
                      iconSize: 24.0,
                      onPressed: () {
                        if (callback != null) callback('clear', '');
                        searchController.clear();
                        // setState(() {
                        // print('@@@ delete');
                        // });
                      }),
                ),
              ],
            ),
          ),
        ),
        style: TextStyle(
          fontSize: 18,
          color: Colors.grey,
          // backgroundColor: Colors.yellow,
          textBaseline: TextBaseline.alphabetic,
        ),
      ),
    );
  }

  static getBottomLineTF(TextEditingController textController, String pn,
      [bool af = false,
      double dTextFieldLineHeight = 45.0,
      String ht = '',
      TextInputType tt = TextInputType.text]) {
    FocusNode _focusNode = FocusNode();
    return Container(
      height: dTextFieldLineHeight,
      margin: EdgeInsets.only(top: 15.0),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey[300], width: 1.0),
        ),
      ),
      child: TextField(
        textAlign: TextAlign.left,
        controller: textController,
        // scrollPadding: EdgeInsets.all(0.0),
        // keyboardType: TextInputType.number,
        style: TextStyle(
          color: AppStyle.clTitle1FC,
          fontSize: 20.0,
          height: 1.3,
        ),
        decoration: InputDecoration(
          // prefixIcon: Icon(
          //   Icons.phone,
          //   color: AppStyle.cpCloseColor,
          // ),
          prefixText: pn,
          prefixStyle: TextStyle(
            fontSize: 18,
            color: AppStyle.clButtonGray,
          ),
          // helperText: "Yesterday Once More ...",color: Colors.red,
          contentPadding: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
          //helperText: '帐号/手机号',
          // border: OutlineInputBorder(),
          hintText: ht,
          hintStyle: TextStyle(
            fontSize: 16.0,
            color: AppStyle.lightColor,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(0),
            borderSide: BorderSide.none,
          ),
          // border: UnderlineInputBorder(
          //   borderSide: BorderSide(
          //     color: Colors.red, //边框颜色为绿色
          //     width: 5, //宽度为5
          //   ),
          // ),
          // filled: true,
        ),
        keyboardType: tt,
        autofocus: af,
        focusNode: _focusNode,
      ),
      //   ),
      // ],
      // ),
    );
  }

  static getFullWidthButton(context, String title, Color clBC, var callback,
      [EdgeInsets margin = EdgeInsets.zero]) {
    return Container(
      margin: margin,
      width: double.infinity,
      height: AppStyle.dButtonHeight,
      child: RaisedButton(
        color: clBC,
        child: Text(
          title,
          style: TextStyle(
            // height: 2.2,
            color: Colors.white,
            fontSize: 19,
            fontFamily: "微软雅黑",
            // backgroundColor: AppStyle.mainColor,
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(3.0),
          // side: BorderSide(color: Colors.red),
          //size:Size(width, height),
        ), //圆角大小
        onPressed: () {
          if (callback != null) callback();
        },
      ),
    );
  }

  static showModalBottomMenu(BuildContext context,
      Map<String, IconData> lstItem, double textWidth, var callback) {
    List<Widget> _lstItem = [];
    int ii = 0;
    lstItem.forEach((k, v) {
      // if(ii==lstItem.length)
      ii++;
      _lstItem.add(_getBottomMenuButtonItem(
          context, k, v, textWidth, ii == lstItem.length ? 0.0 : 5.0));
    });
    // _lstItem.add(_getBottomMenuButtonItem(context, '取消', Icons.directions_run, textWidth,0.0));
    print('@@@ showModalBottomMenu() _lstItem.length : ${_lstItem.length}');
    double dH = (55.0 + 5.0) * _lstItem.length - 4.0;
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          margin: EdgeInsets.only(left: 10.0, right: 10.0),
          height: dH,
          child: Column(
            children: _lstItem,
          ),
        );
      },
    ).then((val) {
      callback(val);
    });
  }

//   static showBottomMenu(
//       BuildContext context, Map<String, IconData> lstItem, double textWidth, var callback) {
//     List<Widget> _lstItem = [];
//     lstItem.forEach((k, v) {
//       _lstItem.add(_getBottomMenuButtonItem(context, k, v,textWidth));
//     });

//     _lstItem.add(_getBottomMenuButtonItem(context, '取消', Icons.directions_run, textWidth,0.0));

//     showBottomSheet(
//         backgroundColor: Colors.black12,
//         context: context,
// //                      elevation: 13,
//         builder: (BuildContext context) {
//           return new Container(
//             height: 200.0,
//             child: Column(
//               children: <Widget>[
//                 ListTile(
//                   title: Text('拍照', textAlign: TextAlign.center),
//                   onTap: () {
//                     Navigator.pop(context, '拍照');
//                   },
//                 ),
//                 ListTile(
//                   title: Text('从相册选择', textAlign: TextAlign.center),
//                   onTap: () {
//                     Navigator.pop(context, '从相册选择');
//                   },
//                 ),
//                 ListTile(
//                   title: Text('取消', textAlign: TextAlign.center),
//                   onTap: () {
//                     Navigator.pop(context, '取消');
//                   },
//                 ),
//               ],
//             ),
//           );
//         });
//   }

  static _getBottomMenuButtonItem(context, title, iconData, textWidth,
      [bottomMargin = 5.0]) {
    return GestureDetector(
      child: Container(
        // color: Colors.white,
        height: 55.0,
        width: double.infinity,
        margin: EdgeInsets.only(bottom: bottomMargin),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white, width: 1.0),
          color: Colors.white, //此处与主色 color 属性不能同时出现，否则报错
          // borderRadius:BorderRadius.vertical(top:Radius.circular(20.0),bottom: Radius.circular(20.0)),
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
        alignment: Alignment.center,
        child: Container(
          width: textWidth,
          alignment: Alignment.center,
          child: Row(
            // mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Icon(
                iconData, //Icons.wifi,
                size: 28.0,
                color: title == '取消' ? Colors.redAccent : AppStyle.mainColor,
              ),
              Container(
                margin: EdgeInsets.only(left: 8.0),
                child: Text(
                  title,
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 19.0, color: Colors.black87),
                ),
              ),
            ],
          ),
        ),
      ),
      onTap: () {
        Navigator.pop(context, title);
      },
    );
  }
}
