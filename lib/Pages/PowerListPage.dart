import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
// import 'package:ovenapp/BusinessObjects/AppBO.dart';

import 'package:ovenapp/Models/DeviceModel.dart';
// import 'package:ovenapp/Models/AttentionModel.dart';
import 'package:ovenapp/Models/PowerListModel.dart';
import 'package:ovenapp/Pages/PowerDetailPage.dart';
import 'package:ovenapp/Publics/AppStyle.dart';
import 'package:ovenapp/Publics/DateTimeHelper.dart';
import 'package:ovenapp/Publics/MyControl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:ovenapp/Controls/AppWidget.dart';
import 'package:ovenapp/Models/HttpRetModel.dart';
import 'package:ovenapp/Publics/DataHelper.dart';
// import 'package:ovenapp/Publics/GlobalVar.dart';

class PowerListPage extends StatefulWidget {
  PowerListPage({Key key, this.deviceModel}) : super(key: key);
  final DeviceModel deviceModel;
  // final List<dynamic> lstControlPanel; this.lstControlPanel,
  @override
  _PowerListPageState createState() => _PowerListPageState();
}

class _PowerListPageState extends State<PowerListPage> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  final StreamController<double> _streamController = StreamController<double>();

  void _onRefresh() async {
    print('@@@ PowerListPage._onRefresh() _isRefreshable : $_isRefreshable');
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
        '@@@ PowerListPage._onLoading() _pagecount : $_pagecount , _pn : $_pn');
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

  @override
  void initState() {
    super.initState();

    // spfile = GlobalVar.spexplore;

    _getData();
    // _initData(); //缓存第一包数据的情况
    _controller.addListener(() {
      // print(
      //     "@@@ => PowerListPage._controller.Listener() _controller.position.pixels : ${_controller.position.pixels} ");
      if (_controller.position.pixels > 300 && _dFABHeight == 0.0) {
        _dFABHeight = 40.0;
        _streamController.sink.add(_dFABHeight);
      } else if (_controller.position.pixels < 300 && _dFABHeight == 40.0) {
        _dFABHeight = 0.0;
        _streamController.sink.add(_dFABHeight);
      }
    });

    // _onPageDataEvent = eventBus.on<PageDataEvent>().listen((event) {
    //   if (event.page == 'PowerListPage') {
    //     _getData();
    //   }
    // });
    // _getData();
    print("@@@ => PowerListPage.initState() ... ");
  }

  @override
  void dispose() {
    super.dispose();
    // _onPageDataEvent.cancel();
    // _controller.dispose();
    _streamController.close();
    print("@@@ PowerListPage.dispose() ...");
  }

  double _dItemHeight = 50.0;
  double _dFABHeight = 0.0;
  ScrollController _controller = ScrollController();

