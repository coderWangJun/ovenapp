import 'dart:async';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:extended_image/extended_image.dart';

// import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:ovenapp/Classes/SharePrefHelper.dart';
import 'package:ovenapp/Models/NewsModel.dart';
import 'package:ovenapp/Pages/NewsDetailPage.dart';
import 'package:ovenapp/Publics/AppPublicData.dart';
import 'package:ovenapp/Publics/MyControl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:ovenapp/Controls/AppWidget.dart';
import 'package:ovenapp/Models/HttpRetModel.dart';
import 'package:ovenapp/Models/MyShareModel.dart';
import 'package:ovenapp/Publics/AppStyle.dart';
import 'package:ovenapp/Publics/DataHelper.dart';
import 'package:ovenapp/Publics/GlobalVar.dart';
import 'package:ovenapp/Services/EventBusSrv.dart';

class ExplorePage extends StatefulWidget {
  @override
  _ExplorePageState createState() => new _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  int ft = 0; //条件过滤 0全部，1模板，2心得
  var _scaffoldkey = GlobalKey<ScaffoldState>();
  var _onPageDataEvent;
  String searchStr = '';

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  final StreamController<double> _streamController = StreamController<double>();

  void _onRefresh() async {
    print('@@@ ExplorePage._onRefresh() _isRefreshable : $_isRefreshable');
    // if(_isRefreshable!=1) return;
    // _isRefreshable=0;
    _refreshData();
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 300));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();

    // Timer(Duration(seconds: 5), (){_isRefreshable=1;});
  }

  void _onLoading() async {
    print('@@@ ExplorePage._onLoading() _pagecount : $_pagecount , _pn : $_pn');
    if (_pagecount <= _pn) return;
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 300));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    // items.add((items.length+1).toString());
    if (mounted)
      setState(() {
        _getData();
      });
    _refreshController.loadComplete();
  }

  List<dynamic> _lstData;
  // int _ii = 1;
  int _pn = 0;
  // int _totalcount = 0;
  int _pagecount = 100000;

  int _isRefreshable = 1;
  String spfile;
  // var _onPageDataEvent;

  @override
  void initState() {
    super.initState();

    spfile = GlobalVar.spexplore;

    // _getData();
    _initData(); //缓存第一包数据的情况
    _controller.addListener(() {
      // print(
      //     "@@@ => ExplorePage._controller.Listener() _controller.position.pixels : ${_controller.position.pixels} ");
      if (_controller.position.pixels > 300 && _dFABHeight == 0.0) {
        _dFABHeight = 40.0;
        _streamController.sink.add(_dFABHeight);
      } else if (_controller.position.pixels < 300 && _dFABHeight == 40.0) {
        _dFABHeight = 0.0;
        _streamController.sink.add(_dFABHeight);
      }
    });

    _onPageDataEvent = eventBus.on<PageDataEvent>().listen((event) {
      if (event.page == 'explorepage') {
        _getData();
      }
    });
    // _getData();
    print("@@@ => ExplorePage.initState() ... ");
  }

  @override
  void dispose() {
    super.dispose();
    _onPageDataEvent.cancel();
    // _controller.dispose();
    _streamController.close();
    print("@@@ ExplorePage.dispose() ...");
  }

  double _dItemHeight = 85.0;
  double _dFABHeight = 0.0;
  ScrollController _controller = ScrollController();

