import 'package:flutter/material.dart';
import 'package:flutter_refresh/flutter_refresh.dart';
import 'package:ovenapp/Controls/AppWidget.dart';
import 'package:ovenapp/Models/HttpRetModel.dart';
import 'package:ovenapp/Models/NewsModel.dart';
import 'package:ovenapp/Pages/NewsDetailPage.dart';
import 'package:ovenapp/Publics/AppStyle.dart';
// import 'package:ovenapp/Publics/AppStyle.dart';
import 'package:ovenapp/Publics/DataHelper.dart';
import 'package:ovenapp/Publics/GlobalVar.dart';

class NewsListPage extends StatefulWidget {
  @override
  _NewsListPageState createState() => _NewsListPageState();
}

class _NewsListPageState extends State<NewsListPage> {
  List<dynamic> _lstData;
  // int _ii = 1;
  int _pn = 1;
  // int _totalcount = 0;
  int _pagecount = 0;
// Future<List<dynamic>> fData;
  // Future fData;

  @override
  void initState() {
    super.initState();
    // _lstData = [];
    _getData();
    // fData =_getList();// Future.value(_lstData);
    print("@@@ => NewsListPage.initState() ... ");
  }

  @override
  void dispose() {
    super.dispose();
    // _streamController.close();
    print("@@@ NewsListPage.dispose() ...");
  }

