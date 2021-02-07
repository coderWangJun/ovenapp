import 'dart:async';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ovenapp/Controls/AppWidget.dart';
import 'package:ovenapp/Models/HttpRetModel.dart';
import 'package:ovenapp/Models/VideoModel.dart';
import 'package:ovenapp/Pages/VideoPlayerPage.dart';
import 'package:ovenapp/Publics/DataHelper.dart';
import 'package:ovenapp/Publics/GlobalVar.dart';
import 'package:ovenapp/Publics/MyControl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class VideoListPage extends StatefulWidget {
  @override
  _VideoListPageState createState() => _VideoListPageState();
}

class _VideoListPageState extends State<VideoListPage>
    with AutomaticKeepAliveClientMixin {

//       使用TabBar同样存在TabBarView重新build的问题，解决方案一样，加一个PageStorageKey：

// child: new Container(
//     key: new PageStorageKey(page.country),
//     child: new Newsfeed(country: page.country),
// ),
  // List<dynamic> _lstData;
  int ft = 0; //条件过滤 0全部，1模板，2心得
  var _scaffoldkey = GlobalKey<ScaffoldState>();
  // var _onPageDataEvent;
  // String searchStr = '';
  double _dItemWidth;
  double _dItemHeight;

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  final StreamController<double> _streamController = StreamController<double>();

  @override
  bool get wantKeepAlive => true;

  void _onRefresh() async {
    print('@@@ VideoListPage._onRefresh() _isRefreshable : $_isRefreshable');
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
    print('@@@ VideoListPage._onLoading() _pagecount : $_pagecount , _pn : $_pn');
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

    _dItemWidth = GlobalVar.dScreenWidth - 1.0;
    _dItemHeight = (_dItemWidth * 4) / 3;
    // spfile = GlobalVar.spexplore;

    _getData();
    // _initData(); //缓存第一包数据的情况
    _controller.addListener(() {
      // print(
      //     "@@@ => VideoPage._controller.Listener() _controller.position.pixels : ${_controller.position.pixels} ");
      if (_controller.position.pixels > 300 && _dFABHeight == 0.0) {
        _dFABHeight = 40.0;
        _streamController.sink.add(_dFABHeight);
      } else if (_controller.position.pixels < 300 && _dFABHeight == 40.0) {
        _dFABHeight = 0.0;
        _streamController.sink.add(_dFABHeight);
      }
    });

    // _onPageDataEvent = eventBus.on<PageDataEvent>().listen((event) {
    //   if (event.page == 'VideoPage') {
    //     _getData();
    //   }
    // });
    // _getData();
    print("@@@ VideoListPage.initState() ... ");
  }

  @override
  void dispose() {
    super.dispose();
    // _onPageDataEvent.cancel();
    // _controller.dispose();
    _streamController.close();
    print("@@@ VideoListPage.dispose() ...");
  }

  // double _dItemHeight = 80.0;
  double _dFABHeight = 0.0;
  ScrollController _controller = ScrollController();

// class VideoPage extends StatelessWidget {
  // final double _power=3.0;
  // final bool _isOpen=false;
  @override
  Widget build(BuildContext context) {
    super.build(context);

    // _dItemWidth = MediaQuery.of(context).size.width - 1.0;
    // _dItemHeight = (_dItemWidth * 4) / 3;

    // GlobalVar.getScreenSize(context,'VideoListPage');_dItemWidth : $_dItemWidth , _dItemHeight : $_dItemHeight

    print(
        "@@@ VideoListPage.build() ... ");
    return Scaffold(
      key: _scaffoldkey,
      body: SafeArea(
        minimum: EdgeInsets.only(top: 0.0),
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
    // print("@@@ VideoPage._getFABHeight() _dFABHeight : $_dFABHeight");
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
              heroTag: 'videogotop',
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
    // print('@@@ VideoPage._getBodyUI() begin ... ');
    if (_lstData == null)
      return MyControl.waitingWidget(); // AppWidget.getCircularProgress();

    if (_lstData.length == 0)
      return AppWidget.getEmptyData(() {
        _refreshData();
      });

    // return ListView.builder(itemCount: _list.length, itemBuilder: _itemBuilder);  _getListViewUI();// || GlobalVar.exploreState == 1
    return _getGridUI();
  }

  // List<Widget> _getActions() {
  //   return <Widget>[
  //     // IconButton(icon: Icon(Icons.search),tooltip: '搜索', iconSize: 35, onPrssed: null),//标题右侧按钮
  //     FlatButton(
  //       child: Text(
  //         '条件过滤',
  //         style: const TextStyle(
  //           color: Colors.blueAccent,
  //           fontSize: 18.0,
  //           decoration: TextDecoration.underline,
  //           decorationColor: Colors.blueAccent,
  //         ),
  //       ),
  //       onPressed: () {
  //         _popMenu(context);
  //       },
  //     ),

  //     // IconButton(
  //     //     icon: Icon(
  //     //       Icons.add,
  //     //       color: AppStyle.clButtonGray,
  //     //     ),
  //     //     // tooltip: '新增设备',
  //     //     iconSize: 32.0,
  //     //     onPressed: () {
  //     //       _showPopupMenuButton();
  //     //     }),
  //   ];
  // }

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

    _getData();
  }

  _getGridUI() {
    return GridView.builder(
      itemCount: _lstData.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          //横轴元素个数
          crossAxisCount: 2,
          //纵轴间距
          mainAxisSpacing: 1.0,
          //横轴间距
          crossAxisSpacing: 1.0,
          //子组件宽高长度比例
          childAspectRatio: 0.75,
          ),
      itemBuilder: (BuildContext context, int index) {
        return _getUnitUI(index);
      },
    );
  }

  _getUnitUI(_index) {
    VideoModel vm = _lstData[_index] as VideoModel;
    // print('@@@ memo : ${tm.memo}');
    return GestureDetector(
      child: Container(
        height: _dItemHeight,
        width: _dItemWidth,
        // color: Colors.cyan,
        margin: EdgeInsets.only(left: 0.0),
        child:
            Image.network(GlobalVar.webimageurl + vm.mainpic, fit: BoxFit.fill),
      ),
      onTap: () {
        _playVideo(vm);
      },
    );
  }

  _playVideo(VideoModel vm) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VideoPlayerPage(
            vfile: 'https://www.cfdzkj.com:811/webimages/${vm.url}'),
      ),
    );
  }

  _getData() async {
    print('@@@ VideoPage._getData _pagecount : $_pagecount , _pn : $_pn');

    //  GlobalVar.userInfo.id + 'templates';
    // if (_pn == 0) {}

    if (_pagecount < _pn) return;

    var param = {
      "pageno": _pn + 1,
      "orderby": "CreateDT DESC",
      // "querystr": searchStr.trim(),
    };

    await DataHelpr.dataQuerier('Video/List', param, [VideoModel()], (ret) {
      HttpRetModel rm = ret as HttpRetModel;
      print(
          '@@@ VideoPage._getData cloud data rm.pagecount : ${rm.pagecount} , rm.totalcount : ${rm.totalcount} , data.length : ${rm.data.length}');
      if (rm.ret == 0) {
        // _totalcount = rm.totalcount;
        if (_lstData == null) _lstData = [];
        _pagecount = rm.pagecount;

        // print('@@@ VideoPage._getData _pagecount:$_pagecount , _pn:$_pn');

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
      //     '@@@ VideoPage._getData _lstData.length : ${_lstData.length}, _pn:$_pn');
    }, (_pn == 0 ? spfile : ''));
  }
}
