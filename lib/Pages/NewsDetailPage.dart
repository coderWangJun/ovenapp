import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:ovenapp/Controls/AppWidget.dart';
import 'package:ovenapp/Models/HttpRetModel.dart';
import 'package:ovenapp/Models/ImageTextModel.dart';
import 'package:ovenapp/Publics/AppStyle.dart';
import 'package:ovenapp/Publics/DataHelper.dart';
import 'package:ovenapp/Publics/GlobalVar.dart';

import '../Models/NewsModel.dart';

import '../Publics/MyControl.dart';
// import '../BusinessObjects/SchoolAffairsBO.dart';

class NewsDetailPage extends StatefulWidget {
  NewsDetailPage({Key key, this.newsModel, this.tn}) : super(key: key);

  // final AffairsModel affairsModel;
  final NewsModel newsModel;
  final String tn;
  // final String title;
  // final int ot;
  // final int id;
  @override
  _NewsDetailPageState createState() => _NewsDetailPageState();
}

class _NewsDetailPageState extends State<NewsDetailPage> {
  // NewsModel _newsModel;
  List<ImageTextModel> _lstData;
  @override
  void initState() {
    super.initState();

// _newsModel=AppPublicData.mpDataModel[widget.id] as NewsModel;
    _getData();
    // _affairsModel = widget.affairsModel;
    print("@@@ => NewsDetailPage.initState()");
    // print("@@@ => newsModel ：${widget.newsModel.toJsonStr()}");
  }

  @override
  Widget build(BuildContext context) {
    print("@@@ => NewsDetailPage.build() ... Start");

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.newsModel.title),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.favorite),
              color: Colors.pinkAccent,
              iconSize: 28.0,
              onPressed: () {}),
        ],
        elevation: 0.0,
        shape: AppWidget.getAppBarBottomBorder(),
      ),
      body:
          _getBody(), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget _getBody() {
    if (_lstData == null) return MyControl.waitingWidget();

    return SingleChildScrollView(
      padding: EdgeInsets.all(10.0),
      child: Column(
        children: _getWidget(),
        // <Widget>[]
      ),
    );
  }

  _getWidget() {
    List<Widget> _lst = [];

    if (widget.tn == 'MyShare' || widget.tn == 'Template') {
//临时显示memo，后期再详细处理
      _lst.add(Container(
        margin: EdgeInsets.only(
          top: 5.0,
          bottom: 5.0,
          left: 5.0,
          right: 5.0,
        ),
        alignment: Alignment.topCenter,
        // alignment: _getTextAlign(dm.halign),
        child: Text(
          widget.newsModel.text,
          style: TextStyle(
            fontSize: 18.0,
            color: AppStyle.clTitle2FC,
          ),
          textAlign: TextAlign.left,
          strutStyle: StrutStyle(
            forceStrutHeight: true,
            height: 1.0,
            leading: 0.8,
          ),
        ),
      ));
    } else {
      //新闻内容
      for (int i = 0; i < _lstData.length; i++) {
        ImageTextModel it = _lstData[i];
        _lst.add(_getItemWidget(it));
      }
    }
    return _lst;
  }

  _getItemWidget(dm) {
    if (dm.ttype == 0) {
      return Container(
        padding: EdgeInsets.all(5.0),
        child: CachedNetworkImage(
          placeholder: (context, url) => AppWidget.getLocalImage('camera.png'),
          imageUrl: GlobalVar.webimageurl + dm.imageurl,
          fadeInCurve: Curves.easeIn,
          fadeOutCurve: Curves.easeOut,
          // alignment: Alignment.topCenter,
          fit: BoxFit.contain,
          // color: Colors.red,
        ),
      ); // Image.network(dm.mainpic);
    } else {
      return Container(
        margin: EdgeInsets.only(
          top: 5.0,
          bottom: 5.0,
          left: 5.0,
          right: 5.0,
        ),
        alignment: Alignment.topCenter,
        // alignment: _getTextAlign(dm.halign),
        child: Text(
          dm.text,
          style: TextStyle(
            fontSize: 18.0,
            color: AppStyle.clTitle2FC,
          ),
          textAlign: _getTextAlign(dm.halign), //TextAlign.center,
          strutStyle: StrutStyle(
            forceStrutHeight: true,
            height: 1.0,
            leading: 0.8,
          ),
        ),
      );
    }
  }

  _getTextAlign(String halign) {
    return halign == 'left' ? TextAlign.left : TextAlign.center;
  }
  // void _publishNews(int id) async {
  //   // print("@@@ SchoolAffairsBO._publishNews() affairsmodel.id => " +
  //   //     affairsmodel.id.toString());

  //   var param = {"id": id};

  //   String sret = await HttpCallerSrv.post(
  //       "News/PublishNews", param, GlobalVar.userInfo.tk);
  //   // print("@@@ SchoolAffairsBO._publishNews() data => " + sret);
  //   Map<String, dynamic> ret = json.decode(sret);
  //   HttpRetModel retmodel = HttpRetModel.fromJsonExec(ret);
  //   if (retmodel.ret == 0) {
  //     setState(() {
  //       _newsModel.status = 1;
  //     });
  //   }
  //   // print("@@@ SchoolAffairsBO._publishNews() HttpRetModel.message => " +
  //   //     retmodel.message);
  // }

  _getData() async {
    var param = {
      "tn": widget.tn,
      "tid": widget.newsModel.id,
    };

    List<dynamic> lstObj = [
      ImageTextModel(),
    ];

    await DataHelpr.dataQuerier('ImageText', param, lstObj, (ret) {
      HttpRetModel rm = ret as HttpRetModel;

      // print(
      //     '@@@ NewsDetailPage._getData() Cloud data rm.ret : ${rm.ret} , data.length : ${rm.data?.length}');
      // print(
      //     '@@@ AppPublicData.getTemplate selectData => ret : ${rm.ret} , data.length : ${rm.data.length} , data1.length : ${rm.data1.length}');

      if (rm.ret == 0) {
        // GlobalVar.lstTemplate[tid] = tm;
        _setData(rm);
        setState(() {});
      }
    });
  }

  _setData(HttpRetModel rm) {
    // print(
    //     '@@@ NewsDetailPage._setData() rm.ret : ${rm.ret}');
    _lstData = []; //***这个地方要特别注意，如果不初始化的话下面的就加不进去了
    for (int i = 0; i < rm.data.length; i++) {
      // var it= rm.data[i];
      ImageTextModel tm = rm.data[i] as ImageTextModel;
      // print('@@@ NewsDetailPage._setData() tm : ${tm.toJsonStr()}');
      _lstData.add(tm);
    }
  }
}