  @override
  Widget build(BuildContext context) {
    print("@@@ NewsListPage.build() ...");
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: AppStyle.mainBackgroundColor,
        title: Text('新闻列表'),
        elevation: 0.0,
        shape: AppWidget.getAppBarBottomBorder(),
        // actions: _getActions(),
      ),
      body: _getBodyUI(),
      // Refresh(
      //   onFooterRefresh: onFooterRefresh,
      //   onHeaderRefresh: onHeaderRefresh,
      //   child: _getBodyUI(),
      //   //ListView.builder(itemCount: _list.length, itemBuilder: _itemBuilder),
      // ), //_getRefreshUI(), //_getTemplateListFB(),
    );
  }

  // _getRefreshUI() {
  //   return Refresh(
  //     onFooterRefresh: onFooterRefresh,
  //     onHeaderRefresh: onHeaderRefresh,
  //     child: _getListViewUI(),
  //   );
  // }

  _getBodyUI() {
    //注：此处为什么会在数据加载完毕后重新显示，是因为在 _getData里面使用了 setState((){}),不然数据不会刷新
    print('@@@ NewsListPage._getBodyUI() begin ... ');
    if (_lstData == null) return AppWidget.getCircularProgress();

    if (_lstData.length == 0)
      return AppWidget.getEmptyData(() {
        _refreshData();
      });

    // return ListView.builder(itemCount: _list.length, itemBuilder: _itemBuilder);  _getListViewUI();//
    return Refresh(
      onFooterRefresh: onFooterRefresh,
      onHeaderRefresh: onHeaderRefresh,
      child: _getListViewUI(),
      //  ListView.builder(
      //   itemCount: _lstData.length,
      //   itemBuilder: (context, index) {
      //     return _getLine(index);
      //   },
      // ),
      //ListView.builder(itemCount: _list.length, itemBuilder: _itemBuilder),
    );
    //_getListViewUI();
    //ListView.builder(itemCount: _lstData.length, itemBuilder: (context,index){ return Text(index.toString()+'.'+_lstData[index].name);});
  }

  _refreshData() {
    _lstData.clear();
    _pn = 1;
    _getData();
  }

  _getListViewUI() {
    Widget divider1 = Divider(
      height: 4.0,
      color: Colors.grey[400],
      indent: 0.0,
      endIndent: 0.0,
    );
    // Widget divider2 = Divider(color: Colors.green);
    //ListView.separated 比 ListView.builder 多了一个分隔器  itemExtent: 50.0, //强制高度为50.0
    // return ListView.builder(
    //   itemCount: _lstData.length,
    //   itemBuilder: (context, index) {
    //     return _getLine(index);
    //   },
    // );
    return ListView.separated(
      padding: EdgeInsets.all(0.0),
      itemCount: _lstData.length,
      itemBuilder: (BuildContext context, int position) {
        return _getLine(position);
      },
      separatorBuilder: (BuildContext context, int index) {
        // return index % 2 == 0 ? divider1 : divider2;
        return divider1;
      },
    );
  }

  _getLine(_index) {
    NewsModel tm = _lstData[_index] as NewsModel;
    // return ListTile(
    //   title: Text(
    //     tm.title,
    //   ),
    // );
    // print('@@@ memo : ${tm.memo}');
    return Container(
      height: 60.0,
      width: double.infinity,
      // color: Colors.cyan,
      margin: EdgeInsets.only(left: 12.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: GestureDetector(
              child: Text(
                tm.title,
                style: TextStyle(fontSize: 18.0, color: Colors.black87),
              ),
              onTap: () {
                _showNewsDetail(tm);
              },
            ),
          ),

          Container(
            width: 90.0,
            alignment: Alignment.center,
            // color: Colors.pinkAccent,
            child: Text(
              tm.createdt.substring(0, 10),
              style: TextStyle(fontSize: 16.0, color: Colors.grey),
            ),
          ),

//按钮
          Container(
            // color: Colors.orangeAccent,
            alignment: Alignment.centerLeft,
            width: 25.0,
            child: IconButton(
                // color: AppStyle.clButtonGray,
                icon: Icon(
                  Icons.star,
                  size: 24.0,
                  color: tm.collect == 0 ? Colors.grey[400] : Colors.deepOrange,
                ),
                // iconSize: 26.0,
                padding: EdgeInsets.all(0.0),
                onPressed: () {
                  _collectNews(tm);
                }),
          ),
          SizedBox(
            width: 3.0,
          ),
          // onTap: () {
          //   Navigator.push(context,
          //       MaterialPageRoute(builder: (context) => TemplatePage(tm: tm)));
          // },
        ],
      ),
    );
  }

  _collectNews(tm) {
    DataHelpr.dataHandler('Favorites/Add', {"id": tm.id, "tn": 0}, (rm) {
      DataHelpr.resultHandler(rm, () {
        setState(() {
          tm.collect = 1;
        });
      });
    });
  }

  _showNewsDetail(nm) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => NewsDetailPage(newsModel: nm, tn: 'News')));
  }

  _getData() async {
    // _lstData = []; //此处类型必须为 dynamic,不然转换不过来
    // if (_lstData == null) _lstData = [];

    if (_lstData != null)
      print(
          '@@@ NewsListPage._getData begin ... _lstData.length : ${_lstData.length}');

    var param = {
      "pageno": _pn,
      "orderby": "CreateDT DESC",
    };

    if (GlobalVar.userInfo != null)
      param = {
        "pageno": _pn,
        "orderby": "CreateDT DESC",
        "cid": GlobalVar.userInfo.id,
      };

    await DataHelpr.dataQuerier('News/List', param, [NewsModel()], (ret) {
      HttpRetModel rm = ret as HttpRetModel;
      // print(
      //     '@@@ NewsListPage._getData rm.pagecount : ${rm.pagecount} , rm.totalcount : ${rm.totalcount} , data.length : ${rm.data.length}');
      if (rm.ret == 0) {
        // _totalcount = rm.totalcount;
        if (_lstData == null) _lstData = [];
        _pagecount = rm.pagecount;

        // print('@@@ NewsListPage._getData _pagecount:$_pagecount , _pn:$_pn');

        for (int i = 0; i < rm.data.length; i++) {
          _lstData.add(rm.data[i]);
        }
        _pn++;

        if (mounted) {
          setState(() {});
        }
      }
      // print(
      //     '@@@ NewsListPage._getData _lstData.length : ${_lstData.length}, _pn:$_pn');
    });

    // return _lstData;
  }

  Future<Null> onFooterRefresh() {
    print(
        "@@@ TemplateListPage.onFooterRefresh() _pagecount:$_pagecount , _pn:$_pn");
    return Future.delayed(Duration(milliseconds: 100), () {
      if (_pagecount >= _pn) {
        _getData();
      }
    });
  }

  Future<Null> onHeaderRefresh() {
    print("@@@ TemplateListPage.onHeaderRefresh() ");
    return new Future.delayed(new Duration(milliseconds: 100), () {
      // setState(() {
      // _itemCount = 10;
      _refreshData();
      // });
      // });
    });
  }
}
