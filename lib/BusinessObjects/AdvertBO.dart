// import 'dart:convert';

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';

// import 'package:flutter_swiper/flutter_swiper.dart';
// import 'package:cached_network_image/cached_network_image.dart';
import 'package:ovenapp/Classes/SharePrefHelper.dart';
// import 'package:ovenapp/Classes/SharePrefHelper.dart';

import 'package:ovenapp/Models/AdvertModel.dart';
import 'package:ovenapp/Models/HttpRetModel.dart';
import 'package:ovenapp/Models/NewsModel.dart';
import 'package:ovenapp/Models/TModel.dart';
// import 'package:ovenapp/Pages/WebViewerPage.dart';
import 'package:ovenapp/Publics/DataHelper.dart';
import 'package:ovenapp/Publics/GlobalVar.dart';
// import 'package:ovenapp/Services/HttpCallerSrv.dart';

class AdvertBO {
  static getData([fromcs = 0]) async {
    String spfile = GlobalVar.spadvert;

    if (fromcs == 0 && GlobalVar.lstAdvert != null) {
      print('@@@ AdvertBO.getData() Cache Data : $spfile');
      return;
    }

    List<dynamic> lstObj = [
      // AdvertModel(),
      NewsModel(),
    ];

//此处暂时不进行本地缓存
    // if (fromcs == 0) {
    //   if (SharePrefHelper.appPrefs.containsKey(spfile)) {
    //     String jsonData = await SharePrefHelper.getData(spfile);
    //     // print('@@@ AppPublicData._getTemplates() SharePref Data : $jsonData');
    //     if (jsonData != null && jsonData != "") {
    //       try {
    //         // Map<String, dynamic> ret = json.decode(jsonData);
    //         // HttpRetModel rm = HttpRetModel.fromJson(ret, TemplateModel());
    //         HttpRetModel rm = HttpRetModel.fromJsonStr(jsonData, lstObj);

    //         _setAdvertData(rm);

    //         print('@@@ AdvertBO.getData() SharePref data : $spfile');
    //         return;
    //       } catch (e) {
    //         // AppPublicData.mpTables.remove(spfile);
    //         SharePrefHelper.removeData(spfile);
    //         print('*** AdvertBO.getData() SharePref data e : $e');
    //         // isQueryData = true;
    //       }
    //     }
    //   }
    //   // }
    // }

    await DataHelpr.dataQuerier('Home/Adverts', null, lstObj, (ret) {
      HttpRetModel rm = ret as HttpRetModel;

      print(
          '@@@ AdvertBO.getData() Adverts ... Cloud data rm.ret : ${rm.ret}, data.length : ${rm.data?.length}');
      // print(
      //     '@@@ AppPublicData.getTemplate selectData => ret : ${rm.ret} , data.length : ${rm.data.length} , data1.length : ${rm.data1.length}');

      if (rm.ret == 0) {
        // GlobalVar.lstTemplate[tid] = tm;
        _setAdvertData(rm);
      }
    });//,spfile
  }

  static getTData([fromcs = 0]) async {
    String spfile = GlobalVar.spmaterial;

    if (fromcs == 0 && GlobalVar.lstT != null) {
      print('@@@ AdvertBO.getTData() Cache Data : $spfile');
      return;
    }

    List<dynamic> lstObj = [
      TModel(),
    ];

    if (fromcs == 0) {
      if (SharePrefHelper.appPrefs.containsKey(spfile)) {
        String jsonData = await SharePrefHelper.getData(spfile);
        // print('@@@ AppPublicData._getTemplates() SharePref Data : $jsonData');
        if (jsonData != null && jsonData != "") {
          try {
            // Map<String, dynamic> ret = json.decode(jsonData);
            // HttpRetModel rm = HttpRetModel.fromJson(ret, TemplateModel());
            HttpRetModel rm = HttpRetModel.fromJsonStr(jsonData, lstObj);

            _setTData(rm);
            print('@@@ AdvertBO.getTData() SharePref data : $spfile');
            return;
          } catch (e) {
            // AppPublicData.mpTables.remove(spfile);
            SharePrefHelper.removeData(spfile);
            print('*** AdvertBO.getTData() SharePref data e : $e');
            // isQueryData = true;
          }
        }
      }
      // }
    }

    await DataHelpr.dataQuerier('Home/Material', null, lstObj, (ret) {
      HttpRetModel rm = ret as HttpRetModel;

      print(
          '@@@ AdvertBO.getTData() Cloud data rm.ret : ${rm.ret} , data.length : ${rm.data?.length}');
      // print(
      //     '@@@ AppPublicData.getTemplate selectData => ret : ${rm.ret} , data.length : ${rm.data.length} , data1.length : ${rm.data1.length}');

      if (rm.ret == 0) {
        // GlobalVar.lstTemplate[tid] = tm;
        _setTData(rm);
      }
    },spfile);
  }

