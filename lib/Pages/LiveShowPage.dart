import 'dart:async';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:ovenapp/Models/AttentionModel.dart';
import 'package:ovenapp/Pages/LivePage.dart';
import 'package:ovenapp/Publics/MyControl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:ovenapp/Controls/AppWidget.dart';
import 'package:ovenapp/Models/HttpRetModel.dart';
import 'package:ovenapp/Publics/DataHelper.dart';
import 'package:ovenapp/Publics/GlobalVar.dart';

class LiveShowPage extends StatefulWidget {
  @override
  _LiveShowPageState createState() => _LiveShowPageState();
}

class _LiveShowPageState extends State<LiveShowPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  final StreamController<double> _streamController = StreamController<double>();

  void _onRefresh() async {
    print('@@@ LiveShowPage._onRefresh() _isRefreshable : $_isRefreshable');
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
        '@@@ LiveShowPage._onLoading() _pagecount : $_pagecount , _pn : $_pn');
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
  // String spfile;
  // var _onPageDataEvent;
  // double dItemHeight;
  double _dItemWidth;

  @override
  void initState() {
    super.initState();

    // spfile = GlobalVar.spexplore;
    _dItemWidth = GlobalVar.dScreenWidth;
    _dItemHeight = _dItemWidth;

    _getData();
    // _initData(); //缓存第一包数据的情况
    _controller.addListener(() {
      // print(
      //     "@@@ => LiveShowPage._controller.Listener() _controller.position.pixels : ${_controller.position.pixels} ");
      if (_controller.position.pixels > 300 && _dFABHeight == 0.0) {
        _dFABHeight = 40.0;
        _streamController.sink.add(_dFABHeight);
      } else if (_controller.position.pixels < 300 && _dFABHeight == 40.0) {
        _dFABHeight = 0.0;
        _streamController.sink.add(_dFABHeight);
      }
    });

    // _onPageDataEvent = eventBus.on<PageDataEvent>().listen((event) {
    //   if (event.page == 'LiveShowPage') {
    //     _getData();
    //   }
    // });
    // _getData();
    print("@@@ => LiveShowPage.initState() ... ");
  }

  @override
  void dispose() {
    super.dispose();
    // _onPageDataEvent.cancel();
    // _controller.dispose();
    _streamController.close();
    print("@@@ LiveShowPage.dispose() ...");
  }

  double _dItemHeight = 80.0;
  double _dFABHeight = 0.0;
  ScrollController _controller = ScrollController();

// class LiveShowPage extends StatelessWidget {
  // final double _power=3.0;
  // final bool _isOpen=false;
  @override
  Widget build(BuildContext context) {
    super.build(context);

    print("@@@ LiveShowPage.build() ...");

    return Scaffold(
      body: SafeArea(
        minimum: EdgeInsets.only(bottom: 20.0),
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
    // print("@@@ LiveShowPage._getFABHeight() _dFABHeight : $_dFABHeight");
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
              heroTag: 'liveshowgotop',
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
    // print('@@@ LiveShowPage._getBodyUI() begin ... ');
    if (_lstData == null)
      return MyControl.waitingWidget(); // AppWidget.getCircularProgress();

    if (_lstData.length == 0)
      return AppWidget.getEmptyData(() {
        _refreshData();
      });

    // return ListView.builder(itemCount: _list.length, itemBuilder: _itemBuilder);  _getListViewUI();// || GlobalVar.exploreState == 1
    return _getListUI();
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
    Timer(Duration(seconds: 5), () {
      _isRefreshable = 1;
    });
    _lstData.clear();
    _pn = 0;
    _pagecount = 100000;
    _getData();
  }

  _getListUI() {
    Widget divider1 = Divider(
      height: 0.0,
      color: Colors.transparent,
      indent: 75.0,
      endIndent: 15.0,
    );

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
    AttentionModel am = _lstData[_index] as AttentionModel;
    // return ListTile(
    //   title: Text(
    //     tm.title,
    //   ),
    // );
    // print('@@@ memo : ${tm.memo}');
    double dSpace = 2.0;
    return GestureDetector(
      child: Container(
        margin: EdgeInsets.only(
          left: dSpace,
          right: dSpace,
          top: dSpace,
        ),
        alignment: Alignment.centerLeft,
        height: _dItemHeight,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(GlobalVar.webimageurl + am.livepic),
            fit: BoxFit.cover,
          ),
          //  border: Border.all(color: Colors.grey[300], width: 1.0), //灰色的一层边框
          // color: Colors.tealAccent,
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
        ),
        // color: Colors.cyan,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(child: Text('')),
            Text(
              '${am.name}',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
              ),
            ),
            Text(
              'my maxim : ${am.livetitle}',
              style: TextStyle(
                color: Colors.white54,
                fontSize: 18.0,
              ),
            ),
          ],
        ),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LivePage(),
          ),
        );
      },
    );
  }

  _getData() async {
    // GlobalVar.exploreState = 2;

    print('@@@ LiveShowPage._getData _pagecount : $_pagecount , _pn : $_pn');

    //  GlobalVar.userInfo.id + 'templates';
    // if (_pn == 0) {}

    if (_pagecount < _pn) return;

    var param = {
      "pageno": _pn + 1,
      "orderby": "name",
    };

    await DataHelpr.dataQuerier('Attention/List', param, [AttentionModel()],
        (ret) {
      HttpRetModel rm = ret as HttpRetModel;
      print(
          '@@@ LiveShowPage._getData cloud data rm.pagecount : ${rm.pagecount} , rm.totalcount : ${rm.totalcount} , data.length : ${rm.data.length}');
      if (rm.ret == 0) {
        // _totalcount = rm.totalcount;
        if (_lstData == null) _lstData = [];
        _pagecount = rm.pagecount;

        // print('@@@ LiveShowPage._getData _pagecount:$_pagecount , _pn:$_pn');

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
      //     '@@@ LiveShowPage._getData _lstData.length : ${_lstData.length}, _pn:$_pn');
    });

    // return _lstData;
  }
}
