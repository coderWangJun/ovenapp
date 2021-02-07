import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ovenapp/Models/TModel.dart';
import 'package:ovenapp/Pages/MaterialDetailPage.dart';
import 'package:ovenapp/Publics/AppStyle.dart';
import 'package:ovenapp/Publics/GlobalVar.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:ovenapp/Controls/AppWidget.dart';
import 'package:ovenapp/Models/HttpRetModel.dart';
import 'package:ovenapp/Models/MaterialModel.dart';
import 'package:ovenapp/Publics/DataHelper.dart';
import 'package:ovenapp/Publics/MyControl.dart';

class MaterialListPage extends StatefulWidget {
  MaterialListPage({Key key, this.tModel}) : super(key: key);

  final TModel tModel;

  @override
  _MaterialListPageState createState() => _MaterialListPageState();
}

class _MaterialListPageState extends State<MaterialListPage> {
  List<dynamic> _lstData;
  var _scaffoldkey = GlobalKey<ScaffoldState>();
  // var _onPageDataEvent;

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  final StreamController<double> _streamController = StreamController<double>();

  void _onRefresh() async {
    print('@@@ MaterialListPage._onRefresh() _isRefreshable : $_isRefreshable');
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
    print(
        '@@@ MaterialListPage._onLoading() _pagecount : $_pagecount , _pn : $_pn');
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

  // List<dynamic> _lstData = [];
  // int _ii = 1;
  int _pn = 0;
  // int _totalcount = 0;
  int _pagecount = 12;

  int _isRefreshable = 1;

  @override
  void initState() {
    super.initState();

    _getData();
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

    // _onPageDataEvent = eventBus.on<PageDataEvent>().listen((event) {
    //   if (event.page == 'explorepage') {
    //     _getData();
    //   }
    // });
    // _getData();
    print("@@@ => ExplorePage.initState() ... ");
  }

  @override
  void dispose() {
    super.dispose();
    // _onPageDataEvent.cancel();
    // _controller.dispose();
    _streamController.close();
    print("@@@ ExplorePage.dispose() ...");
  }

  double _dItemHeight = 80.0;
  double _dFABHeight = 0.0;
  ScrollController _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    print("@@@ => NewsDetailPage.build() ... Start");

    return Scaffold(
      key: _scaffoldkey,
      appBar: AppBar(
        leading: null,
        // title: new Text('发现'),
        title: AppWidget.getSearcherTF('搜索关键字', (tn, v) {
          print('@@@ tn : $tn , v : $v');
        }), //getSeacherTF(), //_getSearchTextField(),
        // actions: _getActions(),
        backgroundColor: AppStyle.clTitleBC,
        elevation: 0.0,
        shape: AppWidget.getAppBarBottomBorder(),
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
                body = CircularProgressIndicator(
                  backgroundColor: Colors.blueAccent,
                );
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
    print("@@@ ExplorePage._getFABHeight() _dFABHeight : $_dFABHeight");
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
    if (_lstData == null) return MyControl.waitingWidget();

    if (_lstData.length == 0)
      return AppWidget.getEmptyData(() {
        _refreshData();
      });

    // return ListView.builder(itemCount: _list.length, itemBuilder: _itemBuilder);  _getListViewUI();//
    return _getListViewUI();
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

  _refreshData() {
    if (_isRefreshable == 0) return;
    _isRefreshable = 0;
    Timer(Duration(seconds: GlobalVar.refreshtime), () {
      _isRefreshable = 1;
    });
    _lstData.clear();
    _pn = 0;
    _pagecount = 12;

    _getData();
  }

  _getListViewUI() {
    Widget divider1 = Divider(
      height: 4.0,
      color: Colors.grey[400],
      indent: 75.0,
      endIndent: 0.0,
    );

    return ListView.separated(
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
    MaterialModel mm = _lstData[_index] as MaterialModel;
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
                        mm.name,
                        style: TextStyle(fontSize: 19.0, color: Colors.black87),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        // color: Colors.orangeAccent,
                        height: 30.0,
                        alignment: Alignment.topLeft,
                        child: Text(
                          mm.memo,
                          style: TextStyle(fontSize: 16.0, color: Colors.grey),
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
      return Icon(Icons.hearing);
    }
    return CircleAvatar(
      // clipper: CustomClipper<RRect>(3.0),
      backgroundImage: NetworkImage(GlobalVar.webimageurl + mm.mainpic),
      backgroundColor: Colors.transparent,
      // child: CachedNetworkImage(
      //   placeholder: (context, url) =>
      //       Image.asset("images/camera.png"),
      //   imageUrl:
      //       GlobalVar.webimageurl + GlobalVar.userInfo.avatar ??
      //           'camera.png',
      //   fadeInCurve: Curves.easeIn,
      //   fadeOutCurve: Curves.easeOut,
      //   fit: BoxFit.cover,
      //   height: 80.0,
      //   width: 80.0,
      // ),
      radius: 60.0,
      // borderRadius: BorderRadius.all(Radius.circular(3.5)),
      // clipBehavior: Clip.antiAlias,
      // child: AppWidget.getCachImage(mm.mainpic),
    );
  }

  _collectNews(id) {
    DataHelpr.dataHandler('Favorites/Add', {"id": id, "tn": 0}, (rm) {
      DataHelpr.resultHandler(rm, () {});
    });
  }

  _showDetail(mm) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => MaterialDetailPage(materialModel: mm)));
    print("@@@ ExplorePage._showDetail() id : ${mm.id}");
  }

  _getData() async {
    print('@@@ ExplorePage._getData _pagecount : $_pagecount , _pn : $_pn');

    var param = {
      "t1": widget.tModel.id,
      "pageno": _pn + 1,
      "orderby": "CreateDT DESC",
    };

    await DataHelpr.dataQuerier('Material/List', param, [MaterialModel()],
        (ret) {
      HttpRetModel rm = ret as HttpRetModel;
      // print(
      //     '@@@ ExplorePage._getData rm.pagecount : ${rm.pagecount} , rm.totalcount : ${rm.totalcount} , data.length : ${rm.data.length}');
      if (rm.ret == 0) {
        // _totalcount = rm.totalcount;
        if (_lstData == null) _lstData = [];
        _pagecount = rm.pagecount;

        // print('@@@ ExplorePage._getData _pagecount:$_pagecount , _pn:$_pn');

        for (int i = 0; i < rm.data.length; i++) {
          _lstData.add(rm.data[i]);
        }

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
    });

    // return _lstData;
  }
}