// class ExplorePage extends StatelessWidget {
  // final double _power=3.0;
  // final bool _isOpen=false;
  @override
  Widget build(BuildContext context) {
    print("@@@ ExplorePage.build() ...");

    return Scaffold(
      key: _scaffoldkey,
      appBar: AppBar(
        // leading: null,
        // title: new Text('发现'),
        title: AppWidget.getSearcherTF('搜索关键字', (tn, v) {
          // print('@@@ tn : $tn , v : $v');
          searchStr = v;
          _refreshData();
        }, searchStr), //getSeacherTF(), //_getSearchTextField(),
        actions: _getActions(),
        backgroundColor: AppStyle.clTitleBC,
      ),
      body: SafeArea(
        minimum: EdgeInsets.only(top: 12.0),
        child: SmartRefresher(
          enablePullDown: true,
          enablePullUp: _pagecount > _pn,
          // onOffsetChange: (){},
          header: MaterialClassicHeader(
            backgroundColor: Colors.blueAccent,
          ), //WaterDropMaterialHeader(backgroundColor:  Color(0xFFE82662),),
          footer: CustomFooter(
            builder: (BuildContext context, LoadStatus mode) {
              Widget body;
              if (mode == LoadStatus.idle) {
                body = Text("正在加载数据 ...");
                // return SizedBox(height: 0.0,);
              } else if (mode == LoadStatus.loading) {
                body = CupertinoActivityIndicator();
                //  CircularProgressIndicator(
                //   backgroundColor: Colors.blueAccent,
                // );
              } else if (mode == LoadStatus.failed) {
                body = Text("加载失败，请重试!");
              } else if (mode == LoadStatus.canLoading) {
                body = Text("松开加载更多数据 ...");
              } else {
                body = Text("我是有底线的 ...");
              }
              return Container(
                height: 60.0,
                child: Center(child: body),
              );
            },
          ),
          controller: _refreshController,
          onRefresh: _onRefresh,
          onLoading: _onLoading,
          child: _getBodyUI(),
        ),
      ),
      floatingActionButton: _getFABHeight(),
    );
  }

  _getFABHeight() {
    // print("@@@ ExplorePage._getFABHeight() _dFABHeight : $_dFABHeight");
    return StreamBuilder<double>(
        stream: _streamController.stream,
        initialData: _dFABHeight,
        builder: (BuildContext context, AsyncSnapshot<double> snapshot) {
          // _dFABHeight = snapshot.data>300.0?40.0:0.0;
          if (_dFABHeight == 0.0)
            return SizedBox(
              height: 1.0,
              width: 1.0,
            );

          return Container(
            height: _dFABHeight,
            width: 40.0,
            child: FloatingActionButton(
              heroTag: 'exploregotop',
              onPressed: () {
                _scrollTo(_controller.position.minScrollExtent);
              },
              backgroundColor: Colors.black12,
              foregroundColor: Colors.white,
              highlightElevation: 0.0,
              elevation: 0.0,
              child: Icon(
                Icons.vertical_align_top,
                size: 24.0,
              ),
            ),
          );
        });
// return _controller.position.pixels>400?40.0:0.0;
  }

  _getBodyUI() {
    // print('@@@ ExplorePage._getBodyUI() begin ... ');
    if (_lstData == null)
      return MyControl.waitingWidget(); // AppWidget.getCircularProgress();

    if (_lstData.length == 0)
      return AppWidget.getEmptyData(() {
        _refreshData();
      });

    // return ListView.builder(itemCount: _list.length, itemBuilder: _itemBuilder);  _getListViewUI();// || GlobalVar.exploreState == 1
    return _getListUI();
  }

  List<Widget> _getActions() {
    return <Widget>[
      // IconButton(icon: Icon(Icons.search),tooltip: '搜索', iconSize: 35, onPrssed: null),//标题右侧按钮
      FlatButton(
        child: Text(
          '条件过滤',
          style: const TextStyle(
            color: Colors.blueAccent,
            fontSize: 18.0,
            decoration: TextDecoration.underline,
            decorationColor: Colors.blueAccent,
          ),
        ),
        onPressed: () {
          _popMenu(context);
        },
      ),

      // IconButton(
      //     icon: Icon(
      //       Icons.add,
      //       color: AppStyle.clButtonGray,
      //     ),
      //     // tooltip: '新增设备',
      //     iconSize: 32.0,
      //     onPressed: () {
      //       _showPopupMenuButton();
      //     }),
    ];
  }

  _scrollTo(offset) {
    //  _controller.jumpTo(_controller.position.maxScrollExtent);
    // _controller.jumpTo(_controller.position.minScrollExtent);
    _controller.animateTo(
      offset,
      // _controller.position.minScrollExtent,
      duration: Duration(milliseconds: 600), // 300ms
      curve: Curves.bounceIn, // 动画方式
    );
  }

  _popMenu(context) {
    // RenderBox box = context.findRenderObject();
    // Offset offset = box.localToGlobal(Offset.zero);
    // Size size = box.size;
    // double l = offset.dx + size.width / 4;
    // double t = offset.dy + size.height / 3;
    double dTop = MediaQueryData.fromWindow(window).padding.top + 56.0;
    print("_popMenu() dTop : $dTop");
    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(1000.0, dTop, 0.0, 0.0),
      items: <PopupMenuItem<String>>[
        PopupMenuItem(value: "0", child: new Text("全部")),
        PopupMenuItem(value: "1", child: Text("模板")),
        PopupMenuItem(value: "2", child: Text("心得")),
        // PopupMenuItem(value: "3", child: Text("打印列表")),
      ],
      // items: <PopupMenuEntry>[
      //   PopupMenuItem(value: "0", child: Text("移除")),
      //   PopupMenuDivider(),
      // ],
    ).then((v) {
      ft = int.parse(v);
      _refreshData();

      // // print("selected : $v");
      // if (v == "0") {
      //   // print("position ：${_controller.position.pixels}");
      //   SharePrefHelper.removeData(spfile);
      //   // _streamController.sink.add(_controller.position.pixels);
      // } else if (v == "1") {
      //   // print("position ：${_controller.position.pixels}");
      //   _getData();
      //   // _streamController.sink.add(_controller.position.pixels);
      // } else if (v == "2") {
      //   // print("position ：${_controller.position.pixels}");
      //   _getSP();
      //   // _streamController.sink.add(_controller.position.pixels);
      // } else if (v == "3") {
      //   print("_lstData.length : ${_lstData?.length}");
      //   // _streamController.sink.add(_controller.position.pixels);
      // }
    });
    // print("_popMenu");
    // return PopupMenuButton(
    //   itemBuilder: (context) => <PopupMenuItem<String>>[
    //     new PopupMenuItem(value: "0", child: new Text("选项一")),
    //     new PopupMenuItem(value: "1", child: new Text("选项二"))
    //   ],
    //   onSelected: (value) {
    //     print("onSelected");
    //   },
    //   onCanceled: () {
    //     print("onCanceled");
    //   },
    // );
  }

  _getSP() async {
    String str = await SharePrefHelper.getData(spfile);
    print("jsonStr ：$str");
  }

  _refreshData() {
    if (_isRefreshable == 0) return;
    _isRefreshable = 0;
    Timer(Duration(seconds: 5), () {
      _isRefreshable = 1;
    });
    _lstData.clear();
    _pn = 0;
    _pagecount = 100000;
    AppPublicData.mpDataList.remove(spfile);
    SharePrefHelper.removeData(spfile);
    _getData();
  }

  _getListUI() {
    Widget divider1 = Divider(
      height: 4.0,
      color: Colors.grey[400],
      indent: 75.0,
      endIndent: 15.0,
    );
    // Widget divider2 = Divider(color: Colors.green);
    //ListView.separated 比 ListView.builder 多了一个分隔器  itemExtent: 50.0, //强制高度为50.0
    // return ListView.builder(
    //   itemCount: _lstData.length,
    //   itemBuilder: (context, index) {
    //     return _getLine(index);
    //   },
    // );
    return
        // MediaQuery.removePadding(
        //   removeTop: true,
        //   context: context,
        //   child:
        ListView.separated(
      padding: EdgeInsets.all(0.0),
      controller: _controller,
      itemCount: _lstData.length,
      itemBuilder: (BuildContext context, int position) {
        return _getLine(position);
      },
      separatorBuilder: (BuildContext context, int index) {
        // return index % 2 == 0 ? divider1 : divider2;
        return divider1;
      },
      physics: BouncingScrollPhysics(),
    );
  }

  _getLine(_index) {
    MyShareModel mm = _lstData[_index] as MyShareModel;
    // return ListTile(
    //   title: Text(
    //     tm.title,
    //   ),
    // );
    // print('@@@ memo : ${tm.memo}');
    return GestureDetector(
      child: Container(
        height: _dItemHeight,
        width: double.infinity,
        // color: Colors.cyan,
        margin: EdgeInsets.only(left: 8.0),
        child: Row(
          children: <Widget>[
            //图片
            Container(
              // height:60.0,
              margin: EdgeInsets.only(right: 10.0),
              child: _getMainPic(mm),
              // ClipRRect(
              //   // clipper: CustomClipper<RRect>(3.0),
              //   borderRadius: BorderRadius.all(Radius.circular(3.5)),
              //   clipBehavior: Clip.antiAlias,
              //   child: AppWidget.getCachImage(mm.mainpic),
              // ),
              width: 60.0,
              height: 60.0,
              // color: Colors.deepOrangeAccent,
            ),

            Expanded(
              child: Container(
                height: double.infinity,
                width: double.infinity,
                margin: EdgeInsets.only(top: 5.0, bottom: 5.0),
                child: Column(
                  children: <Widget>[
                    Container(
                      //  color: Colors.pinkAccent,
                      height: 30.0,
                      alignment: Alignment.centerLeft,
                      child: Text(
                        mm.title,
                        style: TextStyle(
                          fontSize: 19.0,
                          color: Colors.black87,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Expanded(
                      child: Container(
                        // color: Colors.orangeAccent,
                        // height: 30.0,
                        alignment: Alignment.topLeft,
                        child: Text(
                          mm.memo,
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.grey,
                            // letterSpacing: -3.0,
                          ),
                          overflow: TextOverflow.ellipsis,
                          softWrap: true,
                          maxLines: 2,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Container(
            //   width: 80.0,
            //   alignment: Alignment.center,
            //   // color: Colors.pinkAccent,
            //   child: Text(
            //     mm.createdt.substring(0, 10),
            //     style: TextStyle(fontSize: 16.0, color: Colors.grey),
            //   ),
            // ),

//按钮
            Container(
              // color: Colors.orangeAccent,
              alignment: Alignment.centerLeft,
              width: 45.0,
              child: IconButton(
                  // color: AppStyle.clButtonGray,
                  icon: Icon(
                    Icons.keyboard_arrow_right,
                    size: 32.0,
                    color: Colors.grey[400],
                  ),
                  // iconSize: 26.0,
                  padding: EdgeInsets.all(0.0),
                  onPressed: () {
                    _collectNews(mm.id);
                  }),
            ),
            // onTap: () {
            //   Navigator.push(context,
            //       MaterialPageRoute(builder: (context) => TemplatePage(tm: tm)));
            // },
          ],
        ),
      ),
      onTap: () {
        _showDetail(mm);
      },
    );
  }

  _getMainPic(mm) {
    if (mm.mainpic == null || mm.mainpic == '') {
      return Icon(Icons.near_me);
    }

    return ExtendedImage.network(
      GlobalVar.webimageurl + mm.mainpic,
      width: double.infinity,
      height: double.infinity,
      fit: BoxFit
          .cover, //AppFileHelper.getBoxFit(file, size, size),//getCircleBoxFit(file), //BoxFit.fitWidth,
      cache: true,
      // border: Border.all(color: clBorder, width: dBorderWidth),
      shape: BoxShape.circle,
      borderRadius: BorderRadius.all(Radius.circular(60.0)),
    );

    // return CircleAvatar(
    //   // clipper: CustomClipper<RRect>(3.0),
    //   // backgroundImage: NetworkImage(GlobalVar.webimageurl + mm.mainpic),
    //   // backgroundColor: Colors.transparent,
    //   child: ExtendedImage.network(
    //   GlobalVar.webimageurl + mm.mainpic,
    //   width: double.infinity,
    //   height: double.infinity,
    //   fit: BoxFit.cover,//AppFileHelper.getBoxFit(file, size, size),//getCircleBoxFit(file), //BoxFit.fitWidth,
    //   cache: true,
    //   // border: Border.all(color: clBorder, width: dBorderWidth),
    //   shape: BoxShape.circle,
    //   borderRadius: BorderRadius.all(Radius.circular(60.0)),
    // ),
    //   // child: CachedNetworkImage(
    //   //   placeholder: (context, url) =>
    //   //       Image.asset("images/camera.png"),
    //   //   imageUrl:
    //   //       GlobalVar.webimageurl + GlobalVar.userInfo.avatar ??
    //   //           'camera.png',
    //   //   fadeInCurve: Curves.easeIn,
    //   //   fadeOutCurve: Curves.easeOut,
    //   //   fit: BoxFit.cover,
    //   //   height: 80.0,
    //   //   width: 80.0,
    //   // ),
    //   radius: 60.0,
    //   // borderRadius: BorderRadius.all(Radius.circular(3.5)),
    //   // clipBehavior: Clip.antiAlias,
    //   // child: AppWidget.getCachImage(mm.mainpic),
    // );
  }

  _collectNews(id) {
    DataHelpr.dataHandler('Favorites/Add', {"id": id, "tn": 0}, (rm) {
      DataHelpr.resultHandler(rm, () {});
    });
  }

  _showDetail(MyShareModel sm) {
    // print("@@@ ExplorePage._showDetail() id : $id");
    String tn = 'MyShare';
    if (sm.ot == 0) tn = 'Template';
    NewsModel nm = NewsModel(id: sm.id, title: sm.title, text: sm.memo);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => NewsDetailPage(
                  newsModel: nm,
                  tn: tn,
                )));
  }

//缓存第一波数据的情况
  _initData() async {
    if (AppPublicData.mpDataList.containsKey(spfile)) {
      _lstData = AppPublicData.mpDataList[spfile];
      _pn++;
      print('@@@ ExplorePage._getData() Cache Data : $spfile');
      if (mounted) {
        setState(() {});
      }
    }

    if (_lstData == null) {
      if (SharePrefHelper.appPrefs.containsKey(spfile)) {
        String jsonData = await SharePrefHelper.getData(spfile);
        // print('@@@ AppPublicData._getTemplates() SharePref Data : $jsonData');
        if (jsonData != null && jsonData != "") {
          try {
            // Map<String, dynamic> ret = json.decode(jsonData);
            // HttpRetModel rm = HttpRetModel.fromJson(ret, TemplateModel());
            HttpRetModel rm =
                HttpRetModel.fromJsonStr(jsonData, [MyShareModel()]);
            if (rm.ret == 0) {
              print('@@@ ExplorePage._getData() SharePref data : $spfile');
              _lstData = rm.data;
              AppPublicData.mpDataList[spfile] = _lstData;
              _pn++;
              if (mounted) {
                setState(() {});
              }
            }
          } catch (e) {
            // AppPublicData.mpTables.remove(spfile);
            SharePrefHelper.removeData(spfile);
            print('*** ExplorePage._getData() SharePref data e : $e');
            // isQueryData = true;
          }
        }
      }
    }

    if (_lstData == null) {
      _getData();
    }
  }

  _getData() async {
    // GlobalVar.exploreState = 2;

    print('@@@ ExplorePage._getData _pagecount : $_pagecount , _pn : $_pn');

    //  GlobalVar.userInfo.id + 'templates';
    // if (_pn == 0) {}

    if (_pagecount < _pn) return;

    var param = {
      "pageno": _pn + 1,
      "orderby": "CreateDT DESC",
      "querystr": searchStr.trim(),
    };

    await DataHelpr.dataQuerier('Explore/List', param, [MyShareModel()], (ret) {
      HttpRetModel rm = ret as HttpRetModel;
      print(
          '@@@ ExplorePage._getData cloud data rm.pagecount : ${rm.pagecount} , rm.totalcount : ${rm.totalcount} , data.length : ${rm.data.length}');
      if (rm.ret == 0) {
        // _totalcount = rm.totalcount;
        if (_lstData == null) _lstData = [];
        _pagecount = rm.pagecount;

        // print('@@@ ExplorePage._getData _pagecount:$_pagecount , _pn:$_pn');

        for (int i = 0; i < rm.data.length; i++) {
          _lstData.add(rm.data[i]);
        }

        if (_pn == 0 && _lstData.length > 0 && searchStr == '')
          AppPublicData.mpDataList[spfile] = _lstData;

        _pn++;

        if (mounted) {
          setState(() {
            if (_pn > 1) {
              _scrollTo(_dItemHeight * 10 * (_pn - 1) + 0 * _dItemHeight);
            }
          });
        }
      }
      // print(
      //     '@@@ ExplorePage._getData _lstData.length : ${_lstData.length}, _pn:$_pn');
    }, (_pn == 0 ? spfile : ''));

    // return _lstData;
  }

  // Future<Null> onFooterRefresh() {
  //   print(
  //       "@@@ ExplorePage.onFooterRefresh() _pagecount:$_pagecount , _pn:$_pn");
  //   return Future.delayed(Duration(milliseconds: 100), () {
  //     if (_pagecount >= _pn) {
  //       _getData();
  //     }
  //   });
  // }

  // Future<Null> onHeaderRefresh() {
  //   print("@@@ ExplorePage.onHeaderRefresh() ");
  //   return new Future.delayed(new Duration(milliseconds: 100), () {
  //     // setState(() {
  //     // _itemCount = 10;
  //     _refreshData();
  //     // });
  //     // });
  //   });
  // }
}
