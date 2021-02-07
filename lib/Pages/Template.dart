import 'dart:async';
import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ovenapp/BusinessObjects/TemplateBO.dart';
import 'package:ovenapp/Classes/AppDialog.dart';
import 'package:ovenapp/Classes/AppToast.dart';
import 'package:ovenapp/Classes/FileLoadHelper.dart';
import 'package:ovenapp/Classes/SharePrefHelper.dart';
import 'package:ovenapp/Controls/AppWidget.dart';

import 'package:ovenapp/Models/ControlPanelModel.dart';
import 'package:ovenapp/Models/HttpRetModel.dart';
import 'package:ovenapp/Models/SectionTimeModel.dart';
import 'package:ovenapp/Models/TemplateModel.dart';
import 'package:ovenapp/Pages/TLDescribePage.dart';
import 'package:ovenapp/Pages/TLRecipePage.dart';
import 'package:ovenapp/Pages/TLSectionPage.dart';
import 'package:ovenapp/Pages/TemplateEditPage.dart';
import 'package:ovenapp/Pages/TimeSectionEditPage.dart';
import 'package:ovenapp/Publics/AppObjHelper.dart';
import 'package:ovenapp/Publics/AppStyle.dart';
import 'package:ovenapp/Publics/DataHelper.dart';
import 'package:ovenapp/Publics/GlobalVar.dart';
import 'package:ovenapp/Services/EventBusSrv.dart';
import 'package:ovenapp/Services/HttpCallerSrv.dart';

class TemplatePageV extends StatefulWidget {
  TemplatePageV({Key key, this.templateModel}) : super(key: key);
  final TemplateModel templateModel;
  // final int id;
  // final int edittype;, this.edittype
  @override
  _TemplatePageState createState() => _TemplatePageState();
}