  static _setAdvertData(HttpRetModel rm) {
    if (GlobalVar.lstAdvert == null) 
      GlobalVar.lstAdvert = {};

    for (int i = 0; i < rm.data.length; i++) {
      // AdvertModel am = rm.data[i] as AdvertModel;
      NewsModel nm=rm.data[i] as NewsModel;
      GlobalVar.lstAdvert[nm.id] = nm;
      // print('@@@ AdvertBO._setAdvertData() NewsModel : ${nm.toJsonStr()}');
    }
  }

  static _setTData(HttpRetModel rm) {
    if (GlobalVar.lstT == null) GlobalVar.lstT = {};
    for (int i = 0; i < rm.data.length; i++) {
      TModel tm = rm.data[i] as TModel;
      GlobalVar.lstT[tm.id] = tm;
    }
  }

  // static FutureBuilder getAdvertFB(BuildContext context) {
  //   return FutureBuilder(
  //     future: _getAdvertData(context),
  //     builder: (context, snapshot) {
  //       switch (snapshot.connectionState) {
  //         case ConnectionState.none:
  //         case ConnectionState.active:
  //         case ConnectionState.waiting:
  //           // print(snapshot.connectionState);
  //           return Center(child: CupertinoActivityIndicator());
  //         case ConnectionState.done:
  //           // print('done');

  //           if (snapshot.hasError) {
  //             return Center(
  //               child: Text('网络请求出错'),
  //             );
  //           }
  //           _advertData = snapshot.data;
  //           return _getAdvertSwiper(context, snapshot.data);
  //         default:
  //           return null;
  //       }
  //       // return null;
  //     },
  //   );
  // }

  // static _getAdvertData(BuildContext context) async {
  //   // return _getAdvertDataa(context);
  //   return await DataHelpr.getData(
  //       context, 'Home/Advert', GlobalVar.spadvert, "AdvertModel");
  // }

  // static HttpRetModel _advertData;

  // static Widget _getAdvertSwiper(context, HttpRetModel data) {
  //   return Swiper(
  //     // itemBuilder: _swiperBuilder,
  //     itemBuilder: _getSwiperImage,
  //     itemCount: _advertData.data.length,
  //     pagination: SwiperPagination(
  //         builder: DotSwiperPaginationBuilder(
  //       color: Colors.black54,
  //       activeColor: Colors.white,
  //     )),
  //     control: null, // new SwiperControl(),
  //     scrollDirection: Axis.horizontal,
  //     // layout: SwiperLayout.TINDER,
  //     autoplay: true,
  //     onTap: (index) {
  //       _gotoDetail(context, index);
  //     },
  //   );
  // }

  // static _gotoDetail(context, index) {
  //   print('点击了第$index个');
  //   Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //           builder: (context) =>
  //               WebViewerPage(id: '123', url: 'https://www.baidu.com')));
  // }

  // static Widget _getSwiperImage(BuildContext context, int index) {
  //   // return (Image.network(
  //   //   GlobalVar.webimageurl + (_advertData.data[index] as AdvertModel).mainpic,
  //   //   fit: BoxFit.fill,
  //   // ));
  //   return CachedNetworkImage(
  //     placeholder: null, //CircularProgressIndicator(),
  //     imageUrl: GlobalVar.webimageurl +
  //         (_advertData.data[index] as AdvertModel).mainpic,
  //     fadeInCurve: Curves.easeIn,
  //     fadeOutCurve: Curves.easeOut,
  //     fit: BoxFit.fill,
  //   );
  // }
}