// class PowerListPage extends StatelessWidget {
  // final double _power=3.0;
  // final bool _isOpen=false;
  @override
  Widget build(BuildContext context) {
    print("@@@ PowerListPage.build() ...");

    return Scaffold(
      appBar: AppBar(
        // backgroundColor: AppStyle.mainBackgroundColor,
        title: Text('[${widget.deviceModel.name}]'), //耗电量报表
        elevation: 0.0,
        actions: _getActions(),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48.0),
          child: Theme(
            data: Theme.of(context).copyWith(accentColor: Colors.white),
            child: Container(
              // color: Colors.yellowAccent,
              height: 48.0,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(color: Colors.grey[200], width: 1.0),
                ), //灰色的一层边框
              ),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      // color: Colors.tealAccent,
                      // height: 30.0,
                      margin: EdgeInsets.only(left: 10.0),
                      width: 180.0,
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '日期',
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.grey,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),

//运行时长
                  Container(
                    // color: Colors.orange,
                    // height: 30.0,
                    // width: 180.0,
                    width: 100.0,
                    alignment: Alignment.centerRight,
                    child: Text(
                      '运行时长',
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.grey,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),

//耗电量
                  Container(
                    // color: Colors.pinkAccent,
                    // height: 30.0,
                    width: 90.0,
                    // width: 180.0,
                    alignment: Alignment.centerRight,
                    child: Text(
                      '耗电量',
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.grey,
                      ),
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.right,
                    ),
                  ),
                  SizedBox(
                    width: 35,
                  ),
                  //  Container(
                  //   // color: Colors.pinkAccent,
                  //   // height: 30.0,
                  //   // width: 100.0,
                  //   // width: 180.0,
                  //   margin: EdgeInsets.only(right: 5.0),
                  //   alignment: Alignment.centerRight,
                  //   child: Text(
                  //     '   ',
                  //     style: TextStyle(
                  //       fontSize: 18.0,
                  //       color: Colors.grey,
                  //     ),
                  //     overflow: TextOverflow.ellipsis,
                  //   ),
                  // ),

                  // Text('日期'),
                  // Text('运行时长'),
                  // Text('耗电量'),
                  // Text('明细'),
                ],
              ),
            ),
          ),
        ),
        // actions: _getActions(),
        shape: AppWidget.getAppBarBottomBorder(),
      ),
      body: SafeArea(
        minimum: EdgeInsets.only(top: 2.0),
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

  List<Widget> _getActions() {
    return <Widget>[
      // IconButton(icon: Icon(Icons.search),tooltip: '搜索', iconSize: 35, onPrssed: null),//标题右侧按钮
      IconButton(
          icon: Icon(
            Icons.format_list_numbered,
            color: AppStyle.clButtonGray,
          ),
          // tooltip: '新增设备',
          iconSize: 28.0,
          onPressed: () {
            _showDetail();
            // ApkHelper.deleteApkFile();
            // print('@@@ DevicePage ApkHelper.isfinished : ${ApkHelper.isfinished}');
          }),
      // IconButton(
      //     icon: Icon(
      //       Icons.refresh,
      //       color: AppStyle.clButtonGray,
      //     ),
      //     // tooltip: '刷新',
      //     iconSize: 28.0,
      //     onPressed: () {
      //       // SharePrefHelper.removeData(GlobalVar.spdevice);
      //       // setState(() {});
      //       // GlobalVar.playWarnAudio(context, '05DAFF333136595043187617');
      //       // GlobalVar.playWarnAudio(context);
      //       _refreshData();
      //       // ApkHelper.deleteApkFile() ;
      //       // ApkHelper.installApk('/storage/emulated/0/Android/data/com.example.ovenapp/files/cleveroven.apk');
      //     }), //标题右侧按钮
      // IconButton(
      //     icon: Icon(
      //       Icons.widgets,
      //       color: AppStyle.clButtonGray,
      //     ),
      //     // tooltip: '刷新',
      //     iconSize: 28.0,
      //     onPressed: () {
      //       DeviceBO.getPower();
      //     }),
    ];
  }

  _showDetail() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                PowerDetailPage(deviceModel: widget.deviceModel)));
  }

  _getFABHeight() {
    // print("@@@ PowerListPage._getFABHeight() _dFABHeight : $_dFABHeight");
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
              heroTag: 'powerlistgotop',
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
    // print('@@@ PowerListPage._getBodyUI() begin ... ');
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
      height: 1.0,
      color: Colors.grey[400],
      indent: 0.0,
      endIndent: 0.0,
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
    PowerListModel am = _lstData[_index] as PowerListModel;
    // return ListTile(
    //   title: Text(
    //     tm.title,
    //   ),
    // );
    // print('@@@ memo : ${tm.memo}');
    return Container(
      height: _dItemHeight,
      width: double.infinity,
      // color: Colors.cyan,
      margin: EdgeInsets.only(left: 8.0),
      child: Row(
        children: <Widget>[
          //日期
          Expanded(
            child: Container(
              // color: Colors.tealAccent,
              // height: 30.0,
              // width: 180.0,
              alignment: Alignment.centerLeft,
              child: Text(
                am.dt,
                style: TextStyle(
                  fontSize: 19.0,
                  color: Colors.black87,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),

//运行时长
          Container(
            // color: Colors.orange,
            // height: 30.0,
            // width: 180.0,
            width: 110.0,
            alignment: Alignment.centerRight,
            child: Text(
              DateTimeHelper.getHMFromSec(am.worktimes),
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),

//耗电量
          Container(
            // color: Colors.pinkAccent,
            // height: 30.0,
            width: 100.0,
            // width: 180.0,
            alignment: Alignment.centerRight,
            child: Text(
              '${am.power}',
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.deepOrangeAccent,
                fontWeight: FontWeight.bold,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),

          Container(
            // color: Colors.pinkAccent,
            // height: 30.0,
            // width: 100.0,
            width: 30.0,
            margin: EdgeInsets.only(right: 5.0, bottom: 10.0),
            alignment: Alignment.bottomRight,
            child: Text(
              ' 度',
              style: TextStyle(
                fontSize: 17.0,
                color: Colors.grey,
                // fontWeight: FontWeight.bold,kW·h
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),

          // Expanded(
          //   child: GestureDetector(
          //     child: Container(
          //       height: double.infinity,
          //       width: double.infinity,
          //       margin: EdgeInsets.only(top: 5.0, bottom: 5.0),
          //       child: Column(
          //         children: <Widget>[

          //           Expanded(
          //             child: Container(
          //               // color: Colors.orangeAccent,
          //               height: 30.0,
          //               alignment: Alignment.topLeft,
          //               child: Text(
          //                 am.worktimes.toString(),
          //                 style: TextStyle(fontSize: 16.0, color: Colors.grey),
          //                 overflow: TextOverflow.ellipsis,
          //                 softWrap: true,
          //                 maxLines: 2,
          //               ),
          //             ),
          //           ),
          //         ],
          //       ),
          //     ),
          //     onTap: () {
          //       // _showDetail(am.id);
          //     },
          //   ),
          // ),

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
          // Container(
          //   // color: Colors.orangeAccent,
          //   // alignment: Alignment.centerLeft,
          //   width: 45.0,
          //   child: IconButton(
          //       // color: AppStyle.clButtonGray,
          //       icon: Icon(
          //         Icons.keyboard_arrow_right,
          //         size: 28.0,
          //         color: Colors.grey[400],
          //       ),
          //       // iconSize: 26.0,
          //       padding: EdgeInsets.all(0.0),
          //       onPressed: () {
          //         // _attentUser(am.id);
          //       }),
          // ),
          // onTap: () {
          //   Navigator.push(context,
          //       MaterialPageRoute(builder: (context) => TemplatePage(tm: tm)));
          // },
        ],
      ),
    );
  }

  _getData() async {
    // GlobalVar.exploreState = 2;

    print('@@@ PowerListPage._getData _pagecount : $_pagecount , _pn : $_pn');

    //  GlobalVar.userInfo.id + 'templates';
    // if (_pn == 0) {}

    if (_pagecount < _pn) return;
//"ids",  "qt", "dt", "begindt","enddt", "pageno", "orderby"
    var param = {
      "pageno": _pn + 1,
      // "qt": 0,
      // "dt": 0,
      "deviceid": widget.deviceModel.id,
      "orderby": "dt DESC",
    };

    await DataHelpr.dataQuerier('Power/Device', param, [PowerListModel()],
        (ret) {
      HttpRetModel rm = ret as HttpRetModel;
      print(
          '@@@ PowerListPage._getData cloud data rm.pagecount : ${rm.pagecount} , rm.totalcount : ${rm.totalcount} , data.length : ${rm.data.length}');
      if (rm.ret == 0) {
        // _totalcount = rm.totalcount;
        if (_lstData == null) _lstData = [];
        _pagecount = rm.pagecount;

        // print('@@@ PowerListPage._getData _pagecount:$_pagecount , _pn:$_pn');

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
      //     '@@@ PowerListPage._getData _lstData.length : ${_lstData.length}, _pn:$_pn');
    });

    // return _lstData;
  }
}