class _TemplatePageState extends State<TemplatePageV>
    with TickerProviderStateMixin {
  // int id;
  // AutomaticKeepAliveClientMixin
  //SingleTickerProviderStateMixin
  // @override
  // bool get wantKeepAlive => true;

//  bool get automaticKeepAliveClientMixin => true;
  // TabController tabController;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey _appBarKey = new GlobalKey();

  List myTabs;
//, child: Text('说明', style:TextStyle(color: Colors.red,fontSize: 18.0),),
  List<Widget> _lstTabs;

  List<Widget> _lstTabView;

  TemplateModel templateModel;

  Future fData;
  // Map<String, dynamic> mapTabPage;

  final StreamController<TemplateModel> _streamController =
      StreamController<TemplateModel>();

  String spfile;

  @override
  void initState() {
    super.initState();

    print(
        "@@@ => TemplatePage.initState() ... templateModel.id ：${widget.templateModel.id} ");

    // id=widget.templateModel.id;
    spfile = GlobalVar.sptemplate + widget.templateModel.id.toString();
    // mapTabPage = {
    //   "产品说明": TLDescribePage(),
    //   "烘焙时段": TLSectionPage(tid: widget.id),
    //   "原料配方": TLRecipePage()
    // };

    templateModel = TemplateModel();
    templateModel.id = widget.templateModel.id;
    templateModel.name = widget.templateModel.name;
    templateModel.memo = widget.templateModel.memo;
    templateModel.mainpic = widget.templateModel.mainpic;
    templateModel.createdt = widget.templateModel.createdt;
    templateModel.ccpid = widget.templateModel.ccpid;
    templateModel.cname = widget.templateModel.cname;
    templateModel.cid = widget.templateModel.cid;
    templateModel.tscount = widget.templateModel.tscount;
    templateModel.ischare = widget.templateModel.ischare;
    // templateModel=widget.templateModel;

    // _getData();

    myTabs = [
      "烘焙时段",
      "原料配方",
      "产品说明",
    ];

    _lstTabs = [
      Tab(text: myTabs[0]),
      Tab(text: myTabs[1]),
      Tab(text: myTabs[2]),
    ];

    _lstTabView = [
      Container(
        margin: EdgeInsets.only(top: 55.0),
        child: TLSectionPage(id: templateModel.id),
      ),
      TLRecipePage(id: templateModel.id),
      TLDescribePage(id: templateModel.id),
    ];
    // tabController = new TabController(length: 3, vsync: this);
    // tabController.
  }

  @override
  void dispose() {
    super.dispose();
    _streamController.close();
    print("@@@ TemplatePage.dispose() ... ${DateTime.now()}");
    // tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(
        "@@@ ${DateTime.now()} => TemplatePage.build() ... id : ${templateModel.id}");

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          backgroundColor: AppStyle.clTitleBC,
          // leading: _getLeading(),
          title: Text('模板' +
              templateModel.name), //(widget.edittype == 0 ? '编辑' : '新增') +
          actions: _getActions(),
          // actions: _getActions(),
        ),
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              //headerSliverBuilder子控件开始

              _getHeaderWidget(),
              SliverOverlapAbsorber(
                handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                sliver: SliverAppBar(
                  key: _appBarKey,
                  backgroundColor: Colors.grey[100],
                  // leading: Text(''),
                  primary: true,
                  //  brightness: Brightness.dark,
                  titleSpacing: NavigationToolbar.kMiddleSpacing,
                  textTheme: TextTheme(
                      button:
                          TextStyle(color: Colors.red, fontSize: 18.0)), //字体样式
                  centerTitle: true,
                  automaticallyImplyLeading: false,
                  // floating: false,
                  // snap:false,
                  //       flexibleSpace: new FlexibleSpaceBar(
                  //   title: new Text("随内容一起滑动的头部"),
                  //   centerTitle: true,
                  //   collapseMode: CollapseMode.pin,
                  // ),
                  pinned: true, //是否固定导航栏，为true是固定，为false是不固定，往上滑，导航栏可以隐藏
                  forceElevated: innerBoxIsScrolled,

                  // expandedHeight: 40.0, //展开高度200
                  // flexibleSpace: FlexibleSpaceBar(
                  //   centerTitle: true,
                  //   title: Text('我是一个FlexibleSpaceBar'),
                  //   background: Image.network(
                  //     "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1531798262708&di=53d278a8427f482c5b836fa0e057f4ea&imgtype=0&src=http%3A%2F%2Fh.hiphotos.baidu.com%2Fimage%2Fpic%2Fitem%2F342ac65c103853434cc02dda9f13b07eca80883a.jpg",
                  //     fit: BoxFit.cover,
                  //   ),
                  // ),
                  title: TabBar(
                    // labelPadding: EdgeInsets..zero,
                    labelStyle: TextStyle(color: Colors.red),
                    unselectedLabelColor: Colors.blue,
                    unselectedLabelStyle: TextStyle(
                      color: Colors.red,
                      fontSize: 18.0,
                    ),
                    isScrollable: false,
                    tabs: _lstTabs,
                    indicatorColor: Colors.red,
                    indicatorPadding: EdgeInsets.zero,
                    // indicatorWeight: 0.0,
                    // indicatorSize: TabBarIndicatorSize(5.0),
                  ),
                  // ),
                  // ),
                  //去掉此处便能实现隐藏header保存子页滑动的效果
                  // bottom: TabBar(
                  //   isScrollable: true,
                  //   tabs: _lstTabs,
                  // ),

                  // actions: <Widget>[
                  //   IconButton(icon: Icon(Icons.add_circle), onPressed: null),
                  // ],
                ),
              ),

              // SliverFixedExtentList(
              //   itemExtent: 50.0,
              //   delegate: new SliverChildBuilderDelegate(
              //     (context, index) => new ListTile(
              //       title: new Text("Item $index"),
              //     ),
              //     childCount: 30,
              //   ),
              // ),
              //保留区
              // SliverPersistentHeader(
              //     delegate: _SliverAppBarDelegate(TabBar(
              //   labelColor: Colors.red,
              //   unselectedLabelColor: Colors.grey,
              //   tabs: _lstTabs,
              //   controller: TabController(length: 3, vsync: this),
              // ))),

              //headerSliverBuilder子控件结束
            ];
          },
          body: TabBarView(
            children: _lstTabView,
            // myTabs.map((title) {
            //   return mapTabPage[title];
            // }).toList(),
          ),
        ),
        // bottomNavigationBar: _getBottomButtons(),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.redAccent,
          child: const Icon(
            Icons.add,
            size: 36.0,
            color: Colors.white,
          ),
          onPressed: () {
            // 每次点击按钮，更加_counter的值，同时通过Sink将它发送给Stream；
            // 每注入一个值，都会引起StreamBuilder的监听，StreamBuilder重建并刷新counter
            // _streamController.sink.add(++_counter);
            int _tabindex =
                DefaultTabController.of(_scaffoldKey.currentContext).index;
            //DefaultTabController.of(_scaffoldKey.currentState.context).index;
            //DefaultTabController.of(_scaffoldKey.currentContext).index = 1;
            //但是这种方式会有个奇怪的效果，建议换成如下方式：
            //DefaultTabController.of(_scaffoldKey.currentContext).animateTo(index);
            print('@@@ _tabindex : $_tabindex');
            SectionTimeModel sm = SectionTimeModel.getEmptyObj();
            sm.tn = templateModel.id;
            sm.sn = 1;
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => TimeSectionEditPage(
                          tn: sm.tn,
                          sn: TemplateBO.tsCount,
                          edittype: 1,
                          // tid:widget.id,
                          // edittype: 1,
                        ))).then((ret) {
              print('@@@ ret : $ret');
              if (ret != null && ret == 'OK') {
                eventBus.fire(TimeSectionEvent(templateModel.id.toString()));
              }
            });

            // Navigator.of(context).pushNamed("/timesectionedit");
          },
        ),
      ),
    );
  }

  _getActions() {
    return <Widget>[
      IconButton(
          icon: Icon(Icons.refresh),
          color: AppStyle.clTitle2FC,
          iconSize: 28.0,
          onPressed: () {
            _barButtonClick('0');
          }),
      // IconButton(
      //     icon: Icon(Icons.play_arrow),
      //     iconSize: 35.0,
      //     color: AppStyle.clTitle2FC,
      //     onPressed: () {
      //       _barButtonClick('1');
      //     }),
      // IconButton(
      //     icon: Icon(Icons.delete),
      //     color: AppStyle.clTitle2FC,
      //     onPressed: () {
      //       _barButtonClick('2');
      //     }),
      IconButton(
          icon: Icon(Icons.share),
          color: templateModel.ischare == 1
              ? Colors.greenAccent
              : AppStyle.clTitle2FC,
          iconSize: 28.0,
          onPressed: () {
            _barButtonClick('2');
          }),
    ];
  }

  _barButtonClick(ct) {
    // print('@@@ ct => $ct');
    // templateModel.memo = '怨在不舍小过，患在不预定谋。福在积善，祸在积恶。${DateTime.now()}';
    // _streamController.sink.add(templateModel);

    switch (ct) {
      case '0': //刷新
        _refreshData();
        // DataHelpr.removeLocalData(spfile);
        // setState(() {
        //   _getData();
        // });
        break;
      case '1': //运行
        // DataHelpr.removeLocalData(spfile);
        // setState(() {
        //   _getData();
        // });
        Navigator.of(context).pop('RUN');
        break;
      case '2': //共享
        String t = '分享';
        int v = 1;
        if (templateModel.ischare == 1) {
          t = '取消分享';
          v = 0;
        }
        AppDialog.showYesNoIOS(context, '$t 确认', '您确定要 $t 该模板吗？', () {
          HttpCallerSrv.post('Template/Modify',
                  {"ID": templateModel.id, "IsShare": v}, GlobalVar.userInfo.tk)
              .then((f) {
            String jsonData = f;

            Map<String, dynamic> ret = json.decode(jsonData);
            HttpRetModel retmodel = HttpRetModel.fromJsonExec(ret);

            if (retmodel.ret == 0) {
              AppToast.showToast("$t 成功！");
              DataHelpr.removeLocalData(spfile);
              templateModel.ischare = v;
              _streamController.sink.add(templateModel);
              // Navigator.of(context).pop('OK');
            } else {
              AppToast.showToast("$t 失败：${retmodel.message}", 2);
            }
          }).catchError((e) {
            AppToast.showToast("$t 失败：$e", 2);
          }).whenComplete(() {
            // isRun = 0;
          });
          // _refreshData();
        });
        break;
    }
    // final RenderBox box = _appBarKey.currentContext.findRenderObject();
    //   final size = box.size;
    //   final topLeftPosition = box.localToGlobal(Offset.zero);

    //   print('@@@ TemplatePage._barButtonClick() => AppBar.Size :$size / topLeftPosition : $topLeftPosition');
    // return topLeftPosition.dy
// AppObjHelper.getJsonStrFormObj(templateModel);
    // String js = templateModel.toJsonStr();
    // print("@@@ TemplatePage._getDate() templateModel : $js");

    // TemplateModel m = TemplateModel.fromJsonStr(js);

    // print('@@@ TemplatePage._getDate() m.mainpic : ${m.mainpic}');
    // print(
    //     '@@@ DefaultTabController.of(_appBarKey.currentContext).index : ${_appBarKey.currentContext.widget}');
  }

  _refreshData() {
    DataHelpr.removeLocalData(spfile);
    setState(() {
      _getData();
    });
    eventBus.fire(TimeSectionEvent(templateModel.id.toString()));
  }

  _getData() async {
    // print("@@@ TemplatePage._getData() begin --> ${DateTime.now()}");

    var data = DataHelpr.getLocalData(spfile);
    // print("@@@ TLSectionPage._getData() data : $data");
    if (data != null) {
      TemplateModel m;
      try {
        String js = data.toString().replaceAll('\r', '').replaceAll('\n', '');

        //  print(
        //     "@@@ TemplatePage._getData() DataHelpr.getLocalData($spfile) jsonStr: $js");

        m = TemplateModel.fromJsonStr(js);
        _streamController.sink.add(m);
      } catch (e) {
        m = null;
        print(
            "*** TemplatePage._getData() DataHelpr.getLocalData($spfile) err : $e");
      }
      if (m != null) return m;
      // TemplateBO.tsCount = data.length + 1;data;//
    }

    await HttpCallerSrv.get(
            "Template/Info", {"id": templateModel.id}, GlobalVar.userInfo.tk)
        .then((f) {
      try {
        // print("before : " + controlPanelModel.icon);
        // print("@@@ TemplatePage._getDate() f : $f");
        Map map = json.decode(f.toString());

        if (map != null && map["ret"].toString() == "0") {
          HttpRetModel rm = HttpRetModel.fromJson(map, TemplateModel());
          // print("after : " + controlPanelModel.icon);
          TemplateModel templateModel = rm.data[0] as TemplateModel;

          DataHelpr.setLocalData(
              spfile,
              templateModel
                  .toJsonStr()
                  .toString()
                  .replaceAll('\r', '')
                  .replaceAll('\n', ''));
          // print(

          //     "@@@ TemplatePage._getDate() templateModel : ${templateModel.toJsonStr()}");

          _streamController.sink.add(templateModel);
          // print(
          //     "@@@ TemplatePage._getDate() templateModel.mainpic : ${templateModel.mainpic}");
        }
      } catch (e) {
        print("*** TemplatePage._getDate() error : ${e.toString()}");
      }
    }).catchError((e) {
      print("*** TemplatePage._getDate() error : ${e.toString()}");
    });
  }

  // _getContentList() {
  //   List<Widget> _lst = List<Widget>();
  //   _lst.add(_getHeaderWidget());
  //   _lst.add(_getTab());
  //   return _lst;
  // }

  // _getBottomButtons() {
  //   return BottomAppBar(
  //     child: Container(
  //       height: 45.0,
  //       child: Row(
  //         children: <Widget>[
  //           RaisedButton(
  //             onPressed: () {},
  //             child: Text('保存'),
  //           ),
  //           RaisedButton(
  //             onPressed: () {},
  //             child: Text('运行'),
  //           ),
  //           RaisedButton(
  //             onPressed: () {},
  //             child: Text('分享'),
  //           ),
  //           RaisedButton(
  //             onPressed: () {},
  //             child: Text('删除'),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  Widget _getHeaderWidget() {
    return SliverToBoxAdapter(
        child: StreamBuilder<TemplateModel>(
            stream: _streamController.stream,
            initialData:
                templateModel, // *** 注：此处必须有个原始值，不然在数据没有来得及提到首次取值会报错，或者判断监听的对象是否为空，为空表示数据还没有提得到
            builder:
                (BuildContext context, AsyncSnapshot<TemplateModel> snapshot) {
              TemplateModel templateModel = snapshot.data;

              return Container(
                margin: EdgeInsets.only(top: 3.0),
                //padding: EdgeInsets.all(0.0),
                height: 128.0,
                // width: 160.0,
                // color: Colors.deepOrangeAccent,
                child: Row(
                  children: <Widget>[
                    //子控件开始

                    //左边图片
                    GestureDetector(
                      child: AppWidget.getBroadImage(
                          templateModel.mainpic,
                          128.0,
                          134.0,
                          EdgeInsets.all(10.0),
                          EdgeInsets.all(0.0),
                          48.0),
                      // Container(
                      //   height: 128.0,
                      //   width: 134.0,
                      //   margin: EdgeInsets.all(10.0),
                      //   child:
                      //   ClipRRect(
                      //     // clipper: CustomClipper<RRect>(3.0),
                      //     borderRadius: BorderRadius.all(Radius.circular(3.5)),
                      //     clipBehavior: Clip.antiAlias,
                      //     child: AppWidget.getCachImage(GlobalVar.webimageurl +templateModel.mainpic),
                      //   ),
                      // ),
                      onTap: () {
                        _loadImage(context);
                        // AppDialog.showSelectTextItemIOS(
                        //     context, ["从相册选择", "用相机拍照"], (item) {
                        //   if (item == null) return;

                        //   print("@@@ item : $item");

                        //   if (item == "0")
                        //     _getImageFromGallery();
                        //   else
                        //     _getImageFromCamera();
                        // });
                      },
                    ),

                    //右边文字
                    Expanded(
                      child: GestureDetector(
                        child: Container(
                          margin: EdgeInsets.only(
                              left: 5.0, top: 15.0, right: 12.0, bottom: 12.0),
                          alignment: Alignment.topLeft,
                          // color: Colors.greenAccent,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                // height: 32.0,
                                margin: EdgeInsets.only(bottom: 8.0),
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  templateModel.name, // '高档手撕面包',
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    color: AppStyle.clTitle1FC,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  alignment: Alignment.topLeft,
                                  // height: 32.0,
                                  // color: Colors.limeAccent,
                                  child: Text(
                                    templateModel.memo == null ||
                                            templateModel.memo == ''
                                        ? '模板说明 ...'
                                        : templateModel.memo,
                                    maxLines: 4,
                                    style: TextStyle(
                                      fontSize: 16.5,
                                      color: AppStyle.clTitle2FC,
                                    ),
                                    softWrap: true,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => TemplateEditPage(
                                        id: templateModel.id,
                                        name: templateModel.name,
                                        memo: templateModel.memo,
                                      ))).then((ret) {
                            print('@@@ ret : $ret');
                            if (ret != null && ret == 'OK') {
                              templateModel.name =
                                  GlobalVar.tempData['templatename'];
                              templateModel.memo =
                                  GlobalVar.tempData['templatememo'];
                              _streamController.sink.add(templateModel);
                              GlobalVar.tempData.remove('templatename');
                              GlobalVar.tempData.remove('templatememo');
                            }
                          });
                        },
                      ),
                    ),

                    //子控件结束
                  ],
                ),
              );
            }));
  }

  _loadImage(context) {
    var fparam = {
      "ot": 0,
      "tb": "Template",
      "rid": templateModel.id, //.replaceAll("/", ""),
      "fn": "MainPic",
    };

    FileLoadHelper.selectPicture(context, fparam, (path) {}, (f) {
      HttpRetModel rm = f as HttpRetModel; // HttpRetModel.getExecRet(f);
      print('@@@ TemplatePage._loadImage() rm : ${rm.message}');
      if (rm.ret == 0) {
        templateModel.mainpic = rm.message;
        _streamController.sink.add(templateModel);
      } else {
        AppToast.showToast(rm.message);
      }
    });
  }

  Widget _getTab() {
    return Expanded(
      child: Container(
        // constraints: BoxConstraints.tightFor(width:111.0,height:111.0),
        height: 250.0,
        width: double.infinity,
        color: Colors.red,
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;

  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
