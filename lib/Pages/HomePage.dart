// import 'dart:async';
// import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:ovenapp/BusinessObjects/AppBO.dart';

// import 'package:ovenapp/BusinessObjects/MaterialBO.dart';
import 'package:ovenapp/BusinessObjects/AdvertBO.dart';
import 'package:ovenapp/Classes/SharePrefHelper.dart';
// import 'package:ovenapp/Controls/AppWidget.dart';
// import 'package:ovenapp/Models/AdvertModel.dart';
import 'package:ovenapp/Models/JPushModel.dart';
import 'package:ovenapp/Models/NewsModel.dart';
import 'package:ovenapp/Models/TModel.dart';
import 'package:ovenapp/Pages/MaterialListPage.dart';
import 'package:ovenapp/Pages/NewsDetailPage.dart';
import 'package:ovenapp/Pages/WebViewerPage.dart';

import 'package:ovenapp/Publics/AppStyle.dart';
import 'package:ovenapp/BusinessObjects/NewsBO.dart';
import 'package:ovenapp/Publics/GlobalVar.dart';
// import 'package:ovenapp/Publics/MyControl.dart';
import 'package:ovenapp/Services/EventBusSrv.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // void onchildcall(String value) {
  //   print("@@@ => onCallback.value => " + value);
  // }
  var _onPushEvent;

  List<NewsModel> _lstAdvert;
  List<TModel> _lstT;
  List<NewsModel> _lstNews;

  double dAdvertHeight = 200.0;
  // double dMaterionHeight = 240.0;
  // double dMaterialUnitHeight = 60.0;
  double _iconsize = 55.0;
  double dAspectRatio = 1.2;

  @override
  void initState() {
    super.initState();

    _onPushEvent = eventBus.on<PushEvent>().listen((event) {
      PushEventModel pm = event.pm;
      // print("@@@ HomePage.PushEvent => pm : ${pm.toJsonStr()}");
      switch (pm.event) {
        case 'update':
          String spfile;
          switch (pm.module) {
            case 'advert':
              spfile = GlobalVar.spadvert;
              GlobalVar.lstAdvert = null;
              break;
            case 'material':
              spfile = GlobalVar.spmaterial;
              GlobalVar.lstT = null;
              break;
            case 'news':
              spfile = GlobalVar.spnews;
              GlobalVar.lstNews = null;
              break;
            default:
              return;
          }
          SharePrefHelper.removeData(spfile);
          break;
      }
    });
    _getAdvertData();
    _getTData();
    _getNewsData();
    // if (GlobalVar.mqttClass == null) {
    //   // print("@@@ => GlobalVar.initMqttSrv()");
    //   GlobalVar.initMqttSrv();
    // }
  }

  @override
  void dispose() {
    super.dispose();
    _onPushEvent.cancel();
    print("@@@ HomePage.dispose() ...");
  }

  @override
  Widget build(BuildContext context) {
    print("@@@ => HomePage.build() ...");

    // print("@@@ screenSize => h:${AppStyle.screenSize.height} x w:${AppStyle.screenSize.width}");
    AppStyle.screenSize = MediaQuery.of(context).size;
    dAdvertHeight = AppBO.get43Height(AppStyle.screenSize.width) - 30.0;

    //  dMaterionHeight = 240.0;
    //  dMaterialUnitHeight = 90.0;
    //  _iconsize = 55.0;
    //  dAspectRatio = 1.2;

    // print(
    //     "@@@ => HomePage.initState() AppStyle.screenSize : ${AppStyle.screenSize} , advertHeight : $dAdvertHeight");

    return Scaffold(
        body: SingleChildScrollView(
      child: Center(
          child: Column(children: <Widget>[
        //广告轮播页
        Container(
          width: MediaQuery.of(context).size.width,
          height: dAdvertHeight, //200.0,
          child: _getAdvertSwiper(context), //AdvertBO.getAdvertFB(context),//
        ),

        //原料数据
        Container(
          // padding: EdgeInsets.fromLTRB(5, 8, 5, 8),
          margin:
              EdgeInsets.only(top: 8.0, right: 10.0, left: 10.0, bottom: 5.0),
          // color: Colors.black54,
          // height: dMaterionHeight, //240.0,
          width: double.infinity,
          child: _getMaterialUI(), //MaterialBO.getUI(),
        ),

        // RaisedButton(
        //   onPressed: () {
        //     // _getAvertData();
        //     print(
        //         'AppBO.get43Height(AppStyle.screenSize.width) : ${AppBO.get43Height(AppStyle.screenSize.width)}');
        //   },
        //   child: Text('Query Data'),
        // ),

        // 新闻列表
        NewsBO.getTitle(context),

        //新闻列表
        Container(
          height: 400.0,
          child: _getNewsBodyUI(),
        ),
        // NewsBO.getNewsFB(context),
      ])),
    ));
  }

  Widget _getAdvertSwiper(context) {
    if (_lstAdvert == null || _lstAdvert.length == 0) {
      return Image.network(
        GlobalVar.webimageurl + 'advertempty.jpg',
        height: dAdvertHeight, // 200.0,
        width: MediaQuery.of(context).size.width,
        fit: BoxFit.cover,
      );
    }
    // print(
    //     '@@@ HomePage._getAdvertSwiper() GlobalVar.lstAdvert.length : ${GlobalVar.lstAdvert.length}');
    return Swiper(
      // itemBuilder: _swiperBuilder,
      itemBuilder: _getSwiperImage,
      itemCount: _lstAdvert.length,
      pagination: SwiperPagination(
          builder: DotSwiperPaginationBuilder(
        color: Colors.black54,
        activeColor: Colors.white,
      )),
      control: null, // new SwiperControl(),
      scrollDirection: Axis.horizontal,
      // layout: SwiperLayout.TINDER,
      autoplay: true,
      onTap: (index) {
        _gotoDetail(context, index);
      },
    );
  }

  Widget _getSwiperImage(BuildContext context, int index) {
    // return (Image.network(
    //   GlobalVar.webimageurl + (_advertData.data[index] as AdvertModel).mainpic,
    //   fit: BoxFit.fill,
    // ));
    // print('_lstAdvert[$index].mainpic : ${_lstAdvert[index].mainpic}');
    return CachedNetworkImage(
      placeholder: null, //CircularProgressIndicator(),
      imageUrl: GlobalVar.webimageurl + _lstAdvert[index].mainpic,
      fadeInCurve: Curves.easeIn,
      fadeOutCurve: Curves.easeOut,
      fit: BoxFit.fill,
    );
  }

  _gotoDetail(context, index) {
    NewsModel am = _lstAdvert[index];
    print('am : ${am.toJsonStr()}');

    if (am.ctype == 0) { //图文
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  NewsDetailPage(newsModel: am, tn: 'Advert')));
    } 
    else if (am.ctype == 1) {  //网站
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => WebViewerPage(tn:'News',newsModel: am)));
    }
    // print('点击了第$index个');
  }

  _getAdvertData() async {
    await AdvertBO.getData();
    _lstAdvert = GlobalVar.lstAdvert.values.toList();
    print(
        '@@@ HomePage._getAvertData() GlobalVar.lstAdvert.length : ${GlobalVar.lstAdvert.length}');
    setState(() {});
  }

  _getTData() async {
    await AdvertBO.getTData();
    _lstT = GlobalVar.lstT.values.toList();
    print(
        '@@@ HomePage._getTData() GlobalVar.lstT.length : ${GlobalVar.lstT.length}');
    setState(() {});
  }

  _getNewsData() async {
    await NewsBO.getData();
    if (_lstNews == null) _lstNews = [];
    _lstNews = GlobalVar.lstNews.values.toList();
    setState(() {});
  }

  _getMaterialUI() {
    if (_lstT == null || _lstT.length == 0) {
      return Image.network(GlobalVar.webimageurl + 'advertempty.jpg');
    }

//childAspectRatio设置后的 GridView 高度自动调整，不受设置
    return GridView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 1.0,
          mainAxisSpacing: 1.0,
          childAspectRatio: dAspectRatio),
      itemCount: _lstT.length,
      itemBuilder: (BuildContext context, int index) {
        return _getMaterialUnitUI(index);
      },
      //加此行后取消了GridView的滚动功能，此时SingleChildScrollView能进行全局滚动了
      controller: ScrollController(keepScrollOffset: false),
    );
  }

  _getMaterialUnitUI(index) {
    TModel tm = _lstT[index];
    return GestureDetector(
      onTap: () {
        // print(" HomePage._getMaterialUnitUI id : ${tm.id}");
        // _gotoDemo(context, id);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MaterialListPage(tModel: tm)));
      },
      child: Container(
        // decoration: new BoxDecoration(
        //   border: new Border.all(width: 1.0, color: Colors.black45),
        //   borderRadius: new BorderRadius.all(new Radius.circular(5.0)),
        // ),
        // color: Colors.deepOrangeAccent,
        alignment: Alignment.center,
        // margin: new EdgeInsets.all(1.5),
        // height: dMaterialUnitHeight,
        // width: 60.0,
        child: Column(
          children: <Widget>[
            Expanded(
              // flex: 2,
              child: Image(
                image: AssetImage("images/" + tm.icon),
                width: _iconsize,
                height: _iconsize,
              ),
            ),
            // Container(
            //   height: 3,
            // ),
            Container(
              height: 25.0,
              // color: Colors.cyan,
              child: Text(
                tm.name,
                style: TextStyle(fontSize: 16, color: Colors.black87),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _getNewsBodyUI() {
    if (_lstNews == null)
      return Text(
          '正在查询数据 ...'); // AppWidget.getCircularProgress();//MyControl.waitingWidget(); //

    if (_lstNews.length == 0) return Text('数据为空 !'); //
    // AppWidget.getEmptyData(() {
    //   NewsBO.getData();
    // });

    // return ListView.builder(itemCount: _list.length, itemBuilder: _itemBuilder);  _getListViewUI();// || GlobalVar.exploreState == 1
    return _getNewsListUI();
  }

  _getNewsListUI() {
    List<Widget> _lst = [];
    _lstNews.forEach((nm) {
      _lst.add(_getNewsItemUI(nm));
    });

    return Column(
      children: _lst,
    );
    // Widget divider1 = Divider(
    //   height: 1.0,
    //   color: Colors.grey[400],
    //   indent: 25.0,
    //   endIndent: 25.0,
    // );

    // return ListView.separated(
    //   padding: EdgeInsets.all(0.0),
    //   // controller: _controller,
    //   itemCount: _lstNews.length,
    //   itemBuilder: (BuildContext context, int position) {
    //     return _getNewsItemUI(position);
    //   },
    //   separatorBuilder: (BuildContext context, int index) {
    //     // return index % 2 == 0 ? divider1 : divider2;
    //     return divider1;
    //   },
    //   physics: BouncingScrollPhysics(),
    // );
  }

//
  _getNewsItemUI(NewsModel nm) {
    // NewsModel nm = _lstNews[index];index
    return GestureDetector(
      // onTap: _itemClick(nm.id),
      onTap: () {
        //  print("@@@ _itemClick() id => " + nm.id);
        // Navigator.of(context).pushNamed("/webviewer");
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => NewsDetailPage(newsModel: nm,tn:'News')),
        );
      },
      child: Container(
        // padding: EdgeInsets.only(left: 25, right: 25),
        margin: EdgeInsets.only(left: 25, right: 25),
        height: 50.0,
        decoration: new BoxDecoration(
          border: new Border(
            bottom: BorderSide(
              width: 0.5,
              color: new Color(0xffe3e3e3),
            ),
          ),
        ),
        // child: GestureDetector(
        //     onTap: _itemClick(nm.id),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          // verticalDirection: VerticalDirection.up,
          children: <Widget>[
            Expanded(
              child: Text(
                // (index + 1).toString() + ". " + nm.title,${index + 1}.
                '${nm.title}',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 17,
                  color: new Color(0xff5b5b5c),
                  // fontWeight: FontWeight.w200,
                ),
              ),
            ),
            Text(
              nm.createdt,
              style: TextStyle(
                fontSize: 17,
                color: new Color(0xffaaaaab),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
