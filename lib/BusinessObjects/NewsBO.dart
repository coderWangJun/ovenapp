import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ovenapp/Classes/SharePrefHelper.dart';
// import 'package:ovenapp/Controls/NewsLine.dart';
import 'package:ovenapp/Pages/NewsDetailPage.dart';
import 'package:ovenapp/Pages/NewsListPage.dart';
import 'package:ovenapp/Publics/DataHelper.dart';
// import 'dart:convert';
// import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

// import '../Services/HttpCallerSrv.dart';
import '../Models/HttpRetModel.dart';
import '../Models/NewsModel.dart';
import '../Publics/GlobalVar.dart';

// import '../Pages/WebViewerPage.dart';
// import '../Pages/NewsDetailPage.dart';

class NewsBO {
//   static FutureBuilder getNewsFB(BuildContext context) {
//     return FutureBuilder(
//       future: _getNewsData(context),
//       builder: (context, snapshot) {
//         switch (snapshot.connectionState) {
//           case ConnectionState.none:
//           case ConnectionState.active:
//           case ConnectionState.waiting:
//             // print(snapshot.connectionState);
//             return Center(child: CupertinoActivityIndicator());
//           case ConnectionState.done:
//             // print('done');

//             if (snapshot.hasError) {
//               return Center(
//                 child: Text('网络请求出错'),
//               );
//             }
//             // _newsData = snapshot.data;
//             return Wrap(children: _getNewsUI(context, snapshot.data));
//           default:
//             return null;
//         }
//         // return null;
//       },
//     );
//   }

// //Future<HttpRetModel>  注：此处返回不能加类型，添加则出错，需要研究
//   static _getNewsData(BuildContext context) async {
//     // return await DataHelpr.getData(context, 'Home/Advert', GlobalVar.spadvert, "AdvertModel");
//     return DataHelpr.getData(
//         context, "Home/News", GlobalVar.spnews, "NewsModel");
//   }

//   static List<Widget> _getNewsUI(BuildContext context, HttpRetModel data) {
//     List<Widget> _lstNews = new List<Widget>();

//     if (data.data.length > 0) {
//       for (int i = 0; i < data.data.length; i++) {
//         NewsModel nm = data.data[i] as NewsModel;
//         Widget w = _getNewsItem(context, nm, i);
//         _lstNews.add(w);
//       }
//     }

//     return _lstNews;
//   }

//   static _getNewsItem(BuildContext context, NewsModel nm, int ii) {
//     //NewsModel nm String title,String dt
//     return GestureDetector(
//         // onTap: _itemClick(nm.id),
//         onTap: () {
//           //  print("@@@ _itemClick() id => " + nm.id);
//           // Navigator.of(context).pushNamed("/webviewer");
//           _newsListItemClick(context, nm);
//         },
//         child: Container(
//             // padding: EdgeInsets.only(left: 25, right: 25),
//             margin: EdgeInsets.only(left: 25, right: 25),
//             height: 45.0,
//             decoration: new BoxDecoration(
//                 border: new Border(
//                     bottom: BorderSide(
//               width: 1,
//               color: new Color(0xffe3e3e3),
//             ))),
//             // child: GestureDetector(
//             //     onTap: _itemClick(nm.id),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.start,
//               mainAxisSize: MainAxisSize.min,
//               // verticalDirection: VerticalDirection.up,
//               children: <Widget>[
//                 Expanded(
//                   child: Text(
//                     (ii + 1).toString() + ". " + nm.title,
//                     maxLines: 1,
//                     overflow: TextOverflow.ellipsis,
//                     style: TextStyle(
//                       fontSize: 17,
//                       color: new Color(0xff5b5b5c),
//                       // fontWeight: FontWeight.w200,
//                     ),
//                   ),
//                 ),
//                 Text(
//                   nm.createdt,
//                   style: TextStyle(
//                     fontSize: 17,
//                     color: new Color(0xffaaaaab),
//                   ),
//                 ),
//               ],
//             )));
//   }

//   static _newsListItemClick(BuildContext context, NewsModel nm) {
//     Navigator.push(
//       context,
//       new MaterialPageRoute(builder: (context) => NewsDetailPage(id: nm.id)),
//     );
//   }

  static Widget getTitle(BuildContext context) {
    return new Padding(
        padding: EdgeInsets.fromLTRB(25, 0, 25, 0),
        child: Container(
            height: 40.0,
            decoration: new UnderlineTabIndicator(
              borderSide:
                  const BorderSide(width: 1.0, color: Color(0xFFEEEEEE)),
              insets: EdgeInsets.zero,
            ),
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              // verticalDirection: VerticalDirection.up,
              children: <Widget>[
                Expanded(
                  child: Text(
                    "新闻",
                    style: TextStyle(fontSize: 17, color: Colors.black87),
                  ),
                ),
                Center(
                    child: IconButton(
                  icon: new Icon(Icons.more_horiz),
                  color: Colors.black54,
                  iconSize: 30.0,
                  onPressed: () {
                    //  Navigator.of(context).pushNamed("/newslist");
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => NewsListPage()));
                  },
                )),
              ],
            )));
  }

  static getData([fromcs = 0]) async{
    String spfile = GlobalVar.spnews;

    if (fromcs == 0 && GlobalVar.lstNews != null) {
      print('@@@ NewsBO.getData() Cache Data : $spfile');
      return;
    }

    List<dynamic> lstObj = [
      NewsModel(),
    ];

    // if (fromcs == 0) {
    //   if (SharePrefHelper.appPrefs.containsKey(spfile)) {
    //     String jsonData = await SharePrefHelper.getData(spfile);
    //     // print('@@@ AppPublicData._getTemplates() SharePref Data : $jsonData');
    //     if (jsonData != null && jsonData != "") {
    //       try {
    //         // Map<String, dynamic> ret = json.decode(jsonData);
    //         // HttpRetModel rm = HttpRetModel.fromJson(ret, TemplateModel());
    //         HttpRetModel rm = HttpRetModel.fromJsonStr(jsonData, lstObj);

    //         _setNewsData(rm);
    //         print('@@@ NewsBO.getData() SharePref data : $spfile');
    //         return;
    //       } catch (e) {
    //         // AppPublicData.mpTables.remove(spfile);
    //         SharePrefHelper.removeData(spfile);
    //         print('*** NewsBO.getData() SharePref data e : $e');
    //         // isQueryData = true;
    //       }
    //     }
    //   }
    //   // }
    // }

    await DataHelpr.dataQuerier('Home/News', null, lstObj, (ret) {
      HttpRetModel rm = ret as HttpRetModel;

      print(
          '@@@ NewsBO.getData() Cloud data rm.ret : ${rm.ret} , data.length : ${rm.data?.length}');
      // print(
      //     '@@@ AppPublicData.getTemplate selectData => ret : ${rm.ret} , data.length : ${rm.data.length} , data1.length : ${rm.data1.length}');

      if (rm.ret == 0) {
        // GlobalVar.lstTemplate[tid] = tm;
        _setNewsData(rm);
      }
    },spfile);
  }

  static _setNewsData(HttpRetModel rm) {
    if (GlobalVar.lstNews == null) GlobalVar.lstNews = {};
    for (int i = 0; i < rm.data.length; i++) {
      NewsModel nm = rm.data[i] as NewsModel;
      GlobalVar.lstNews[nm.id] = nm;
    }
  }
}
